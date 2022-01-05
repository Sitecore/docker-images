[CmdletBinding(SupportsShouldProcess = $true)]

param(
    [Parameter()]
    [string[]]$SitecoreVersion,
    [Parameter()]
    [string]$CoveoVersion,
    [Parameter()]
    [switch]$IncludeSxa
)

$parentPath = (get-item $PSScriptRoot).parent.FullName
$sitecorePackagesPath = "$parentPath\sitecore-packages.json"
$json = Get-Content $sitecorePackagesPath | Out-String | ConvertFrom-Json

$coveoPackageUrl = "https://static.cloud.coveo.com/coveoforsitecore/packages/v$CoveoVersion/Coveo%20for%20Sitecore%2010.0%20$CoveoVersion.scwdp.zip"
$propertyKey = "Coveo for Sitecore $SitecoreVersion $CoveoVersion.scwdp.zip"
$propertyValue = [ordered]@{ url = $coveoPackageUrl; hash = ""; }

$json | Add-Member -Type NoteProperty -Name $propertyKey -Value $propertyValue -Force

if ($IncludeSxa) {
    $sxaWdpPropertyKey = "Coveo for Sitecore SXA $SitecoreVersion $CoveoVersion.scwdp.zip"
    $sxaWdpPropertyValue = [ordered]@{ url = "https://static.cloud.coveo.com/coveoforsitecore/packages/v$CoveoVersion/Coveo%20for%20Sitecore%20SXA%2010.1%20$CoveoVersion.scwdp.zip"; hash = ""; }

    $json | Add-Member -Type NoteProperty -Name $sxaWdpPropertyKey -Value $sxaWdpPropertyValue -Force
}

$json | ConvertTo-Json | Set-Content $sitecorePackagesPath

& "$parentPath\contributing\Sort-SitecorePackagesJson.ps1"