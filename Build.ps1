[CmdletBinding(SupportsShouldProcess = $true)]
[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidUsingPlainTextForPassword", "SitecorePassword")]
[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidUsingPlainTextForPassword", "RegistryPassword")]

param(
    [Parameter()]
    [ValidateNotNullOrEmpty()]
    [string]$InstallSourcePath = (Join-Path $PSScriptRoot "\packages"),
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
    [string[]]$Topology = @("xm", "xp", "xc"),
    [ValidateSet("1909", "1903", "ltsc2019")]
    [string[]]$WindowsVersion = @("ltsc2019"),
    [Parameter()]
    [switch]$IncludeSpe,
    [Parameter()]
    [switch]$IncludeSxa,
    [Parameter()]
    [switch]$IncludeJss,
    [Parameter(HelpMessage="If the docker image is already built it should be skipped.")]
    [switch]$SkipExistingImage
)

$ErrorActionPreference = "STOP"
$ProgressPreference = "SilentlyContinue"

# load module
Import-Module (Join-Path $PSScriptRoot "\modules\SitecoreImageBuilder") -RequiredVersion 1.0.0 -Force

$tags = [System.Collections.ArrayList]@()
$windowsVersionMapping = @{
    "1909"     = "1909"
    "1903"     = "1903"
    "ltsc2019" = "1809"
    "1803"     = "1803"
}
foreach ($wv in $WindowsVersion)
{
    $tags.Add("mssql-developer:2017-windowsservercore-$($wv)") > $null
    $tags.Add("sitecore-certificates:latest-nanoserver-$($windowsVersionMapping[$wv])") > $null
    $tags.Add("sitecore-openjdk:8-nanoserver-$($windowsVersionMapping[$wv])") > $null
    $tags.Add("sitecore-redis:3.0.504-windowsservercore-$($wv)") > $null

    foreach ($scv in $SitecoreVersion)
    {
        $tags.Add("sitecore-assets:$($scv)-nanoserver-$($windowsVersionMapping[$wv])") > $null
        if ([Version]$scv -ge [Version]"9.3.0" -and [int]$windowsVersionMapping[$wv] -gt 1809)
        {
            $tags.Add("sitecore-ps:$($scv)-nanoserver-$($windowsVersionMapping[$wv])") > $null
        }

        if ($Topology -contains "xm")
        {
            $tags.Add("sitecore-xm-cd:$($scv)-windowsservercore-$($wv)") > $null
            $tags.Add("sitecore-xm-cm:$($scv)-windowsservercore-$($wv)") > $null
            $tags.Add("sitecore-xm-solr:$($scv)-nanoserver-$($windowsVersionMapping[$wv])") > $null
            $tags.Add("sitecore-xm-sqldev:$($scv)-windowsservercore-$($wv)") > $null
        }

        if ($Topology -contains "xp")
        {
            $tags.Add("sitecore-xp-cd:$($scv)-windowsservercore-$($wv)") > $null
            $tags.Add("sitecore-xp-identity:$($scv)-windowsservercore-$($wv)") > $null
            $tags.Add("sitecore-xp-solr:$($scv)-nanoserver-$($windowsVersionMapping[$wv])") > $null
            $tags.Add("sitecore-xp-standalone:$($scv)-windowsservercore-$($wv)") > $null
            $tags.Add("sitecore-xp-sqldev:$($scv)-windowsservercore-$($wv)") > $null
            $tags.Add("sitecore-xp-xconnect:$($scv)-windowsservercore-$($wv)") > $null
            $tags.Add("sitecore-xp-xconnect-automationengine:$($scv)-windowsservercore-$($wv)") > $null
            $tags.Add("sitecore-xp-xconnect-indexworker:$($scv)-windowsservercore-$($wv)") > $null
            $tags.Add("sitecore-xp-xconnect-processingengine:$($scv)-windowsservercore-$($wv)") > $null
        }

        if ($Topology -contains "xc")
        {
            $tags.Add("sitecore-xc-bizfx:$($scv)-windowsservercore-$($wv)") > $null
            $tags.Add("sitecore-xc-cd:$($scv)-windowsservercore-$($wv)") > $null
            $tags.Add("sitecore-xc-engine-authoring:$($scv)-windowsservercore-$($wv)") > $null
            $tags.Add("sitecore-xc-engine-minions:$($scv)-windowsservercore-$($wv)") > $null
            $tags.Add("sitecore-xc-engine-ops:$($scv)-windowsservercore-$($wv)") > $null
            $tags.Add("sitecore-xc-engine-shops:$($scv)-windowsservercore-$($wv)") > $null
            $tags.Add("sitecore-xc-identity:$($scv)-windowsservercore-$($wv)") > $null
            $tags.Add("sitecore-xc-solr:$($scv)-nanoserver-$($windowsVersionMapping[$wv])") > $null
            $tags.Add("sitecore-xc-standalone:$($scv)-windowsservercore-$($wv)") > $null
            $tags.Add("sitecore-xc-sqldev:$($scv)-windowsservercore-$($wv)") > $null
            $tags.Add("sitecore-xc-xconnect-automationengine:$($scv)-windowsservercore-$($wv)") > $null
            $tags.Add("sitecore-xc-xconnect-indexworker:$($scv)-windowsservercore-$($wv)") > $null
        }

        if ($IncludeSpe.IsPresent)
        {
            if ($Topology -contains "xm")
            {
                $tags.Add("sitecore-xm-spe-cm:$($scv)-windowsservercore-$($wv)") > $null
                $tags.Add("sitecore-xm-spe-sqldev:$($scv)-windowsservercore-$($wv)") > $null
            }

            if ($Topology -contains "xp")
            {
                $tags.Add("sitecore-xp-spe-sqldev:$($scv)-windowsservercore-$($wv)") > $null
                $tags.Add("sitecore-xp-spe-standalone:$($scv)-windowsservercore-$($wv)") > $null
            }

            if ($Topology -contains "xc")
            {
                $tags.Add("sitecore-xc-spe-cd:$($scv)-windowsservercore-$($wv)") > $null
                $tags.Add("sitecore-xc-spe-sqldev:$($scv)-windowsservercore-$($wv)") > $null
                $tags.Add("sitecore-xc-spe-standalone:$($scv)-windowsservercore-$($wv)") > $null
            }
        }

        if ($IncludeSxa.IsPresent)
        {
            if ($Topology -contains "xm")
            {
                $tags.Add("sitecore-xm-sxa-cd:$($scv)-windowsservercore-$($wv)") > $null
                $tags.Add("sitecore-xm-sxa-cm:$($scv)-windowsservercore-$($wv)") > $null
                $tags.Add("sitecore-xm-sxa-solr:$($scv)-nanoserver-$($windowsVersionMapping[$wv])") > $null
                $tags.Add("sitecore-xm-sxa-sqldev:$($scv)-windowsservercore-$($wv)") > $null
            }

            if ($Topology -contains "xp")
            {
                $tags.Add("sitecore-xp-sxa-cd:$($scv)-windowsservercore-$($wv)") > $null
                $tags.Add("sitecore-xp-sxa-ps-cd:$($scv)-windowsservercore-$($wv)") > $null
                $tags.Add("sitecore-xp-sxa-ps-cm:$($scv)-windowsservercore-$($wv)") > $null
                $tags.Add("sitecore-xp-sxa-ps-standalone:$($scv)-windowsservercore-$($wv)") > $null
                $tags.Add("sitecore-xp-sxa-ps-sqldev:$($scv)-windowsservercore-$($wv)") > $null
                $tags.Add("sitecore-xp-sxa-solr:$($scv)-nanoserver-$($windowsVersionMapping[$wv])") > $null
                $tags.Add("sitecore-xp-sxa-sqldev:$($scv)-windowsservercore-$($wv)") > $null
                $tags.Add("sitecore-xp-sxa-standalone:$($scv)-windowsservercore-$($wv)") > $null
            }

            if ($Topology -contains "xc")
            {
                $tags.Add("sitecore-xc-sxa-cd:$($scv)-windowsservercore-$($wv)") > $null
                $tags.Add("sitecore-xc-sxa-solr:$($scv)-nanoserver-$($windowsVersionMapping[$wv])") > $null
                $tags.Add("sitecore-xc-sxa-storefront-cd:$($scv)-windowsservercore-$($wv)") > $null
                $tags.Add("sitecore-xc-sxa-storefront-sqldev:$($scv)-windowsservercore-$($wv)") > $null
                $tags.Add("sitecore-xc-sxa-storefront-standalone:$($scv)-windowsservercore-$($wv)") > $null
                $tags.Add("sitecore-xc-sxa-sqldev:$($scv)-windowsservercore-$($wv)") > $null
            }
        }

        if ($IncludeJss.IsPresent)
        {
            if ($Topology -contains "xm")
            {
                $tags.Add("sitecore-xm-jss-cd:$($scv)-windowsservercore-$($wv)") > $null
                $tags.Add("sitecore-xm-jss-cm:$($scv)-windowsservercore-$($wv)") > $null
                $tags.Add("sitecore-xm-jss-sqldev:$($scv)-windowsservercore-$($wv)") > $null
            }

            if ($Topology -contains "xp")
            {
                $tags.Add("sitecore-xp-jss-cd:$($scv)-windowsservercore-$($wv)") > $null
                $tags.Add("sitecore-xp-jss-sqldev:$($scv)-windowsservercore-$($wv)") > $null
                $tags.Add("sitecore-xp-jss-standalone:$($scv)-windowsservercore-$($wv)") > $null
            }
        }
    }
}

if ($SkipExistingImage.IsPresent)
{
    Write-Host "Existing images will be excluded from the build."
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
    Write-Host "The following images will be built:"
    $tags
}
else
{
    Write-Host "No images need to be built."
    exit
}

# restore any missing packages
SitecoreImageBuilder\Invoke-PackageRestore `
    -Path (Join-Path $PSScriptRoot "\windows") `
    -Destination $InstallSourcePath `
    -SitecoreUsername $SitecoreUsername `
    -SitecorePassword $SitecorePassword `
    -Tags $tags `
    -WhatIf:$WhatIfPreference

# start the build
SitecoreImageBuilder\Invoke-Build `
    -Path (Join-Path $PSScriptRoot "\windows") `
    -InstallSourcePath $InstallSourcePath `
    -Registry $Registry `
    -Tags $tags `
    -WhatIf:$WhatIfPreference