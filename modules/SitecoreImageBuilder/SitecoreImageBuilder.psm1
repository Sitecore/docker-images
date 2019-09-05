function Invoke-PackageRestore
{
    [CmdletBinding(SupportsShouldProcess = $true)]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidUsingPlainTextForPassword", "SitecorePassword")]
    param(
        [Parameter(Mandatory = $true)]
        [ValidateScript( { Test-Path $_ -PathType "Container" })] 
        [string]$Path
        ,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()] 
        [string]$Destination
        ,
        [Parameter(Mandatory = $false)]
        [array]$Tags = @("*")
        ,
        [Parameter(Mandatory = $false)]
        [ValidateSet("Include", "Skip")]
        [string]$DeprecatedTagsBehavior = "Skip"
        ,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$SitecoreUsername
        ,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$SitecorePassword
    )

    # Setup
    $ErrorActionPreference = "STOP"
    $ProgressPreference = "SilentlyContinue"

    $downloadUrl = "https://dev.sitecore.net"

    # Load packages file
    $packagesFile = Get-Item -Path (Join-Path $PSScriptRoot "..\..\sitecore-packages.json") 
    $packages = $packagesFile | Get-Content | ConvertFrom-Json

    # Ensure destination exists
    if (!(Test-Path $Destination -PathType "Container"))
    {
        New-Item $Destination -ItemType Directory -WhatIf:$false | Out-Null
    }

    # Find out which files is needed
    $downloadSession = $null
    $specs = Initialize-BuildSpecifications -Specifications (Get-BuildSpecifications -Path $Path) -InstallSourcePath $Destination -Tags $Tags -ImplicitTagsBehavior "Include" -DeprecatedTagsBehavior $DeprecatedTagsBehavior
    $expected = $specs | Where-Object { $_.Include -and $_.Sources.Length -gt 0 } | Select-Object -ExpandProperty Sources -Unique
    
    # Check or download needed files
    $expected | ForEach-Object {
        $filePath = $_

        if (Test-Path $filePath -PathType Leaf) 
        {
            $requiredFile = Get-Item -Path $filePath

            if ($requiredFile.Length -gt 0)
            {
                Write-Host ("Required package found: '{0}'" -f $filePath)

                return
            }

            Remove-Item -Path $filePath -Force
        }

        $fileName = $filePath.Replace("$Destination\", "")
        $package = $packages.$fileName

        if ($null -eq $package)
        {
            throw ("Required package '{0}' was not defined in '{1}' so it can't be downloaded, please add the package '{2}' manually." -f $fileName, $packagesFile.FullName, $filePath)
        }

        $fileUrl = $package.url

        if ([string]::IsNullOrEmpty($fileUrl))
        {
            throw ("Required package '{0}' was found in '{1}' but the 'url' property was null or empty." -f $fileName, $packagesFile.FullName)
        }

        if ($PSCmdlet.ShouldProcess($fileName))
        {
            # Login to dev.sitecore.net and save session for re-use
            if ($null -eq $downloadSession)
            {
                Write-Verbose ("Logging in to '{0}'..." -f $downloadUrl)

                $loginResponse = Invoke-WebRequest "https://dev.sitecore.net/api/authorization" -Method Post -Body @{
                    username   = $SitecoreUsername
                    password   = $SitecorePassword
                    rememberMe = $true
                } -SessionVariable "downloadSession" -UseBasicParsing

                if ($null -eq $loginResponse -or $loginResponse.StatusCode -ne 200 -or $loginResponse.Content -eq "false")
                {
                    throw ("Unable to login to '{0}' with the supplied credentials." -f $downloadUrl)
                }

                Write-Verbose ("Logged in to '{0}'." -f $downloadUrl)
            }

            # Download package using saved session
            Write-Host ("Downloading '{0}' to '{1}'..." -f $fileUrl, $filePath)
        
            Invoke-WebRequest -Uri $fileUrl -OutFile $filePath -WebSession $downloadSession -UseBasicParsing
        }
    }

    Write-Host "Restore completed."
}

function Invoke-Build
{
    [CmdletBinding(SupportsShouldProcess = $true)]
    param(
        [Parameter(Mandatory = $true)]
        [ValidateScript( { Test-Path $_ -PathType "Container" })] 
        [string]$Path
        ,
        [Parameter(Mandatory = $true)]
        [ValidateScript( { Test-Path $_ -PathType "Container" })] 
        [string]$InstallSourcePath
        ,
        [Parameter(Mandatory = $true)]
        [string]$Registry
        ,
        [Parameter(Mandatory = $false)]
        [array]$Tags = @("*")
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
    $specs = Initialize-BuildSpecifications -Specifications (Get-BuildSpecifications -Path $Path) -InstallSourcePath $InstallSourcePath -Tags $Tags -ImplicitTagsBehavior $ImplicitTagsBehavior -DeprecatedTagsBehavior $DeprecatedTagsBehavior

    # Print results
    $specs | Select-Object -Property Tag, Include, Deprecated, Priority, Base | Format-Table

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
                $sourceItem = Get-Item -Path $sourcePath
                $targetPath = Join-Path $spec.Path $sourceItem.Name

                if (!(Test-Path -Path $targetPath) -or ($sourceItem.Name -eq "license.xml"))
                {
                    Copy-Item $sourceItem -Destination $targetPath -Verbose:$VerbosePreference
                }
            }
        
            # Build image
            $osType = (docker system info --format '{{json .}}' | ConvertFrom-Json | % { $_.OSType })
            $buildOptions = New-Object System.Collections.Generic.List[System.Object]

            if ($osType -eq "windows")
            {
                $buildOptions.Add("--isolation 'hyperv'")
            }

            $buildOptions.AddRange($spec.BuildOptions)
            $buildOptions.Add("--tag '$tag'")
        
            $buildCommand = "docker image build {0} '{1}'" -f ($buildOptions -join " "), $spec.Path
        
            Write-Verbose ("Invoking: {0} " -f $buildCommand) -Verbose:$VerbosePreference

            & ([scriptblock]::create($buildCommand))
        
            $LASTEXITCODE -ne 0 | Where-Object { $_ } | ForEach-Object { throw "Failed: $buildCommand" }

            # Tag image
            $fulltag = "{0}/{1}" -f $Registry, $tag

            docker image tag $tag $fulltag

            $LASTEXITCODE -ne 0 | Where-Object { $_ } | ForEach-Object { throw "Failed." }

            # Check to see if we need to stop here...
            if ($PushMode -eq "Never")
            {
                Write-Warning ("### Done with '{0}', but not pushed since 'PushMode' is '{1}'." -f $tag, $PushMode)

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

function Initialize-BuildSpecifications
{
    param(
        [Parameter(Mandatory = $true)]
        [ValidateNotNull()] 
        [PSCustomObject]$Specifications
        ,
        [Parameter(Mandatory = $true)]
        [ValidateScript( { Test-Path $_ -PathType "Container" })] 
        [string]$InstallSourcePath
        ,
        [Parameter(Mandatory = $false)]
        [array]$Tags = @("*")
        ,
        [Parameter(Mandatory = $false)]
        [ValidateSet("Include", "Skip")]
        [string]$ImplicitTagsBehavior = "Include"
        ,
        [Parameter(Mandatory = $false)]
        [ValidateSet("Include", "Skip")]
        [string]$DeprecatedTagsBehavior = "Skip"
    )

    # Update specs, resolve sources to full path
    $Specifications | ForEach-Object {
        $spec = $_
        $sources = @()

        $spec.Sources | ForEach-Object {
            $sources += (Join-Path $InstallSourcePath $_)
        }
        
        $spec.Sources = $sources
    }

    # Update specs, include or not
    $Specifications | ForEach-Object {
        $spec = $_

        $spec.Include = ($Tags | ForEach-Object { $spec.Tag -like $_ }) -contains $true
         
        if ($spec.Include -eq $true -and $spec.Deprecated -eq $true -and $DeprecatedTagsBehavior -eq "Skip")
        {
            $spec.Include = $false

            Write-Verbose ("Tag '{0}' excluded as it is deprecated and the DeprecatedTagsBehavior parameter is '{1}'." -f $spec.Tag, $DeprecatedTagsBehavior)
        }
    }

    # Update specs, re-include base images
    if ($ImplicitTagsBehavior -eq "Include")
    {
        $Specifications | Where-Object { $_.Include -eq $true } | ForEach-Object {
            $spec = $_

            # Recursively iterate bases, excluding external ones, and re-include them
            $baseSpecs = $Specifications | Where-Object { $spec.Base -contains $_.Tag }
        
            while ($null -ne $baseSpecs)
            {
                $baseSpecs | ForEach-Object {
                    $baseSpec = $_

                    if ($baseSpec.Include -ne $true)
                    {
                        $baseSpec.Include = $true

                        Write-Verbose ("Tag '{0}' implicitly included '{1}' due to dependency." -f $spec.Tag, $baseSpec.Tag)
                    }
                }

                $baseSpecs = $Specifications | Where-Object { $baseSpecs.Base -contains $_.Tag } | Select-Object -First 1
            }
        }
    }

    # Specify priority for each tag, used to ensure base images are build first. This is the most simple approach I could come up with for handling dependencies between images. If needed in the future, look into something like https://en.wikipedia.org/wiki/Topological_sorting.
    $defaultPriority = 1000
    $priorities = New-Object System.Collections.Specialized.OrderedDictionary
    $priority = 0
    
    "^mssql-developer:(.*)$", 
    "^sitecore-openjdk:(.*)$", 
    "^sitecore-base:(.*)$", 
    "^sitecore-xm-sql:(.*)$", 
    "^sitecore-xm-pse-(.*):(.*)$", 
    "^sitecore-xm1-sqldev:(.*)$", 
    "^sitecore-xm1-pse-(.*)-sqldev:(.*)$", 
    "^sitecore-xm1-pse-(.*)-cm:(.*)$", 
    "^sitecore-xp-sql:(.*)$", 
    "^sitecore-xp-pse-(.*)-sql:(.*)$", 
    "^sitecore-xp-base:(.*)$", 
    "^sitecore-xp-xconnect:(.*)$", 
    "^sitecore-xp-pse-(.*)-sqldev:(.*)$", 
    "^sitecore-xp-pse-(.*)-standalone:(.*)$" | ForEach-Object {
        $priorities.Add($_, $priority)
        $priority++
    }
    
    $priorities.Add("^(.*)$", $defaultPriority)

    # Update specs, set priority according to rules
    $Specifications | ForEach-Object {
        $spec = $_
        $rule = $priorities.Keys | Where-Object { $spec.Tag -match $_ } | Select-Object -First 1
    
        $spec.Priority = $priorities[$rule]
    }

    # Reorder specs, priorities goes first
    $specs = [System.Collections.ArrayList]@()
    $specs.AddRange(@($Specifications | Where-Object { $_.Priority -lt $defaultPriority } | Sort-Object -Property Priority))
    $specs.AddRange(@($Specifications | Where-Object { $_.Priority -eq $defaultPriority }))

    return $specs
}

function Get-BuildSpecifications
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [ValidateScript( { Test-Path $_ -PathType "Container" })] 
        [string]$Path
    )

    Get-ChildItem -Path $Path -Filter "build.json" -Recurse | ForEach-Object {
        $buildContextPath = $_.Directory.FullName
        $buildFilePath = $_.FullName
        $data = Get-Content -Path $buildFilePath | ConvertFrom-Json
        $dockerFile = Get-Item -Path (Join-Path $buildContextPath "\Dockerfile")
        
        $sources = @()

        if ($null -ne $data.sources)
        {
            $sources = $data.sources
        }

        $dataTags = $data.tags
        
        if ($null -eq $dataTags)
        {
            $dataTags = @()

            # TODO: Removed when all build.json files has been converted to new format
            if ($null -ne $data.deprecated)
            {
                $dataTags += @{ "tag" = $data.tag; "deprecated" = $data.deprecated; }
            }
            else
            {
                $dataTags += @{ "tag" = $data.tag; }
            }
        }

        $dockerFileContent = $dockerFile | Get-Content
        $dockerFileArgLines = $dockerFileContent | Select-String -SimpleMatch "ARG " -CaseSensitive | ForEach-Object { Write-Output $_.ToString().Replace("ARG ", "") }
        $dockerFileFromLines = $dockerFileContent | Select-String -SimpleMatch "FROM " -CaseSensitive | ForEach-Object { Write-Output $_.ToString().Replace("FROM ", "") }
        
        $dataTags | ForEach-Object {
            $tag = $_
            $options = $tag.'build-options'

            if ($null -eq $options)
            {
                $options = @()

                # TODO: Removed when all build.json files has been converted to new format
                if ($tag.tag -like "*sql*") 
                {
                    $options += "--memory 4GB"
                }
            }

            $deprecated = $false

            if ($null -ne $tag.deprecated)
            {
                $deprecated = [bool]$tag.deprecated
            }

            # Find base images...
            $baseImages = $dockerFileFromLines | ForEach-Object {
                $image = $_

                if ($image -like "* as *")
                {
                    $image = $image.Substring(0, $image.IndexOf(" as "))
                }
            
                if ($image -like "`$*")
                {
                    $argName = $image.Replace("`$", "").Replace("{", "").Replace("}", "")
                    $matchingOption = $options | Where-Object { $_.Contains($argName) } | Select-Object -First 1

                    if ($null -ne $matchingOption)
                    {
                        # Resolved base image from ARG passed as build-args defined in build-options
                        $image = $matchingOption.Substring($matchingOption.IndexOf($argName) + $argName.Length).Replace("=", "")
                    }
                    else
                    {
                        $argDefaultValue = $dockerFileArgLines | Where-Object { $_ -match $argName } | ForEach-Object {
                            Write-Output $_.Replace($argName, "").Replace("=", "")
                        }

                        if ([string]::IsNullOrEmpty($argDefaultValue) -eq $false)
                        {
                            # Resolved base image from ARG default value
                            $image = $argDefaultValue
                        }
                        else
                        {
                            throw ("Parse error in '{0}', Dockerfile is expecting ARG '{1}' but it has no default value and is not found in any 'build-options'." -f $buildFilePath, $argName)
                        }
                    }
                }
                
                Write-Output $image
            }

            if ($null -eq $baseImages -or $baseImages.Length -eq 0)
            {
                throw ("Parse error, no base images was found in Dockerfile '{0}'." -f $dockerFile.FullName)
            }
            
            Write-Output (New-Object PSObject -Property @{
                    Tag            = $tag.tag;
                    BuildOptions   = @($options);
                    Base           = @($baseImages | Select-Object -Unique);
                    Path           = $buildContextPath;
                    DockerFilePath = $dockerFile.FullName;
                    Sources        = @($sources);
                    Priority       = $null;
                    Include        = $false;
                    Deprecated     = $deprecated;
                })
        }
    }
}

function Get-CurrentImages
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [ValidateScript( { Test-Path $_ -PathType "Container" })] 
        [string]$Path
    )
    
    $tagParser = [regex]"^(?<repository>[^:]*):(?<version>[^-]*)-(?<os>[^-]+)(?:-(?<build>.*))?$"

    Get-BuildSpecifications -Path $Path | ForEach-Object {
        $spec = $_
        $match = $tagParser.Match($spec.Tag)

        if ($match.Success)
        {
            $repository = $match.Groups["repository"].Value
            $version = $match.Groups["version"].Value
            $os = $match.Groups["os"].Value
            $build = $match.Groups["build"].Value

            Write-Output (New-Object PSObject -Property @{
                    Repository     = $repository;
                    Version        = $version;
                    OS             = $os;
                    Build          = $build;
                    Deprecated     = $spec.Deprecated;
                    Tag            = $spec.Tag;
                    DockerFilePath = $spec.DockerFilePath;
                })
        }
    }
}

function Get-CurrentImagesMarkdown
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [ValidateScript( { Test-Path $_ -PathType "Container" })] 
        [string]$Path
    )
    
    Write-Output "| Version | Repository | OS  | Build      | Tag |"
    Write-Output "| ------- | ---------- | --- | -----------| --- |"

    Get-CurrentImages -Path $Path | Sort-Object -Property Version, Build, Repository -Descending | ForEach-Object {
        $dockerFileUrl = (Resolve-Path $_.DockerFilePath -Relative).Replace(".\", "").Replace("\", "/").Replace(" ", "%20")

        if ($_.Deprecated)
        {
            Write-Output ("| ~~{0}~~ | ~~{1}~~ | ~~{2}~~ | ~~{3}~~ | ~~``{4}`` [Dockerfile]({5})~~ |" -f $_.Version, $_.Repository, $_.OS, $_.Build, $_.Tag, $dockerFileUrl)
        }
        else
        {
            Write-Output ("| {0} | {1} | {2} | {3 } | ``{4}`` [Dockerfile]({5}) |" -f $_.Version, $_.Repository, $_.OS, $_.Build, $_.Tag, $dockerFileUrl)
        }
    }
}