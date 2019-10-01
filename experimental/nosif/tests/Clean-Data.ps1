Get-ChildItem -Path (Join-Path $PSScriptRoot "\data") -Directory | ForEach-Object {
    $dataPath = $_.FullName

    Get-ChildItem -Path $dataPath | ForEach-Object {
        Get-ChildItem -Path $_.FullName -Exclude ".gitkeep" -Recurse | Remove-Item -Force -Recurse -Verbose
    }
}