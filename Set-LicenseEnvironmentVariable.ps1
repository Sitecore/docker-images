param(
    [Parameter(Mandatory = $true)]
    [ValidateScript( { Test-Path $_ -PathType "Leaf" })]
    [string]$Path
    ,
    [Parameter(Mandatory = $false)]
    [switch]$PersistForCurrentUser
)

$licenseFileStream = [System.IO.File]::OpenRead($Path);
$licenseString = $null

try
{
    $memory = [System.IO.MemoryStream]::new()

    $gzip = [System.IO.Compression.GZipStream]::new($memory, [System.IO.Compression.CompressionLevel]::Optimal, $false);
    $licenseFileStream.CopyTo($gzip);
    $gzip.Close();

    # base64 encode the gzipped content
    $licenseString = [System.Convert]::ToBase64String($memory.ToArray())
}
finally
{
    # cleanup
    if ($null -ne $gzip)
    {
        $gzip.Dispose()
        $gzip = $null
    }

    if ($null -ne $memory)
    {
        $memory.Dispose()
        $memory = $null
    }

    $licenseFileStream = $null
}

# sanity check
if ($licenseString.Length -le 100)
{
    throw "Unknown error, the gzipped and base64 encoded string '$licenseString' is too short."
}

# persist in current session
$env:SITECORE_LICENSE = $licenseString

if ($PersistForCurrentUser)
{
    # persist on machine for future sessions
    [Environment]::SetEnvironmentVariable("SITECORE_LICENSE", $licenseString, "User")
}
