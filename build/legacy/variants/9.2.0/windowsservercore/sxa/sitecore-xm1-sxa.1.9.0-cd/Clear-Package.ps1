[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [ValidateScript( { Test-Path $_ -PathType "Leaf" })] 
    [string]$Path
)

$tempPath = Join-Path $PSScriptRoot "\temp"

# unzip so we can update parameters and archive files
Expand-Archive -Path $Path -DestinationPath $tempPath -Force;

function Remove-Elements($XmlPath, $XPath)
{
    [xml]$xml = Get-Content -Path $XmlPath

    $node = $xml.SelectSingleNode($XPath)

    while ($null -ne $node)
    {
        $node.ParentNode.RemoveChild($node) | Out-Null
        $node = $xml.SelectSingleNode($XPath)
    }

    $xml.Save($XmlPath)
}

# remove sql parameter elements from paramters
Remove-Elements -XmlPath (Join-Path $tempPath "parameters.xml") -XPath ".//parameter[contains(@tags, 'SQLConnectionString')]"

# remove dacfx elements from archive
Remove-Elements -XmlPath (Join-Path $tempPath "archive.xml") -XPath ".//dbDacFx"

Add-Type -AssemblyName "System.IO.Compression"
Add-Type -AssemblyName "System.IO.Compression.FileSystem"

try
{
    $stream = New-Object IO.FileStream($Path, [IO.FileMode]::Open)
    $zip = New-Object IO.Compression.ZipArchive($stream, [IO.Compression.ZipArchiveMode]::Update)

    # delete dacpac, old parameters and archive files
    ($zip.Entries | Where-Object { $_.FullName -like "*.dacpac" -or $_.FullName -eq "parameters.xml" -or $_.FullName -eq "archive.xml" }) | Foreach-Object { 
        $_.Delete()
    }

    # update zip with new parameters and archive files
    [System.IO.Compression.ZipFileExtensions]::CreateEntryFromFile($zip, (Join-Path $tempPath "\parameters.xml"), "parameters.xml", "Optimal") | Out-Null
    [System.IO.Compression.ZipFileExtensions]::CreateEntryFromFile($zip, (Join-Path $tempPath "\archive.xml"), "archive.xml", "Optimal") | Out-Null
}
finally
{
    if ($null -ne $zip)
    {
        $zip.Dispose()
    }

    if ($null -ne $stream)
    {   
        $stream.Dispose()
    }
}
