[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [string]$LicenseFileTargetPath
)

$licenseFilePath = "C:\license\license.xml"

if (!(Test-Path $licenseFilePath -PathType "Leaf"))
{
    throw ("License not found at '{0}'." -f $licenseFilePath)
}

Copy-Item $licenseFilePath -Destination $LicenseFileTargetPath -Force

& C:\ServiceMonitor.exe "w3svc"