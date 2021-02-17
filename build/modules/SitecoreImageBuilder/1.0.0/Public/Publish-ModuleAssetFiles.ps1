function Publish-LinuxModuleAssetFiles
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
        [Parameter(Mandatory = $true)]
        [ValidateScript( { Test-Path $_ -PathType "Container" })]
        [string]$Destination
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
        [string]$ExperimentalTagBehavior = "Skip"
    )

    # Setup
    $ErrorActionPreference = "STOP"
    $ProgressPreference = "SilentlyContinue"

    $watch = [System.Diagnostics.StopWatch]::StartNew()

    $allSpecs = Get-BuildSpecifications -Path $Path -AutoGenerateWindowsVersionTags $AutoGenerateWindowsVersionTags

    if ($Tags -eq $null)
    {
        $Tags = Get-LatestSupportedVersionTags -Specs $allSpecs
    }

    # Find out what to build
    $specs = Initialize-BuildSpecifications -Specifications $allSpecs -InstallSourcePath $InstallSourcePath -Tags $Tags -ImplicitTagsBehavior $ImplicitTagsBehavior -ExperimentalTagBehavior $ExperimentalTagBehavior

    # Replace ${sitecore_registry} with appropriate value, if applicable
    $specs = Update-SitecoreRegistry -specs $specs -SitecoreRegistry $SitecoreRegistry

    # Download asset images and place in destination
    try
    {
        $specs | Where-Object { $_.Include -eq $true -and -not [string]::IsNullOrEmpty($_.WindowsAssetImage) } | ForEach-Object {
            $spec = $_
            $WindowsAssetImage = $spec.WindowsAssetImage
            $moduleName = Split-Path $spec.Path -Leaf
            $topology = $spec.Topology
            $versionRegex = "(?<version>\d+\.\d+\.\d+)"
            if ($spec.Path -match $versionRegex)
            {
                $sitecoreVersion = $matches.version
            }
            else
            {
                throw "Failed to obtain Sitecore version from path"
            }
            $DestinationPath = [System.IO.Path]::Combine($Destination, $sitecoreVersion, "modules", $moduleName, "data", $topology )
            if (!(Test-Path $DestinationPath))
            {
                New-Item $DestinationPath -ItemType Directory -Force
            }
            Write-Message "Copying assets from $WindowsAssetImage to $DestinationPath"
            docker pull $WindowsAssetImage
            docker container create --name tempWindows $WindowsAssetImage
            if ($LASTEXITCODE -ne 0)
            {
                throw "Failed to create container"
            }
            docker container cp tempWindows:/module $DestinationPath
            docker container rm -f tempWindows
        }
    }
    catch
    {
        Write-Error "Error processing $($spec.WindowsAssetImage) for $($spec.tag)"
        Exit 1
    }

    $watch.Stop()
    Write-Message "Restore completed. Time: $($watch.Elapsed.ToString("hh\:mm\:ss\.fff"))."
}


