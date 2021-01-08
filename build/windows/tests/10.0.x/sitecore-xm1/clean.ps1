# Clean data folders
Get-ChildItem -Path (Join-Path $PSScriptRoot "\mssql-data") -Exclude ".gitkeep" -Recurse | Remove-Item -Force -Recurse -Verbose
Get-ChildItem -Path (Join-Path $PSScriptRoot "\solr-data") -Exclude ".gitkeep" -Recurse | Remove-Item -Force -Recurse -Verbose