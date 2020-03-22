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
    [ValidateSet("9.3.0", "9.2.0", "9.1.1", "9.0.2")]
    [string[]]$SitecoreVersion = @("9.3.0"),
    [ValidateSet("xm", "xp", "xc")]
    [string[]]$Topology = @("xm", "xp"),
    [ValidateSet("1909", "1903", "ltsc2019", "linux")]
    [string[]]$OSVersion = @("ltsc2019"),
    [Parameter()]
    [switch]$IncludeSpe,
    [Parameter()]
    [switch]$IncludeSxa,
    [Parameter()]
    [switch]$IncludeJss,
    [Parameter(HelpMessage = "If the docker image is already built it should be skipped.")]
    [switch]$SkipExistingImage,
    [Parameter()]
    [switch]$IncludeExperimental
)

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
    $InstallSourcePath = (Join-Path -Path $PSScriptRoot -ChildPath "\packages")
}

$ErrorActionPreference = "STOP"
$ProgressPreference = "SilentlyContinue"

# load module
Import-Module (Join-Path $PSScriptRoot "\modules\SitecoreImageBuilder") -RequiredVersion 1.0.0 -Force

$tags = [System.Collections.ArrayList]@()

$windowsVersionMapping = @{
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
    if ($_ -like "*-windowsservercore-$($Version)" -or $_ -like "*-nanoserver-$($windowsVersionMapping[$Version])")
    {
        $_
    }
}

filter SitecoreFilter
{
    param([string]$Version)
    if ($_ -like "*:$($Version)-windowsservercore-*" -or $_ -like "*:$($Version)-nanoserver-*" -or $_ -like "*:$($Version)-linux")
    {
        $_
    }
}

$rootFolder = "windows"
if ($OSVersion -eq "linux") {
    $rootFolder = "linux"
}

$availableSpecs = Get-BuildSpecifications -Path (Join-Path $PSScriptRoot $rootFolder)

if (!$IncludeExperimental)
{
    Write-Message "Excluding experimental images."
    $availableSpecs = $availableSpecs | Where-Object { !$_.Experimental }
}

$availableTags = $availableSpecs | Select-Object -ExpandProperty Tag
$defaultTags = $availableTags | Where-Object { $_ -like "mssql-developer:*" -or $_ -like "sitecore-openjdk:*" }
$xpMiscTags = $availableTags | Where-Object { $_ -like "sitecore-certificates:*" }
$xcMiscTags = $availableTags | Where-Object { $_ -like "sitecore-certificates:*" -or $_ -like "sitecore-redis:*" }

$assetTags = $availableTags | Where-Object { $_ -like "sitecore-assets:*" }
$xmTags = $availableTags | Where-Object { $_ -match "sitecore-xm-(?!sxa|spe|jss).*:.*" }
$xpTags = $availableTags | Where-Object { $_ -match "sitecore-xp-(?!sxa|spe|jss).*:.*" }
$xcTags = $availableTags | Where-Object { $_ -match "sitecore-xc-(?!sxa|spe|jss).*:.*" }

$xmSpeTags = $availableTags | Where-Object { $_ -match "sitecore-xm-(spe).*:.*" }
$xmSxaTags = $availableTags | Where-Object { $_ -match "sitecore-xm-(sxa).*:.*" }
$xmJssTags = $availableTags | Where-Object { $_ -match "sitecore-xm-(jss).*:.*" }

$xpSpeTags = $availableTags | Where-Object { $_ -match "sitecore-xp-(spe).*:.*" }
$xpSxaTags = $availableTags | Where-Object { $_ -match "sitecore-xp-(sxa).*:.*" }
$xpJssTags = $availableTags | Where-Object { $_ -match "sitecore-xp-(jss).*:.*" }

$xcSpeTags = $availableTags | Where-Object { $_ -match "sitecore-xc-(spe).*:.*" }
$xcSxaTags = $availableTags | Where-Object { $_ -match "sitecore-xc-(sxa).*:.*" }

$knownTags = $defaultTags + $xpMiscTags + $xcMiscTags + $assetTags + $xmTags + $xpTags + $xcTags + $xmSpeTags + $xpSpeTags + $xcSpeTags + $xmSxaTags + $xpSxaTags + $xcSxaTags + $xmJssTags + $xpJssTags
# These tags are not yet classified and no dependency check is made at this point to know which image it belongs to.
$catchAllTags = [System.Linq.Enumerable]::Except([string[]]$availableTags, [string[]]$knownTags)

foreach ($wv in $OSVersion)
{
    $defaultTags | WindowsFilter -Version $wv | ForEach-Object { $tags.Add($_) > $null }

    if ($Topology -contains "xp")
    {
        $xpMiscTags | WindowsFilter -Version $wv | ForEach-Object { $tags.Add($_) > $null }
    }

    if ($Topology -contains "xc")
    {
        $xcMiscTags | WindowsFilter -Version $wv | ForEach-Object { $tags.Add($_) > $null }
    }

    foreach ($scv in $SitecoreVersion)
    {
        $assetTags | SitecoreFilter -Version $scv | WindowsFilter -Version $wv | ForEach-Object { $tags.Add($_) > $null }
        $catchAllTags | SitecoreFilter -Version $scv | WindowsFilter -Version $wv | ForEach-Object { $tags.Add($_) > $null }

        if ($Topology -contains "xm")
        {
            $xmTags | SitecoreFilter -Version $scv | WindowsFilter -Version $wv | ForEach-Object { $tags.Add($_) > $null }

            if ($wv -eq "linux") {
                $xmTags | SitecoreFilter -Version $scv | LinuxFilter | ForEach-Object { $tags.Add($_) > $null }
            }
        }

        if ($Topology -contains "xp")
        {
            $xpTags | SitecoreFilter -Version $scv | WindowsFilter -Version $wv | ForEach-Object { $tags.Add($_) > $null }

            if ($wv -eq "linux") {
                $xpTags | SitecoreFilter -Version $scv | LinuxFilter | ForEach-Object { $tags.Add($_) > $null }
            }
        }

        if ($Topology -contains "xc")
        {
            $xcTags | SitecoreFilter -Version $scv | WindowsFilter -Version $wv | ForEach-Object { $tags.Add($_) > $null }
        }

        if ($IncludeSpe)
        {
            if ($Topology -contains "xm")
            {
                $xmSpeTags | SitecoreFilter -Version $scv | WindowsFilter -Version $wv | ForEach-Object { $tags.Add($_) > $null }
            }

            if ($Topology -contains "xp")
            {
                $xpSpeTags | SitecoreFilter -Version $scv | WindowsFilter -Version $wv | ForEach-Object { $tags.Add($_) > $null }
            }

            if ($Topology -contains "xc")
            {
                $xcSpeTags | SitecoreFilter -Version $scv | WindowsFilter -Version $wv | ForEach-Object { $tags.Add($_) > $null }
            }
        }

        if ($IncludeSxa)
        {
            if ($Topology -contains "xm")
            {
                $xmSxaTags | SitecoreFilter -Version $scv | WindowsFilter -Version $wv | ForEach-Object { $tags.Add($_) > $null }
            }

            if ($Topology -contains "xp")
            {
                $xpSxaTags | SitecoreFilter -Version $scv | WindowsFilter -Version $wv | ForEach-Object { $tags.Add($_) > $null }
            }

            if ($Topology -contains "xc")
            {
                $xcSxaTags | SitecoreFilter -Version $scv | WindowsFilter -Version $wv | ForEach-Object { $tags.Add($_) > $null }
            }
        }

        if ($IncludeJss)
        {
            if ($Topology -contains "xm")
            {
                $xmJssTags | SitecoreFilter -Version $scv | WindowsFilter -Version $wv | ForEach-Object { $tags.Add($_) > $null }
            }

            if ($Topology -contains "xp")
            {
                $xpJssTags | SitecoreFilter -Version $scv | WindowsFilter -Version $wv | ForEach-Object { $tags.Add($_) > $null }
            }
        }
    }
}

$tags = [System.Collections.ArrayList]@($tags | Select-Object -Unique)

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
    -Path (Join-Path $PSScriptRoot $rootFolder) `
    -Destination $InstallSourcePath `
    -SitecoreUsername $SitecoreUsername `
    -SitecorePassword $SitecorePassword `
    -Tags $tags `
    -ExperimentalTagBehavior:(@{$true = "Include"; $false = "Skip" }[$IncludeExperimental -eq $true]) `
    -WhatIf:$WhatIfPreference

# start the build
SitecoreImageBuilder\Invoke-Build `
    -Path (Join-Path $PSScriptRoot $rootFolder) `
    -InstallSourcePath $InstallSourcePath `
    -Registry $Registry `
    -Tags $tags `
    -ExperimentalTagBehavior:(@{$true = "Include"; $false = "Skip" }[$IncludeExperimental -eq $true]) `
    -WhatIf:$WhatIfPreference