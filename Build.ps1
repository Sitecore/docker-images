[CmdletBinding(SupportsShouldProcess = $true)]
[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidUsingPlainTextForPassword", "SitecorePassword")]
[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidUsingPlainTextForPassword", "RegistryPassword")]

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
    ,
    [Parameter(Mandatory = $false)]
    [string]$Registry = ""
    ,
    [Parameter(Mandatory = $false)]
    [string]$RegistryUserName = ""
    ,
    [Parameter(Mandatory = $false)]
    [string]$RegistryPassword = ""

)

$ErrorActionPreference = "STOP"
$ProgressPreference = "SilentlyContinue"

# optional, default value is the latest Sitecore version on latest LTSC version
# of Windows. Set to for example "*" for build everything or "*:9.1.1*1903", "*:9.2.0*1903" to
# only build 9.1.1 and 9.2.0 on Windows 1903.
$tags = "*"

# load module
Import-Module (Join-Path $PSScriptRoot "\modules\SitecoreImageBuilder") -Force

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
    -Registry $Registry `
    -WhatIf:$WhatIfPreference