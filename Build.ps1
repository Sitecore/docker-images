[CmdletBinding(SupportsShouldProcess = $true)]
[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidUsingPlainTextForPassword", "SitecorePassword")]
[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidUsingPlainTextForPassword", "RegistryPassword")]

param(
    [Parameter()]
    [ValidateNotNullOrEmpty()]
    [string]$InstallSourcePath,
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [string]$SitecoreUsername,
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [string]$SitecorePassword,
    [Parameter()]
    [string]$Registry = "",
    [Parameter()]
    [string]$RegistryUserName = "",
    [Parameter()]
    [string]$RegistryPassword = "",
    [Parameter()]
    [ValidatePattern('[0-9]+\.[0-9]+\.[0-9]+')]
    [string[]]$SitecoreVersion = @("10.0.0"),
    [ValidateSet("xm", "xp", "xc", "xp0")]
    [string[]]$Topology = @("xm", "xp", "xp0"),
    [ValidateSet("2009", "2004", "1909", "1903", "ltsc2019", "linux")]
    [string[]]$OSVersion = @("ltsc2019"),
    [Parameter()]
    [switch]$IncludeSpe,
    [Parameter()]
    [switch]$IncludeSxa,
    [Parameter()]
    [switch]$IncludeJss,
    [Parameter()]
    [switch]$IncludeSh,
    [Parameter()]
    [switch]$SkipModuleAssets,
    [Parameter(HelpMessage = "If the docker image is already built it should be skipped.")]
    [switch]$SkipExistingImage,
    [Parameter()]
    [switch]$IncludeExperimental,
    [Parameter(Mandatory = $false)]
    [ValidateSet("ForceHyperV", "EngineDefault", "ForceProcess", "ForceDefault")]
    [string]$IsolationModeBehaviour = "ForceHyperV",
    [Parameter(Mandatory = $false, HelpMessage = "If supplied, will output a 'docker-images.json' file in the working folder")]
    [switch]
    $OutputJson,
    [Parameter(Mandatory = $false)]
    [string]$SitecoreRegistry = "scr.sitecore.com",
    [Parameter(Mandatory = $false)]
    [switch]$IncludeShortTags
)

Push-Location build

function Write-Message
{
    param(
        [string]$Message
    )

    $timeFormat = "HH:mm:ss:fff"

    Write-Host "$(Get-Date -Format $timeFormat): $($Message)"
}

if ([string]::IsNullOrEmpty($InstallSourcePath))
{
    $InstallSourcePath = (Join-Path -Path $(Get-Location) -ChildPath "\packages")
}

$ErrorActionPreference = "STOP"
$ProgressPreference = "SilentlyContinue"

# load module
Import-Module (Join-Path $(Get-Location) "\modules\SitecoreImageBuilder") -RequiredVersion 1.0.0 -Force

$tags = [System.Collections.ArrayList]@()

$windowsVersionMapping = @{
    "2009"     = "2009"
    "2004"     = "2004"
    "1909"     = "1909"
    "1903"     = "1903"
    "ltsc2019" = "1809"
}

filter LinuxFilter
{
    if ($_ -like "*-linux")
    {
        $_
    }
}

filter WindowsFilter
{
    param([string]$Version)
    if ($_ -match ".*((-windowsservercore){0,1})-$($Version)" -or $_ -match ".*((-nanoserver){0,1})-$($windowsVersionMapping[$Version])")
    {
        $_
    }
}

filter SitecoreFilter
{
    param([string]$Version)
    if ($_ -match ".*:$($Version)((-windowsservercore){0,1})-*" -or $_ -match ".*:$($Version)((-nanoserver){0,1})-*" -or $_ -like "*:$($Version)-linux")
    {
        $_
    }
}

$rootFolder = "windows"
if ($OSVersion -eq "linux")
{
    $rootFolder = "linux"
}

$availableSpecs = Get-BuildSpecifications -Path (Join-Path $(Get-Location) $rootFolder)

if (!$IncludeExperimental)
{
    Write-Message "Excluding experimental images."
    $availableSpecs = $availableSpecs | Where-Object { !$_.Experimental }
}

$availableTags = $availableSpecs | Select-Object -ExpandProperty Tag
$defaultTags = $availableTags | Where-Object { $_ -like "mssql-developer:*" -or $_ -like "sitecore-openjdk:*" }
$xpMiscTags = $availableTags | Where-Object { $_ -like "sitecore-certificates:*" }
$xcMiscTags = $availableTags | Where-Object { $_ -like "sitecore-certificates:*" -or $_ -like "sitecore-redis:*" }

$assetTags = $availableTags | Where-Object { $_ -match "(community/)?sitecore(-custom)?-assets:.*" }
$moduleAssetTags = $availableTags | Where-Object { $_ -like "community/modules/*" }
$xmTags = $availableTags | Where-Object { $_ -match "(community/)?sitecore-xm([1]{0,1})(-custom)?-(?!.*spe|.*sxa|.*jss).*:.*" }
$xpTags = $availableTags | Where-Object { $_ -match "(community/)?sitecore-xp([1]{0,1})(-custom)?-(?!.*spe|.*sxa|.*jss|.*sh).*:.*" }
$xp0Tags = $availableTags | Where-Object { $_ -match "(community/)?sitecore-xp0(-custom)?-(?!.*spe|.*sxa|.*jss).*:.*" }

$xcTags = $availableTags | Where-Object { $_ -match "(community/)?sitecore-xc(-custom)?-(?!.*spe|.*sxa|.*jss).*:.*" }

$xmSpeTags = $availableTags | Where-Object { $_ -match "(community/)?sitecore-xm([1]{0,1})(-custom)?-(spe)(?!.*sxa).*:.*" }
$xmSxaTags = $availableTags | Where-Object { $_ -match "(community/)?sitecore-xm([1]{0,1})(-custom)?-(.*sxa)(?!.*jss).*:.*" }
$xmJssTags = $availableTags | Where-Object { $_ -match "(community/)?sitecore-xm([1]{0,1})(-custom)?-(.*jss).*:.*" }

$xp0SpeTags = $availableTags | Where-Object { $_ -match "(community/)?sitecore-xp0(-custom)?-(spe)(?!.*sxa).*:.*" }
$xp0SxaTags = $availableTags | Where-Object { $_ -match "(community/)?sitecore-xp0(-custom)?-(.*sxa)(?!.*jss).*:.*" }
$xp0JssTags = $availableTags | Where-Object { $_ -match "(community/)?sitecore-xp0(-custom)?-(.*jss).*:.*" }

$xpSpeTags = $availableTags | Where-Object { $_ -match "(community/)?sitecore-xp([1]{0,1})(-custom)?-(spe)(?!.*sxa).*:.*" }
$xpSxaTags = $availableTags | Where-Object { $_ -match "(community/)?sitecore-xp([1]{0,1})(-custom)?-(.*sxa)(?!.*jss).*:.*" }
$xpJssTags = $availableTags | Where-Object { $_ -match "(community/)?sitecore-xp([1]{0,1})(-custom)?-(.*jss).*:.*" }
$xpShTags = $availableTags | Where-Object { $_ -match "sitecore-xp([1]{0,1})(-custom)?-(.*sh).*:.*" }

$xcSpeTags = $availableTags | Where-Object { $_ -match "(community/)?sitecore-xc-(spe).*:.*" }
$xcSxaTags = $availableTags | Where-Object { $_ -match "(community/)?sitecore-xc-(sxa).*:.*" }

$knownTags = $defaultTags + $xpMiscTags + $xcMiscTags + $assetTags + $xmTags + $xpTags + $xp0Tags + $xcTags + $xmSpeTags + $xp0SpeTags + $xpSpeTags + $xcSpeTags + $xmSxaTags + $xp0SxaTags + $xpSxaTags + $xcSxaTags + $xmJssTags + $xp0JssTags + $xpJssTags + $xpShTags
if ($SkipModuleAssets)
{
    # remove module tags from the avaiableTags to prevent getting processed later
    $availableTags = [System.Linq.Enumerable]::Except([string[]]$availableTags, [string[]]$moduleAssetTags)
}
else
{
    $knownTags += $moduleAssetTags
}

# These tags are not yet classified and no dependency check is made at this point to know which image it belongs to.
$catchAllTags = [System.Linq.Enumerable]::Except([string[]]$availableTags, [string[]]$knownTags)

foreach ($wv in $OSVersion)
{

    [regex]$versionReg = "[789]\.[0-9]\.[0-9]"
    #Check if version being built is 7.x, 8.x or 9.x. We only need the defaultTags if building < 10.x
    if (($SitecoreVersion -match $versionReg).count -gt 0)
    {
        $defaultTags | WindowsFilter -Version $wv | ForEach-Object { $tags.Add($_) > $null }
    }
    if ($Topology -contains "xp")
    {
        $xpMiscTags | WindowsFilter -Version $wv | ForEach-Object { $tags.Add($_) > $null }
    }

    if ($Topology -eq "xc")
    {
        $xcMiscTags | WindowsFilter -Version $wv | ForEach-Object { $tags.Add($_) > $null }
    }

    foreach ($scv in $SitecoreVersion)
    {
        $assetTags | SitecoreFilter -Version $scv | WindowsFilter -Version $wv | ForEach-Object { $tags.Add($_) > $null }
        if (-not $SkipModuleAssets)
        {
            $moduleAssetTags | SitecoreFilter -Version $scv | WindowsFilter -Version $wv | ForEach-Object { $tags.Add($_) > $null }
        }
        $catchAllTags | SitecoreFilter -Version $scv | WindowsFilter -Version $wv | ForEach-Object { $tags.Add($_) > $null }

        if ($Topology -eq "xm")
        {
            $xmTags | SitecoreFilter -Version $scv | WindowsFilter -Version $wv | ForEach-Object { $tags.Add($_) > $null }

            if ($wv -eq "linux")
            {
                $xmTags | SitecoreFilter -Version $scv | LinuxFilter | ForEach-Object { $tags.Add($_) > $null }
            }
        }

        if ($Topology -eq "xp")
        {
            $xpTags | SitecoreFilter -Version $scv | WindowsFilter -Version $wv | ForEach-Object { $tags.Add($_) > $null }

            if ($wv -eq "linux")
            {
                $xpTags | SitecoreFilter -Version $scv | LinuxFilter | ForEach-Object { $tags.Add($_) > $null }
            }
        }

        if ($Topology -eq "xc")
        {
            $xcTags | SitecoreFilter -Version $scv | WindowsFilter -Version $wv | ForEach-Object { $tags.Add($_) > $null }
        }

        if ($IncludeSpe)
        {
            if ($Topology -eq "xm")
            {
                $xmSpeTags | SitecoreFilter -Version $scv | WindowsFilter -Version $wv | ForEach-Object { $tags.Add($_) > $null }
            }

            if ($Topology -eq "xp0")
            {
                $xp0SpeTags | SitecoreFilter -Version $scv | WindowsFilter -Version $wv | ForEach-Object { $tags.Add($_) > $null }

                if ($wv -eq "linux")
                {
                    $xp0SpeTags | SitecoreFilter -Version $scv | LinuxFilter | ForEach-Object { $tags.Add($_) > $null }
                }
            }
            if ($Topology -eq "xp")
            {
                $xpSpeTags | SitecoreFilter -Version $scv | WindowsFilter -Version $wv | ForEach-Object { $tags.Add($_) > $null }

                if ($wv -eq "linux")
                {
                    $xpSpeTags | SitecoreFilter -Version $scv | LinuxFilter | ForEach-Object { $tags.Add($_) > $null }
                }
            }

            if ($Topology -eq "xc")
            {
                $xcSpeTags | SitecoreFilter -Version $scv | WindowsFilter -Version $wv | ForEach-Object { $tags.Add($_) > $null }
            }
        }

        if ($IncludeSxa)
        {
            if ($Topology -eq "xm")
            {
                $xmSxaTags | SitecoreFilter -Version $scv | WindowsFilter -Version $wv | ForEach-Object { $tags.Add($_) > $null }
            }
            if ($Topology -eq "xp0")
            {
                $xp0SxaTags | SitecoreFilter -Version $scv | WindowsFilter -Version $wv | ForEach-Object { $tags.Add($_) > $null }

                if ($wv -eq "linux")
                {
                    $xp0SxaTags | SitecoreFilter -Version $scv | LinuxFilter | ForEach-Object { $tags.Add($_) > $null }
                }
            }
            if ($Topology -eq "xp")
            {
                $xpSxaTags | SitecoreFilter -Version $scv | WindowsFilter -Version $wv | ForEach-Object { $tags.Add($_) > $null }

                if ($wv -eq "linux")
                {
                    $xpSxaTags | SitecoreFilter -Version $scv | LinuxFilter | ForEach-Object { $tags.Add($_) > $null }
                }
            }

            if ($Topology -eq "xc")
            {
                $xcSxaTags | SitecoreFilter -Version $scv | WindowsFilter -Version $wv | ForEach-Object { $tags.Add($_) > $null }
            }
        }

        if ($IncludeJss)
        {
            if ($Topology -eq "xm")
            {
                $xmJssTags | SitecoreFilter -Version $scv | WindowsFilter -Version $wv | ForEach-Object { $tags.Add($_) > $null }
            }

            if ($Topology -eq "xp0")
            {
                $xp0JssTags | SitecoreFilter -Version $scv | WindowsFilter -Version $wv | ForEach-Object { $tags.Add($_) > $null }
            }

            if ($Topology -eq "xp")
            {
                $xpJssTags | SitecoreFilter -Version $scv | WindowsFilter -Version $wv | ForEach-Object { $tags.Add($_) > $null }
            }
        }

        if ($IncludeSh)
        {
            if ($Topology -eq "xp")
            {
                $xpShTags | SitecoreFilter -Version $scv | WindowsFilter -Version $wv | ForEach-Object { $tags.Add($_) > $null }
            }
        }
    }
}

$tags = [System.Collections.ArrayList]@($tags | Select-Object -Unique)

if ($tags -and $OutputJson)
{
    # if -OutputJson, send $tags for formatting and output to working folder
    $json = Format-BuildOutputToJson $tags
    $json | Set-Content -Path (Join-Path $PWD "docker-images.json") -Force
}

if ($SkipExistingImage)
{
    Write-Message "Existing images will be excluded from the build."
    $existingImages = docker images --format '{{.Repository}}:{{.Tag}}' --filter 'dangling=false'
    foreach ($existingImage in $existingImages)
    {
        if ($tags -contains $existingImage)
        {
            $tags.Remove($existingImage)
        }
    }
}

if ($tags)
{
    Write-Message "The following images will be built:"
    $tags
}
else
{
    Write-Message "No images need to be built."
    exit
}

# restore any missing packages
SitecoreImageBuilder\Invoke-PackageRestore `
    -Path (Join-Path $(Get-Location) $rootFolder) `
    -Destination $InstallSourcePath `
    -SitecoreUsername $SitecoreUsername `
    -SitecorePassword $SitecorePassword `
    -Tags $tags `
    -ExperimentalTagBehavior:(@{$true = "Include"; $false = "Skip" }[$IncludeExperimental -eq $true]) `
    -WhatIf:$WhatIfPreference

if ($IncludeExperimental -eq $true)
{
    # restore any missing experimental packages
    .\Download-Module-Prerequisites.ps1 `
        -InstallSourcePath $InstallSourcePath
}

# start the build
SitecoreImageBuilder\Invoke-Build `
    -Path (Join-Path $(Get-Location) $rootFolder) `
    -InstallSourcePath $InstallSourcePath `
    -Registry $Registry `
    -SitecoreRegistry $SitecoreRegistry `
    -Tags $tags `
    -ExperimentalTagBehavior:(@{$true = "Include"; $false = "Skip" }[$IncludeExperimental -eq $true]) `
    -IsolationModeBehaviour $IsolationModeBehaviour `
    -IncludeShortTags:$IncludeShortTags `
    -WhatIf:$WhatIfPreference

Pop-Location
