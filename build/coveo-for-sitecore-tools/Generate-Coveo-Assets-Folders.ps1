[CmdletBinding(SupportsShouldProcess = $true)]

param (
    [Parameter()]
    [string[]]$SitecoreVersion,
    [Parameter()]
    [switch]$IncludeSxa
)

$parentFolderPath = (get-item $PSScriptRoot).parent.FullName
$coveoAssetsFolderPath = "$parentFolderPath\windows\$SitecoreVersion\modules\coveo-assets"

if (Test-Path $coveoAssetsFolderPath\*.zip -PathType Leaf) {
    Remove-Item $coveoAssetsFolderPath\*.zip | Out-Null
}

#Creating required folders for Coveo assets
New-Item -Path $coveoAssetsFolderPath -ItemType directory -Force | Out-Null
New-Item -Path "$coveoAssetsFolderPath\tools" -ItemType directory -Force | Out-Null

#Copying the Extract-Resource.ps1 script into the tools folder
Copy-Item "$PSScriptRoot\Extract-Resources.ps1" -Destination "$coveoAssetsFolderPath\tools" | Out-Null

if ($IncludeSxa) {
    $coveoSxaAssetsFolderPath = "$parentFolderPath\windows\$SitecoreVersion\modules\coveo-sxa-assets"

    if (Test-Path $coveoSxaAssetsFolderPath\*.zip -PathType Leaf) {
        Remove-Item $coveoSxaAssetsFolderPath\*.zip | Out-Null
    }

    #Creating required folders for Coveo SXA assets
    New-Item -Path $coveoSxaAssetsFolderPath -ItemType directory -Force | Out-Null
    New-Item -Path "$coveoSxaAssetsFolderPath\tools" -ItemType directory -Force | Out-Null

    #Copying the Extract-Resource.ps1 script into the tool folder
    Copy-Item "$PSScriptRoot\Extract-Resources.ps1" -Destination "$coveoSxaAssetsFolderPath\tools" | Out-Null
}
