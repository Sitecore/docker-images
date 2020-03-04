
function Get-Packages
{
    [CmdletBinding()]
    param()

    $packagesFile = Get-Item -Path (Join-Path $PSScriptRoot "..\..\..\..\sitecore-packages.json")
    $packages = $packagesFile | Get-Content | ConvertFrom-Json

    Write-Output $packages
}