<#
#Requires -RunAsAdministrator

# Get Functions
#Write-Host $PSScriptRoot

$private = Get-ChildItem -Path (Join-Path $PSScriptRoot 'Private') -Include *.ps1 -File -Recurse

# Dot source to scope
# Private must be sourced first - usage in public functions during load
($private) | ForEach-Object {
    try {
		Write-Host $_.FullName
        . $_.FullName
    }
    catch {
        Write-Warning $_.Exception.Message
    }
}
#>
