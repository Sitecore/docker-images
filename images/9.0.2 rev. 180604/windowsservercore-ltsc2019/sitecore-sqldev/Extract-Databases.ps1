[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [ValidateScript( {Test-Path $_ -PathType 'Container'})] 
    [string]$Path
)

Add-Type -Assembly "System.IO.Compression.FileSystem";

Expand-Archive -Path (Join-Path $Path '*(WDP*).zip') -DestinationPath $Path -Force;

Get-ChildItem -Path $Path -Filter "*(OnPrem)*.zip" | ForEach-Object {
    $zipPath = $_.FullName

    try
    {
        $zip = [IO.Compression.ZipFile]::OpenRead($zipPath)
 
        ($zip.Entries | Where-Object { $_.FullName -like "Sitecore.*.dacpac" -and !($_.Name -like "*azure*") }) | Foreach-Object { 
            [IO.Compression.ZipFileExtensions]::ExtractToFile($_, (Join-Path $Path $_.Name), $true)
        }
    }
    finally
    {
        if ($zip -ne $null)
        {
            $zip.Dispose()
        }
    }
}