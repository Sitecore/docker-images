param(
    [Parameter(Mandatory = $true)]
    [ValidateScript( { Test-Path $_ -PathType "Leaf" })]
    [string]$Path
    ,
    [Parameter(Mandatory = $false)]
    [Switch]$PersistForCurrentUser
)

$licenseRaw = Get-Content -Path $Path -Raw
$licenseString = $null

try
{
    # gzip content
    $memory = New-Object System.IO.MemoryStream
    $writer = New-Object System.IO.StreamWriter(New-Object System.IO.Compression.GZipStream($memory, [System.IO.Compression.CompressionMode]::Compress))
    $writer.Write($licenseRaw)
    $writer.Flush()

    # base64 encode the gzipped content
    $licenseString = [System.Convert]::ToBase64String($memory.ToArray())
}
catch
{
    if ($null -ne $memory)
    {
        # cleanup
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
