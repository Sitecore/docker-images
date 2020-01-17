function Get-LatestSupportedVersionTags
{
    $latest = Get-LatestSupportedVersion

    Write-Output ("*:{0}*{1}" -f $latest.Sitecore, $latest.WindowsServerCore)
    Write-Output ("*:{0}*{1}" -f $latest.Sitecore, $latest.NanoServer)
    Write-Output ("*:{0}*{1}" -f $latest.Redis, $latest.WindowsServerCore)
}