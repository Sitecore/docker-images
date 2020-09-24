function Get-LatestSupportedVersion
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [array]$Specs
    )

    # get the latest version number for Sitecore
    $sitecore = Get-LatestVersionNumberForTag -Specs $specs -Tag "*sitecore-*:*"

    # pick latest 'windowsservercore' LTSC version
    $windowsServerCore = (Get-SupportedWindowsVersions | Where-Object { $_ -like "ltsc*" } | Select-Object -First 1)

    # pick latest 'nanoserver' version matching latest 'windowsservercore' LTSC version
    $nanoserver = (Get-WindowsServerCoreToNanoServerVersionMap)[$windowsServerCore]

    # get the latest version for redis
    $redis = Get-LatestVersionNumberForTag -Specs $specs -Tag "sitecore-redis*:*windowsservercore-*"

    Write-Output (New-Object PSObject -Property @{
            Sitecore          = $sitecore;
            WindowsServerCore = $windowsServerCore;
            NanoServer        = $nanoserver;
            Redis             = $redis;
        })
}