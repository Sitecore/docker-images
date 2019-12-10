param(
    [Parameter(Mandatory = $true)]
    [ValidateScript( { Test-Path $_ -PathType "Leaf" })]
    [string]$Path
    ,
    [Parameter(Mandatory = $false)]
    [Switch]$PersistForCurrentUser
)

$licenseString = $null

try
{
    # gzip content
    $memory = New-Object System.IO.MemoryStream
    $gzip = New-Object System.IO.Compression.GZipStream($memory, [System.IO.Compression.CompressionMode]::Compress)
    $licenseFile = [System.IO.File]::OpenRead($Path)
    $licenseFile.CopyTo($gzip)
    $licenseFile.Close()
    $gzip.Close()

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

    if ($null -ne $licenseFile)
    {
        $licenseFile.Dispose()
        $licenseFile = $null
    }

    if ($null -ne $memory)
    {
        $memory.Dispose()
        $memory = $null
    }
}

# persist in current session
$env:SITECORE_LICENSE = $licenseString

if ($PersistForCurrentUser)
{
    # persist on machine for future sessions
    [Environment]::SetEnvironmentVariable("SITECORE_LICENSE", $licenseString, "User")
}
