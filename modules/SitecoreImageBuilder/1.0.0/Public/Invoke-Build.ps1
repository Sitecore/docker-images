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
        [array]$Tags = (Get-LatestSupportedVersionTags)
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
    )

    # Setup
    $ErrorActionPreference = "STOP"
    $ProgressPreference = "SilentlyContinue"

    # Find out what to build
    $specs = Initialize-BuildSpecifications -Specifications (Get-BuildSpecifications -Path $Path -AutoGenerateWindowsVersionTags $AutoGenerateWindowsVersionTags) -InstallSourcePath $InstallSourcePath -Tags $Tags -ImplicitTagsBehavior $ImplicitTagsBehavior -DeprecatedTagsBehavior $DeprecatedTagsBehavior -ExperimentalTagBehavior $ExperimentalTagBehavior

    # Print results
    $specs | Select-Object -Property Tag, Include, Deprecated, Priority, Base | Format-Table

    # Determine OS
    $osType = (docker system info --format '{{json .}}' | ConvertFrom-Json | ForEach-Object { $_.OSType })

    Write-Host "### Build specifications loaded..." -ForegroundColor Green

    # Pull latest external images
    if ($PSCmdlet.ShouldProcess("Pull latest images"))
    {
        if ($PullMode -eq "Always")
        {
            $baseImages = @()

            # Find external base images of included specifications
            $specs | Where-Object { $_.Include -eq $true } | ForEach-Object {
                $spec = $_

                $spec.Base | Where-Object { $_.Contains("/") -eq $true } | ForEach-Object {
                    $baseImages += $_
                }
            }

            # Pull images
            $baseImages | Select-Object -Unique | ForEach-Object {
                $tag = $_

                docker image pull $tag

                $LASTEXITCODE -ne 0 | Where-Object { $_ } | ForEach-Object { throw "Failed." }

                Write-Host ("### External image '{0}' is latest." -f $tag)
            }

            Write-Host "### External images is up to date..." -ForegroundColor Green
        }
        else
        {
            Write-Warning ("### Pulling external images skipped since PullMode was '{0}'." -f $PullMode)
        }
    }

    # Start build...
    if ($PSCmdlet.ShouldProcess("Start image builds"))
    {
        $specs | Where-Object { $_.Include } | ForEach-Object {
            $spec = $_
            $tag = $spec.Tag

            Write-Host ("### Processing '{0}'..." -f $tag)

            # Save the digest of previous builds for later comparison
            $previousDigest = $null

            if ((docker image ls $tag --quiet))
            {
                $previousDigest = (docker image inspect $tag) | ConvertFrom-Json | ForEach-Object { $_.Id }
            }

            # Copy license.xml and any missing source files into build context
            $spec.Sources | ForEach-Object {
                $sourcePath = $_

                # continue if source file doesn't exist
                if (!(Test-Path $sourcePath))
                {
                    Write-Warning "Source file '$sourcePath' is missing..."

                    return
                }

                $sourceItem = Get-Item -Path $sourcePath
                $targetPath = Join-Path $spec.Path $sourceItem.Name

                if (!(Test-Path -Path $targetPath) -or ($sourceItem.Name -eq "license.xml"))
                {
                    Copy-Item $sourceItem -Destination $targetPath -Verbose:$VerbosePreference
                }
            }

            # Build image
            $buildOptions = New-Object System.Collections.Generic.List[System.Object]

            if ($osType -eq "windows")
            {
                $buildOptions.Add("--isolation 'hyperv'")
            }

            $spec.BuildOptions | ForEach-Object {
                $option = $_

                $buildOptions.Add($option)
            }

            $buildOptions.Add("--tag '$tag'")

            $buildCommand = "docker image build {0} '{1}'" -f ($buildOptions -join " "), $spec.Path

            Write-Verbose ("Invoking: {0} " -f $buildCommand) -Verbose:$VerbosePreference

            & ([scriptblock]::create($buildCommand))

            $LASTEXITCODE -ne 0 | Where-Object { $_ } | ForEach-Object { throw "Failed: $buildCommand" }

            # Check to see if we need to stop here...
            if ([string]::IsNullOrEmpty($Registry))
            {
                Write-Host ("### Done with '{0}', but not pushed since 'Registry' was empty." -f $tag) -ForegroundColor Green

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

            docker image tag $tag $fulltag

            $LASTEXITCODE -ne 0 | Where-Object { $_ } | ForEach-Object { throw "Failed." }

            # Check to see if we need to stop here...
            if ($PushMode -eq "Never")
            {
                Write-Host ("### Done with '{0}', but not pushed since 'PushMode' is '{1}'." -f $tag, $PushMode) -ForegroundColor Green

                return
            }

            # Determine if we need to push
            $currentDigest = (docker image inspect $tag) | ConvertFrom-Json | ForEach-Object { $_.Id }

            if (($PushMode -eq "WhenChanged") -and ($currentDigest -eq $previousDigest))
            {
                Write-Host ("### Done with '{0}', but not pushed since 'PushMode' is '{1}' and the image has not changed since last build." -f $tag, $PushMode) -ForegroundColor Green

                return
            }

            # Push image
            docker image push $fulltag

            $LASTEXITCODE -ne 0 | Where-Object { $_ } | ForEach-Object { throw "Failed." }

            Write-Host ("### Done with '{0}', image pushed." -f $fulltag) -ForegroundColor Green
        }
    }
}
