[CmdletBinding(SupportsShouldProcess = $true)]

param (
    [Parameter()]
    [string[]]$SitecoreVersion,
    [Parameter()]
    [string]$CoveoVersion,
    [Parameter()]
    [switch]$IncludeSxa
)

$parentFolderPath = (get-item $PSScriptRoot).parent.FullName
$destinationFolder = "$parentFolderPath\windows\$SitecoreVersion\modules\coveo-assets"
$sxaDestinationFolder = "$parentFolderPath\windows\$SitecoreVersion\modules\coveo-sxa-assets"
$formattedCoveoVersion = $CoveoVersion.Replace(".", "")

$buildJson = @"
{
    "tags": [
    {
        "tag": "community/modules/custom-coveo$formattedCoveoVersion-assets:$SitecoreVersion-`${nanoserver_version}",
        "build-options": [
        "--build-arg BASE_IMAGE=mcr.microsoft.com/windows/nanoserver:`${nanoserver_version}",
        "--build-arg TOOL_IMAGE=`${sitecore_registry}/tools/sitecore-docker-tools-assets:$SitecoreVersion-1809",
        "--build-arg BASE_BUILD_IMAGE=mcr.microsoft.com/windows/servercore:`${windowsservercore_version}",
        "--build-arg ROLES=cm",
        "--file windows/$SitecoreVersion/modules/Dockerfile"
        ],
        "experimental": false
    }
    ],
    "sources": [
    "Coveo for Sitecore $SitecoreVersion $CoveoVersion.scwdp.zip"
    ]
}
"@

$sxaBuildJson = @"
{
    "tags": [
    {
        "tag": "community/modules/custom-coveo$formattedCoveoVersion-sxa-assets:$SitecoreVersion-`${nanoserver_version}",
        "build-options": [
        "--build-arg BASE_IMAGE=mcr.microsoft.com/windows/nanoserver:`${nanoserver_version}",
        "--build-arg TOOL_IMAGE=`${sitecore_registry}/tools/sitecore-docker-tools-assets:$SitecoreVersion-1809",
        "--build-arg BASE_BUILD_IMAGE=mcr.microsoft.com/windows/servercore:`${windowsservercore_version}",
        "--build-arg ROLES=cm",
        "--file windows/$SitecoreVersion/modules/Dockerfile"
        ],
        "experimental": false
    }
    ],
    "sources": [
    "Coveo for Sitecore SXA $SitecoreVersion $CoveoVersion.scwdp.zip"
    ]
}
"@


if ($SitecoreVersion -eq "10.0.1") {
    $buildJson = @"
{
    "tags": [
    {
        "tag": "community/modules/custom-coveo$formattedCoveoVersion-assets:$SitecoreVersion-`${nanoserver_version}",
        "build-options": [
        "--build-arg BASE_IMAGE=mcr.microsoft.com/windows/nanoserver:`${nanoserver_version}",
        "--build-arg TOOL_IMAGE=`${sitecore_registry}/tools/sitecore-docker-tools-assets:10.0.0-1809",
        "--build-arg BASE_BUILD_IMAGE=mcr.microsoft.com/windows/servercore:`${windowsservercore_version}",
        "--build-arg ROLES=cm",
        "--file windows/$SitecoreVersion/modules/Dockerfile"
        ],
        "experimental": false
    }
    ],
    "sources": [
    "Coveo for Sitecore $SitecoreVersion $CoveoVersion.scwdp.zip"
    ]
}
"@
    $sxaBuildJson = @"
{
    "tags": [
    {
        "tag": "community/modules/custom-coveo$formattedCoveoVersion-sxa-assets:$SitecoreVersion-`${nanoserver_version}",
        "build-options": [
        "--build-arg BASE_IMAGE=mcr.microsoft.com/windows/nanoserver:`${nanoserver_version}",
        "--build-arg TOOL_IMAGE=`${sitecore_registry}/tools/sitecore-docker-tools-assets:10.0.0-1809",
        "--build-arg BASE_BUILD_IMAGE=mcr.microsoft.com/windows/servercore:`${windowsservercore_version}",
        "--build-arg ROLES=cm",
        "--file windows/$SitecoreVersion/modules/Dockerfile"
        ],
        "experimental": false
    }
    ],
    "sources": [
    "Coveo for Sitecore SXA $SitecoreVersion $CoveoVersion.scwdp.zip"
    ]
}
"@
}

New-Item -Path $destinationFolder -Name "build.json" -ItemType "file" -Value ($buildJson) -Force | Out-Null

if ($IncludeSxa) {
    New-Item -Path $sxaDestinationFolder -Name "build.json" -ItemType "file" -Value ($sxaBuildJson) -Force | Out-Null
}