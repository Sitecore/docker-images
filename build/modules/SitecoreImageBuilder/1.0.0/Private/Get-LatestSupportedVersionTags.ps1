function Get-LatestSupportedVersionTags
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [array]$Specs
    )

    $latest = Get-LatestSupportedVersion -Specs $Specs

    Write-Output ("*:{0}*{1}" -f $latest.Sitecore, $latest.WindowsServerCore)
    Write-Output ("*:{0}*{1}" -f $latest.Sitecore, $latest.NanoServer)
    Write-Output ("*:{0}*{1}" -f $latest.Redis, $latest.WindowsServerCore)
}