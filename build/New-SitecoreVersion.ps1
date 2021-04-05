param(
    [Parameter()]
    [string]$NewSitecoreVersion,
    [Parameter()]
    [string]$OldSitecoreVersion
)
$buildPath = $PSScriptRoot

Copy-Item  -Path "$buildPath\windows/$OldSitecoreVersion" -Destination "$buildPath\windows\$NewSitecoreVersion" -Recurse
Get-ChildItem -Path "$buildPath\windows\$NewSitecoreVersion\" -Filter *.json -Recurse | ForEach-Object {(Get-Content $_.FullName).Replace($OldSitecoreVersion,$NewSitecoreVersion) |Set-Content $_.FullName}

Copy-Item -Path "$buildPath\linux/$OldSitecoreVersion" -Destination "$buildPath\linux\$NewSitecoreVersion"
Get-ChildItem -Path "$buildPath\linux\$NewSitecoreVersion\" -Filter *.json -Recurse | ForEach-Object {(Get-Content $_.FullName).Replace($OldSitecoreVersion,$NewSitecoreVersion) |Set-Content $_.FullName}
