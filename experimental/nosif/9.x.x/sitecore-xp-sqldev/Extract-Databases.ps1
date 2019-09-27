[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [ValidateScript( { Test-Path $_ -PathType 'Container' })]
    [string]$Path
)

Add-Type -Assembly "System.IO.Compression"
Add-Type -Assembly "System.IO.Compression.FileSystem"

Get-ChildItem -Path $Path -Filter "*_single.scwdp.zip" | ForEach-Object {
    $zipPath = $_.FullName

    try
    {
        $stream = New-Object IO.FileStream($zipPath, [IO.FileMode]::Open)
        $zip = New-Object IO.Compression.ZipArchive($stream, [IO.Compression.ZipArchiveMode]::Read)

        ($zip.Entries | Where-Object { $_.FullName -like "*.dacpac" -and $_.Name -notlike "*Xdb.Collection*.dacpac" -and $_.Name -notlike "*Azure.dacpac" } ) | Foreach-Object {
            [IO.Compression.ZipFileExtensions]::ExtractToFile($_, (Join-Path $Path $_.Name), $true)
        }
    }
    finally
    {
        if ($zip -ne $null)
        {
            $zip.Dispose()
        }

        if ($stream -ne $null)
        {
            $stream.Dispose()
        }
    }
}