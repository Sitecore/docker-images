Set-StrictMode -Version 3.0

$private = @(Get-ChildItem -Path (Join-Path $PSScriptRoot "\Private") -Include "*.ps1" -File -Recurse)
$public = @(Get-ChildItem -Path (Join-Path $PSScriptRoot "\Public") -Include "*.ps1" -File -Recurse)

($private + $public) | ForEach-Object {
    try
    {
        . $_.FullName
    }
    catch
    {
        Write-Warning $_.Exception.Message
    }
}