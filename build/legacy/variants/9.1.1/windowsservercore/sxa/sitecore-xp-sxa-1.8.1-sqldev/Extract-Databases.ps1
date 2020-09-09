[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [ValidateScript( { Test-Path $_ -PathType 'Container' })] 
    [string]$Path
)

# extract module
Get-ChildItem -Path $Path -Filter "*.zip" | ForEach-Object {
    Expand-Archive  $_.FullName -DestinationPath (Join-Path $Path $_.GetHashCode())
}