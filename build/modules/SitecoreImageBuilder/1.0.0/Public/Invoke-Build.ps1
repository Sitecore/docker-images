class ReportRecord
{
    [string]$Name
    [string]$Time
    [int]$Index

    ReportRecord([string]$Name, [string]$Time, [int]$Index)
    {
        $this.Name = $Name
        $this.Time = $Time
        $this.Index = $Index
    }
}

function Invoke-Build
{
    [CmdletBinding(SupportsShouldProcess = $true)]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidUsingPlainTextForPassword", "SitecorePassword")]
    param(
        [Parameter(Mandatory = $true)]
        [ValidateScript( { Test-Path $_ -PathType "Container" })]
        [string]$Path
        ,
        [Parameter(Mandatory = $true)]
        [ValidateScript( { Test-Path $_ -PathType "Container" })]
        [string]$InstallSourcePath
        ,
        [Parameter(Mandatory = $false)]
        [string]$Registry
        ,
        [Parameter(Mandatory = $false)]
        [string]$SitecoreRegistry
        ,
        [Parameter(Mandatory = $false)]
        [array]$Tags
        ,
        [Parameter(Mandatory = $false)]
        [array]$AutoGenerateWindowsVersionTags = (Get-SupportedWindowsVersions)
        ,
        [Parameter(Mandatory = $false)]
        [ValidateSet("Include", "Skip")]
        [string]$ImplicitTagsBehavior = "Include"
        ,
        [Parameter(Mandatory = $false)]
        [ValidateSet("Include", "Skip")]
        [string]$DeprecatedTagsBehavior = "Skip"
        ,
        [Parameter(Mandatory = $false)]
        [ValidateSet("Include", "Skip")]
        [string]$ExperimentalTagBehavior = "Skip"
        ,
        [Parameter(Mandatory = $false)]
        [ValidateSet("WhenChanged", "Always", "Never")]
        [string]$PushMode = "WhenChanged"
        ,
        [Parameter(Mandatory = $false)]
        [ValidateSet("Always", "Never")]
        [string]$PullMode = "Always"
        ,
        [Parameter(Mandatory = $false)]
        [switch]$SkipHashValidation
        ,
        [Parameter(Mandatory = $false)]
        [ValidateSet("ForceHyperV", "EngineDefault", "ForceProcess", "ForceDefault")]
        [string]$IsolationModeBehaviour = "ForceHyperV"
        ,
        [Parameter(Mandatory = $false)]
        [switch]$IncludeShortTags
    )

    # Setup
    $ErrorActionPreference = "STOP"
    $ProgressPreference = "SilentlyContinue"

    $watch = [System.Diagnostics.StopWatch]::StartNew()
    $reportRecords = [System.Collections.Generic.List[ReportRecord]]@()

    # Load packages
    $packages = Get-Packages

    $allSpecs = Get-BuildSpecifications -Path $Path -AutoGenerateWindowsVersionTags $AutoGenerateWindowsVersionTags

    if ($Tags -eq $null)
    {
        $Tags = Get-LatestSupportedVersionTags -Specs $allSpecs
    }

    # Find out what to build
    $specs = Initialize-BuildSpecifications -Specifications $allSpecs -InstallSourcePath $InstallSourcePath -Tags $Tags -ImplicitTagsBehavior $ImplicitTagsBehavior -DeprecatedTagsBehavior $DeprecatedTagsBehavior -ExperimentalTagBehavior $ExperimentalTagBehavior

    # Replace ${sitecore_registry} with appropriate value, if applicable
    $specs = Update-SitecoreRegistry -specs $specs -SitecoreRegistry $SitecoreRegistry

    # Print results
    if ($PSCmdlet.MyInvocation.BoundParameters["Verbose"].IsPresent)
    {
        $specs | Select-Object -Property Tag, Include, Deprecated, Priority, Base | Format-Table
    }
    else
    {
        $specs | Where-Object { $_.Include -eq $true } | Select-Object -Property Tag, Priority, Base | Format-Table
    }
    # Determine OS (windows or linux)
    $osType = (docker system info --format '{{json .}}' | ConvertFrom-Json | ForEach-Object { $_.OSType })

    Write-Message "Build specifications loaded..." -Level Info

    # Pull latest external images
    if ($PSCmdlet.ShouldProcess("Pull latest images"))
    {
        if ($PullMode -eq "Always")
        {
            $baseImages = @()

            # Find external base images of included specifications
            $specs | Where-Object { $_.Include -eq $true } | ForEach-Object {
                $spec = $_

                $spec.Base | Where-Object { $_.Contains("/") -eq $true -and -not $_.StartsWith("community") } | ForEach-Object {
                    $baseImages += $_
                }
            }

            # Pull images
            $baseImages | Select-Object -Unique | ForEach-Object {
                $tag = $_

                docker image pull $tag

                $LASTEXITCODE -ne 0 | Where-Object { $_ } | ForEach-Object { throw ("Failed. {0}" -f $tag) }

                Write-Message ("External image '{0}' is latest." -f $tag) -Level Debug
            }

            Write-Message "External images are up to date..." -Level Debug
        }
        else
        {
            Write-Message ("Pulling external images skipped since PullMode was '{0}'." -f $PullMode) -Level Warning
        }
    }


    # Start build...
    if ($PSCmdlet.ShouldProcess("Start image builds"))
    {
        $currentCount = 0
        $totalCount = $specs | Where-Object { $_.Include } | Measure-Object | Select-Object -ExpandProperty Count
        $specs | Where-Object { $_.Include } | ForEach-Object {
            $spec = $_
            $tag = $spec.Tag
            $currentCount++
            Write-Message "Processing $($currentCount) of $($totalCount) '$($tag)'..."

            $currentWatch = [System.Diagnostics.StopWatch]::StartNew()

            # Save the digest of previous builds for later comparison
            $previousDigest = $null

            if ((docker image ls $tag --quiet))
            {
                $previousDigest = (docker image inspect $tag) | ConvertFrom-Json | ForEach-Object { $_.Id }
            }

            # Copy any missing source files into build context
            $spec.Sources | ForEach-Object {
                $sourcePath = $_

                # Continue if source file doesn't exist
                if (!(Test-Path $sourcePath))
                {
                    Write-Message "Optional source file '$sourcePath' is missing..." -Level Warning

                    return
                }

                $sourceItem = Get-Item -Path $sourcePath
                $targetPath = Join-Path $spec.Path $sourceItem.Name

                # Copy if target doesn't exist. Legacy support: Always copy if the source is license.xml.
                if (!(Test-Path -Path $targetPath) -or ($sourceItem.Name -eq "license.xml"))
                {
                    Copy-Item $sourceItem -Destination $targetPath -Verbose:$VerbosePreference
                }

                # Check to see if we can lookup the hash of the source filename in sitecore-packages.json
                if (!$SkipHashValidation)
                {
                    $package = $packages."$($sourceItem.Name)"

                    if ($null -ne $package -and ![string]::IsNullOrEmpty($package.hash))
                    {
                        $expectedTargetFileHash = $package.hash

                        # Calculate hash of target file
                        $currentTargetFileHash = Get-FileHash -Path $targetPath -Algorithm "SHA256" | Select-Object -ExpandProperty "Hash"

                        # Compare hashes and fail if not the same
                        if ($currentTargetFileHash -eq $expectedTargetFileHash)
                        {
                            Write-Message ("Hash of '{0}' is valid." -f $sourceItem.Name) -Level Debug
                        }
                        else
                        {
                            Remove-Item -Path $targetPath -Force -Verbose:$VerbosePreference

                            throw ("Hash of '{0}' is invalid:`n Expected: {1}`n Current : {2}`nThe target file '{3}' was deleted, please also check the source file '{4}' and see if it is corrupted, if so delete it and try again." -f $sourceItem.Name, $expectedTargetFileHash, $currentTargetFileHash, $targetPath, $sourceItem.FullName)
                        }
                    }
                    else
                    {
                        Write-Message ("Skipping hash validation on '{0}', package was not found or no hash was defined." -f $sourceItem.Name) -Level Verbose
                    }
                }
            }

            # Build image
            $buildOptions = New-Object System.Collections.Generic.List[System.Object]

            if ($osType -ieq "windows" -and $IsolationModeBehaviour -ieq "ForceHyperV")
            {
                # --isolation 'hyperv' | makes sense on windows host only?
                $buildOptions.Add("--isolation 'hyperv'")
            }
            elseif ($osType -ieq "windows" -and $IsolationModeBehaviour -ieq "ForceProcess")
            {
                # --isolation 'process' | works only on windows
                $buildOptions.Add("--isolation 'process'")
            }
            elseif ($osType -ne "windows" -and $IsolationModeBehaviour -ieq "ForceDefault")
            {
                # --isolation 'default' | works on non-windows
                $buildOptions.Add("--isolation 'default'")
            }
            else
            {
                # no --isolation option | also use engine default if none of the above has been selected
            }

            $spec.BuildOptions | ForEach-Object {
                $option = $_

                $buildOptions.Add($option)
            }

            $buildOptions.Add("--tag '$tag'")

            if ($tag -match "linux")
            {
                $buildOptions.add("--platform linux")
            }
            $buildCommand = "docker image build {0} '{1}'" -f ($buildOptions -join " "), $spec.Path

            Write-Message ("Invoking: {0} " -f $buildCommand) -Level Verbose -Verbose:$VerbosePreference

            & ([scriptblock]::create($buildCommand))

            $LASTEXITCODE -ne 0 | Where-Object { $_ } | ForEach-Object { throw "Failed: $buildCommand" }

            $currentWatch.Stop()
            Write-Message "Build completed for $($tag). Time: $($currentWatch.Elapsed.ToString("hh\:mm\:ss\.fff"))." -Level Debug
            $reportRecords.Add(([ReportRecord]::new($tag, $currentWatch.Elapsed.ToString("hh\:mm\:ss\.fff"), $currentCount))) > $null

            if ($IncludeShortTags)
            {
                $shortTag = $tag -replace '(?<prefix>.*)(?<majorminor>\d{2}\.\d{1,2})(\.)(?<patch>\d{1,2})(?<suffix>.+)', '${prefix}${majorminor}${suffix}'
                docker image tag $tag $shortTag
                Write-Message "Successfully tagged $shortTag"
            }
            # Check to see if we need to stop here...
            if ([string]::IsNullOrEmpty($Registry))
            {
                Write-Message ("Done with '{0}', but not pushed since 'Registry' was empty." -f $tag) -Level Debug

                return
            }

            # Tag image
            if ([string]::IsNullOrEmpty($Registry))
            {
                $fulltag = $tag
            }
            else
            {
                $fulltag = "{0}/{1}" -f $Registry, $tag
            }

            if ($IncludeShortTags)
            {
                $registryShortTag = $fulltag -replace '(?<prefix>.*)(?<majorminor>\d{2}\.\d{1,2})(\.)(?<patch>\d{1,2})(?<suffix>.+)', '${prefix}${majorminor}${suffix}'
                docker image tag $tag $registryShortTag
                Write-Message "Successfully tagged $registryShortTag"
            }
            docker image tag $tag $fulltag

            $LASTEXITCODE -ne 0 | Where-Object { $_ } | ForEach-Object { throw "Failed." }

            # Check to see if we need to stop here...
            if ($PushMode -eq "Never")
            {
                Write-Message ("Processing complete for '{0}', but not pushed since 'PushMode' is '{1}'." -f $tag, $PushMode)

                return
            }

            # Determine if we need to push
            $currentDigest = (docker image inspect $tag) | ConvertFrom-Json | ForEach-Object { $_.Id }

            if (($PushMode -eq "WhenChanged") -and ($currentDigest -eq $previousDigest))
            {
                Write-Message ("Processing complete for '{0}', but not pushed since 'PushMode' is '{1}' and the image has not changed since last build." -f $tag, $PushMode)

                return
            }

            # Push image
            docker image push $fulltag
            if ($IncludeShortTags)
            {
                docker image push $registryShortTag
            }
            $LASTEXITCODE -ne 0 | Where-Object { $_ } | ForEach-Object { throw "Failed." }

            Write-Message ("Processing complete for '{0}', image pushed." -f $fulltag)
            if ($IncludeShortTags)
            {
                Write-Message ("Processing complete for '{0}', image pushed." -f $registryShortTag)
            }

        }
    }

    $watch.Stop()
    Write-Message "Builds completed. Time: $($watch.Elapsed.ToString("hh\:mm\:ss\.fff"))."

    Write-Output $reportRecords | Format-Table -Property Index, Time, Name
}
