[CmdletBinding(SupportsShouldProcess = $true)]
[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidUsingPlainTextForPassword", "SitecorePassword")]
param(
    [Parameter(Mandatory = $false)]
    [ValidateNotNullOrEmpty()]
    [string]$InstallSourcePath = (Join-Path $PSScriptRoot "\packages")
    ,
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [string]$SitecoreUsername
    ,
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [string]$SitecorePassword
)

$ErrorActionPreference = "STOP"
$ProgressPreference = "SilentlyContinue"

# load module
Import-Module (Join-Path $PSScriptRoot "\modules\SitecoreImageBuilder") -Force

# get latest support version
$latest = SitecoreImageBuilder\Get-LatestSupportedVersion

# generate tags for latest Sitecore version on latest Windows LTSC version
$tags = ("*:{0}*{1}" -f $latest.Sitecore, $latest.WindowsServerCore), ("*:{0}*{1}" -f $latest.Sitecore, $latest.NanoServer)

# restore any missing packages
SitecoreImageBuilder\Invoke-PackageRestore `
    -Path (Join-Path $PSScriptRoot "\windows") `
    -Destination $InstallSourcePath `
    -Tags $tags `
    -SitecoreUsername $SitecoreUsername `
    -SitecorePassword $SitecorePassword `
    -WhatIf:$WhatIfPreference

# start the build
SitecoreImageBuilder\Invoke-Build `
    -Path (Join-Path $PSScriptRoot "\windows") `
    -InstallSourcePath $InstallSourcePath `
    -Tags $tags `
    -PushMode "Never" `
    -WhatIf:$WhatIfPreference