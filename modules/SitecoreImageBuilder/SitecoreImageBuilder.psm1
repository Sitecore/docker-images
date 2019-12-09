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
        [array]$Tags = (Get-LatestSupportedVersionTags)
        ,
        [Parameter(Mandatory = $false)]
        [array]$AutoGenerateWindowsVersionTags = (Get-SupportedWindowsVersions)
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

    $sitecoreDownloadUrl = "https://dev.sitecore.net"

    # Load packages file
    $packagesFile = Get-Item -Path (Join-Path $PSScriptRoot "..\..\sitecore-packages.json")
    $packages = $packagesFile | Get-Content | ConvertFrom-Json

    $destinationPath = $Destination.TrimEnd('\')

    # Ensure destination exists
    if (!(Test-Path $destinationPath -PathType "Container"))
    {
        New-Item $destinationPath -ItemType Directory -WhatIf:$false | Out-Null
    }

    # Find out which files is needed
    $sitecoreDownloadSession = $null
    $specs = Initialize-BuildSpecifications -Specifications (Get-BuildSpecifications -Path $Path -AutoGenerateWindowsVersionTags $AutoGenerateWindowsVersionTags) -InstallSourcePath $Destination -Tags $Tags -ImplicitTagsBehavior "Include" -DeprecatedTagsBehavior $DeprecatedTagsBehavior
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

        $fileName = $filePath.Replace(("{0}\" -f $destinationPath), "")
        $package = $packages.$fileName

        if ($null -eq $package)
        {
            throw ("Required package '{0}' was not defined in '{1}' so it can't be downloaded, please add the package ' { 2 }' manually." -f $fileName, $packagesFile.FullName, $filePath)
        }

        $fileUrl = $package.url

        if ([string]::IsNullOrEmpty($fileUrl))
        {
            Write-Host ("Required package: '{0}' not available from Sitecore download site because of a DUMMY entry in sitecore-packages.json.`nRequired ACTION: Copy manual '{0}' into '{1}'" -f $fileName, $Destination)
        }
        else
        {

            if ($PSCmdlet.ShouldProcess($fileName))
            {
                Write-Host ("Downloading '{0}' to '{1}'..." -f $fileUrl, $filePath)

                if ($fileUrl.StartsWith($sitecoreDownloadUrl))
                {
                    # Login to dev.sitecore.net and save session for re-use
                    if ($null -eq $sitecoreDownloadSession)
                    {
                        Write-Verbose ("Logging in to '{0}'..." -f $sitecoreDownloadUrl)

                        $loginResponse = Invoke-WebRequest "https://dev.sitecore.net/api/authorization" -Method Post -Body @{
                            username   = $SitecoreUsername
                            password   = $SitecorePassword
                            rememberMe = $true
                        } -SessionVariable "sitecoreDownloadSession" -UseBasicParsing

                        if ($null -eq $loginResponse -or $loginResponse.StatusCode -ne 200 -or $loginResponse.Content -eq "false")
                        {
                            throw ("Unable to login to '{0}' with the supplied credentials." -f $sitecoreDownloadUrl)
                        }

                        Write-Verbose ("Logged in to '{0}'." -f $sitecoreDownloadUrl)
                    }

                    # Download package using saved session
                    Invoke-WebRequest -Uri $fileUrl -OutFile $filePath -WebSession $sitecoreDownloadSession -UseBasicParsing
                }
                else
                {
                    # Download package
                    Invoke-WebRequest -Uri $fileUrl -OutFile $filePath -UseBasicParsing
                }
            }
        }
    }

    Write-Host "Restore completed."
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
    $specs = Initialize-BuildSpecifications -Specifications (Get-BuildSpecifications -Path $Path -AutoGenerateWindowsVersionTags $AutoGenerateWindowsVersionTags) -InstallSourcePath $InstallSourcePath -Tags $Tags -ImplicitTagsBehavior $ImplicitTagsBehavior -DeprecatedTagsBehavior $DeprecatedTagsBehavior

    # Print results
    $specs | Sort-Object -Property Include, Priority, Tag | Select-Object -Property Tag, Include, Deprecated, Priority, Base | Format-Table

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
                    Write-Warning "Source file '$sourcePath' is missing."

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
        [array]$Tags = (Get-LatestSupportedVersionTags)
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
    $patterns = @(
        "^sitecore-assets:(.*)$", # dependency
        "^sitecore-certificates:(.*)$", # dependency
        "^sitecore-openjdk:(.*)$", # dependency
        "^mssql-developer:(.*)$", # dependency

        "^sitecore-base:(.*)$", # legacy\images
        "^sitecore-xp-base:(.*)$", # legacy\images
        "^sitecore-xp-xconnect:(.*)$", # legacy\images
        "^sitecore-xm1-(sql|sqldev):(.*)$", # legacy\images
        "^sitecore-xm1-(standalone|cm|cd):(.*)$" # legacy\images

        "^sitecore-(xm1|xp)-pse-(.*)-sqldev:(.*)$" # legacy\variants
        "^sitecore-(xm1|xp)-pse-(.*)-(standalone|cm|cd):(.*)$" # legacy\variants
        "^sitecore-(xm1|xp)-sxa-(.*)-sqldev:(.*)$" # legacy\variants
        "^sitecore-(xm1|xp)-sxa-(.*)-(standalone|cm|cd):(.*)$" # legacy\variants

        "^sitecore-(xm|xp)-(sql|sqldev):(.*)$", # windows/linux platform
        "^sitecore-(xm|xp)-(standalone|cm|cd|identity):(.*)$" # windows platform
        "^sitecore-xp-xconnect(.*):(.*)$" # windows platform

        "^sitecore-(xm|xp)-(spe|pse)-(sql|sqldev):(.*)$" # SPE windows/linux variants
        "^sitecore-(xm|xp)-(spe|pse)-(standalone|cm|cd):(.*)$" # SPE windows variants

        "^sitecore-(xm|xp)-sxa-(sql|sqldev):(.*)$" # SXA windows/linux variants
        "^sitecore-(xm|xp)-sxa-(standalone|cm|cd):(.*)$" # SXA  windows variants

        "^sitecore-xc-(cd|sqldev|standalone)(.*):(.*)$" # XC windows variants
        "^sitecore-xc-spe-(.*):(.*)$" # XC windows variants
        "^sitecore-xc-sxa-(cd|sqldev|standalone|solr)(.*):(.*)$" # XC windows variants
        "^sitecore-xc-sxa-storefront(.*):(.*)$" # XC windows variants
        "^sitecore-xc-(.*):(.*)$" # XC windows variants

    )

    $patterns | ForEach-Object {
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
        ,
        [Parameter(Mandatory = $false)]
        [array]$AutoGenerateWindowsVersionTags = (Get-SupportedWindowsVersions)
    )

    $versionMap = Get-WindowsServerCoreToNanoServerVersionMap

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

        $tags = @()

        # expand tags for each Windows version
        $dataTags | ForEach-Object {
            $tag = $_
            $options = $tag.'build-options'

            if ($null -eq $options)
            {
                $options = @()
            }

            if ($tag.tag -like "*`${*}*")
            {
                $AutoGenerateWindowsVersionTags | ForEach-Object {
                    $windowsServerCoreVersion = $_
                    $nanoServerVersion = $versionMap[$windowsServerCoreVersion]

                    if ([string]::IsNullOrEmpty($nanoServerVersion))
                    {
                        throw ("Could not find a 'nanoserver' version in the version map for '{0}'." -f $windowsServerCoreVersion)
                    }

                    $copy = $tag | Select-Object *
                    $copy.tag = $copy.tag.Replace("`${windowsservercore_version}", $windowsServerCoreVersion).Replace("`${nanoserver_version}", $nanoServerVersion)
                    $copy.'build-options' = @()

                    $options | ForEach-Object {
                        $copy.'build-options' += $_.Replace("`${windowsservercore_version}", $windowsServerCoreVersion).Replace("`${nanoserver_version}", $nanoServerVersion)
                    }

                    $tags += $copy
                }
            }
            else
            {
                $tags += $tag
            }
        }

        $dockerFileContent = $dockerFile | Get-Content
        $dockerFileArgLines = $dockerFileContent | Select-String -SimpleMatch "ARG " -CaseSensitive | ForEach-Object { Write-Output $_.ToString().Replace("ARG ", "") }
        $dockerFileFromLines = $dockerFileContent | Select-String -SimpleMatch "FROM " -CaseSensitive | ForEach-Object { Write-Output $_.ToString().Replace("FROM ", "") }

        $tags | ForEach-Object {
            $tag = $_
            $options = $tag.'build-options'

            if ($null -eq $options)
            {
                $options = @()
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
        ,
        [Parameter(Mandatory = $false)]
        [array]$AutoGenerateWindowsVersionTags = (Get-SupportedWindowsVersions)
    )

    $tagParser = [regex]"^(?<repository>[^:]*):(?<version>[^-]*)-(?<os>[^-]+)(?:-(?<build>.*))?$"

    Get-BuildSpecifications -Path $Path -AutoGenerateWindowsVersionTags $AutoGenerateWindowsVersionTags | ForEach-Object {
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
        ,
        [Parameter(Mandatory = $false)]
        [array]$AutoGenerateWindowsVersionTags = (Get-SupportedWindowsVersions)
    )

    Write-Output "| Version | Repository | OS  | Build      | Tag |"
    Write-Output "| ------- | ---------- | --- | -----------| --- |"

    Get-CurrentImages -Path $Path -AutoGenerateWindowsVersionTags $AutoGenerateWindowsVersionTags | Sort-Object -Property Version, Build, Repository -Descending | ForEach-Object {
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

function Get-SupportedWindowsVersions
{
    # NOTE: Order is important, newest first
    Write-Output ("1909", "1903", "ltsc2019")
}

function Get-WindowsServerCoreToNanoServerVersionMap
{
    Write-Output @{
        "1909"     = "1909";
        "1903"     = "1903";
        "ltsc2019" = "1809";
        "1803"     = "1803";
        "1709"     = "1709";
        "ltsc2016" = "sac2016"
    }
}

function Get-LatestSupportedVersion
{
    # load Windows image specifications
    $specs = Get-BuildSpecifications -Path (Join-Path $PSScriptRoot "\..\..\windows")

    # get the latest version number for Sitecore
    $sitecore = Get-LatestVersionNumberForTag -Specs $specs -Tag "sitecore-*:*windowsservercore-*"

    # pick latest 'windowsservercore' LTSC version
    $windowsServerCore = (Get-SupportedWindowsVersions | Where-Object { $_ -like "ltsc*" } | Select-Object -First 1)

    # pick latest 'nanoserver' version matching latest 'windowsservercore' LTSC version
    $nanoserver = (Get-WindowsServerCoreToNanoServerVersionMap)[$windowsServerCore]

    # get the latest version for redis
    $redis = Get-LatestVersionNumberForTag -Specs $specs -Tag "sitecore-redis*:*windowsservercore-*"

    Write-Output (New-Object PSObject -Property @{
            Sitecore          = $sitecore;
            WindowsServerCore = $windowsServerCore;
            NanoServer        = $nanoserver;
            Redis             = $redis;
        })
}

function Get-LatestVersionNumberForTag
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [array]$Specs
        ,
        [Parameter(Mandatory = $true)]
        [string]$Tag
    )

    # find all versions for the tag
    $versions = $Specs | Where-Object { $_.Tag -like $Tag } | Select-Object -ExpandProperty Tag

    $versions = $versions | ForEach-Object {
        $_.Substring($_.IndexOf(':') + 1)
    }

    $versions = $versions | ForEach-Object {
        $_.Substring(0, $_.IndexOf('-'))
    }

    $versions = $versions | Sort-Object -Unique -Descending

    # pick latest version for the tag
    Write-Output ($versions | Select-Object -First 1)
}

function Get-LatestSupportedVersionTags
{
    $latest = Get-LatestSupportedVersion

    Write-Output ("*:{0}*{1}" -f $latest.Sitecore, $latest.WindowsServerCore)
    Write-Output ("*:{0}*{1}" -f $latest.Sitecore, $latest.NanoServer)
    Write-Output ("*:{0}*{1}" -f $latest.Redis, $latest.WindowsServerCore)
}
