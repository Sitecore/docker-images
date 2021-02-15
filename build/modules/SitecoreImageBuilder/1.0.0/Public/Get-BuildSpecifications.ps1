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

    # Disable strict mode checking when working with a dynamic JSON structure where some properties are optional
    Set-StrictMode -Off

    $versionMap = Get-WindowsServerCoreToNanoServerVersionMap

    Get-ChildItem -Path $Path -Filter "*build.json" -Recurse | ForEach-Object {
        $buildContextPath = $_.Directory.FullName
        $buildFilePath = $_.FullName
        $data = Get-Content -Path $buildFilePath | ConvertFrom-Json
        $dockerFile = ""
        $windowsAssetImage = ""
        $topology = ""
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

        # Expand tags for each Windows version
        $dataTags | ForEach-Object {
            $tag = $_
            $options = $tag.'build-options'

            if ($options -match '--file*')
            {
                $dockerFile = Get-Item -Path (Resolve-Path ((@($options) -like '--file*') -replace '--file ', ''))
            }
            else
            {
                $dockerFile = Get-Item -Path (Join-Path $buildContextPath "\Dockerfile")
            }

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

            if ($null -ne $tag.'windows-asset-image')
            {
                $windowsAssetImage = $tag.'windows-asset-image'
                $topology = $tag.topology
            }

            $deprecated = $false

            if ($null -ne $tag.deprecated)
            {
                $deprecated = [bool]$tag.deprecated
            }

            $experimental = $false

            if ($null -ne $tag.experimental)
            {
                $experimental = [bool]$tag.experimental
            }

            # Find base images...
            $baseImages = $dockerFileFromLines | ForEach-Object {
                $image = $_

                $image = $image.toUpper()

                if ($image -like "* AS *")
                {
                    $image = $image.Substring(0, $image.IndexOf(" AS "))
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
                    Tag               = $tag.tag;
                    BuildOptions      = @($options);
                    Base              = @($baseImages | Select-Object -Unique);
                    Path              = $buildContextPath;
                    DockerFilePath    = $dockerFile.FullName;
                    Sources           = @($sources);
                    Priority          = $null;
                    Include           = $false;
                    Deprecated        = $deprecated;
                    Experimental      = $experimental;
                    WindowsAssetImage = $windowsAssetImage;
                    Topology          = $topology;
                })
        }
    }
}