[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [ValidateScript( {Test-Path $_ -PathType 'Container'})] 
    [string]$Path
)

Add-Type -Assembly "System.IO.Compression.FileSystem";

# extract mmodule
Get-ChildItem -Path $Path -Filter "*.zip" | ForEach-Object { 
    Write-Host "Extract module: '$_.FullName'"
    Expand-Archive  $_.FullName -DestinationPath (Join-Path $Path $_.GetHashCode())
}