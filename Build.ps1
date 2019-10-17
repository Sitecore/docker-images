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

# load module
Import-Module (Join-Path $PSScriptRoot "\modules\SitecoreImageBuilder") -Force

# restore any missing packages
SitecoreImageBuilder\Invoke-PackageRestore `
    -Path (Join-Path $PSScriptRoot "\windows") `
    -Destination $InstallSourcePath `
    -SitecoreUsername $SitecoreUsername `
    -SitecorePassword $SitecorePassword `
    -WhatIf:$WhatIfPreference

# start the build
SitecoreImageBuilder\Invoke-Build `
    -Path (Join-Path $PSScriptRoot "\windows") `
    -InstallSourcePath $InstallSourcePath `
    -Registry $Registry `
    -WhatIf:$WhatIfPreference