
$ErrorActionPreference = "STOP"
$ProgressPreference = "SilentlyContinue"

Import-Module (Join-Path $PSScriptRoot "\modules\SitecoreImageBuilder") -Force
Push-Location $PSScriptRoot

function Update-Section
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [ValidateScript( { Test-Path $_ -PathType "Leaf" })]
        [string]$Path
        ,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$Name
        ,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$Content
    )

    $targetContent = Get-Content -Path $Path
    $sectionStart = "[//]: # `"start: {0}`"" -f $Name
    $sectionEnd = "[//]: # `"end: {0}`"" -f $Name
    $start = $targetContent | Select-String -SimpleMatch $sectionStart | Select-Object -ExpandProperty LineNumber
    $end = $targetContent | Select-String -SimpleMatch $sectionEnd | Select-Object -ExpandProperty LineNumber

    if ($null -eq $start)
    {
        throw ("Could not find start section '{0}' in '{1}'." -f $sectionStart, $Path)
    }

    if ($null -eq $end)
    {
        throw ("Could not find end section '{0}' in '{1}'." -f $sectionEnd, $Path)
    }

    $before = $targetContent | Select-Object -First $start
    $body = "`r`n{0}" -f $Content
    $after = $targetContent | Select-Object -Skip ($end - 1)

    $before, $body, $after | Out-File -FilePath $Path -Force -Encoding utf8
}

$specs = @()

(Get-Item (Join-Path $PSScriptRoot "\windows")), (Get-Item (Join-Path $PSScriptRoot "\linux")) | ForEach-Object {

    $specs += SitecoreImageBuilder\Get-BuildSpecifications -Path $_.Fullname

    Update-Section `
        -Path (Join-Path $PSScriptRoot "\IMAGES.md") `
        -Name ("current {0}" -f $_.BaseName) `
        -Content ((SitecoreImageBuilder\Get-CurrentImagesMarkdown -Path $_.Fullname) | Out-String)
}

$dockerFileCount = $specs | Select-Object -Property DockerFilePath -Unique | Measure-Object | Select-Object -ExpandProperty Count
$tagCount = $specs | Select-Object -Property Tag -Unique | Measure-Object | Select-Object -ExpandProperty Count
$repositoryCount = ( $specs | Foreach-Object { Write-Output (($_.Tag -split ":") | Select-Object -First 1) } | Select-Object -Unique).Count
$deprecatedCount = $specs | Where-Object { $_.Deprecated } | Select-Object -Property Tag -Unique | Measure-Object | Select-Object -ExpandProperty Count
$defaultVersion = (SitecoreImageBuilder\Get-LatestSupportedVersion -Specs $specs)

$style = "flat-square"
$stats = ("[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg?style={0})](https://opensource.org/licenses/MIT)" -f $style)
$stats += (" ![{0}](https://img.shields.io/badge/{0}-{1}-{2}.svg?style={3})" -f "Repositories", $repositoryCount, "blue", $style)
$stats += (" ![{0}](https://img.shields.io/badge/{0}-{1}-{2}.svg?style={3})" -f "Tags", $tagCount, "blue", $style)
$stats += (" ![{0}](https://img.shields.io/badge/{0}-{1}-{2}.svg?style={3})" -f "Deprecated", $deprecatedCount, "lightgrey", $style)
$stats += (" ![{0}](https://img.shields.io/badge/{0}-{1}-{2}.svg?style={3})" -f "Dockerfiles", $dockerFileCount, "blue", $style)
$stats += (" ![{0}](https://img.shields.io/badge/Default%20version-{1}%20on%20{2}/{3}-blue?style=flat-square)`n" -f "Default version", $defaultVersion.Sitecore, $defaultVersion.WindowsServerCore, $defaultVersion.NanoServer, "blue", $style)

Update-Section `
    -Path (Resolve-Path $(Join-Path $PSScriptRoot "..\README.md")) `
    -Name "stats" `
    -Content $stats

Pop-Location