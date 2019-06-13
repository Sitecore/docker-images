[CmdletBinding()]
param(
    # Path to watch for changes
    [Parameter(Mandatory = $true)]
    [ValidateScript( {Test-Path $_ -PathType 'Container'})] 
    $Path,
    # Destination path to keep updated
    [Parameter(Mandatory = $true)]
    [ValidateScript( {Test-Path $_ -PathType 'Container'})] 
    $Destination
)

function Sync
{
    param(
        [Parameter(Mandatory = $true)]
        $Path,
        [Parameter(Mandatory = $true)]
        $Destination
    )

    $dirty = $false
    $raw = (robocopy $Path $Destination /E /XX /MT:1 /NJH /NJS /FP /NDL /NP /NS /R:5 /W:1 /XD obj /XF *.user /XF *ncrunch* /XF *.cs)
    $raw | ForEach-Object {
        $line = $_.Trim().Replace("`r`n", "").Replace("`t", " ")
        $dirty = ![string]::IsNullOrEmpty($line)

        if ($dirty)
        {
            Write-Host ("{0}: {1}" -f [DateTime]::Now.ToString("HH:mm:ss:fff"), $line) -ForegroundColor DarkGray            
        }
    }

    if ($dirty)
    {
        Write-Host ("{0}: Done syncing..." -f [DateTime]::Now.ToString("HH:mm:ss:fff")) -ForegroundColor Green
    }
}

Write-Host ("{0}: Watching '{1}' for changes, will copy to '{2}'..." -f [DateTime]::Now.ToString("HH:mm:ss:fff"), $Path, $Destination)

# Cleanup old event if present in current session
Get-EventSubscriber -SourceIdentifier "FileDeleted" -ErrorAction "SilentlyContinue" | Unregister-Event

# Setup
$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path = $Path
$watcher.IncludeSubdirectories = $true
$watcher.EnableRaisingEvents = $true

Register-ObjectEvent $watcher Deleted -SourceIdentifier "FileDeleted" -MessageData $Destination {
    $destinationPath = Join-Path $event.MessageData $eventArgs.Name
    $delete = !(Test-Path $eventArgs.FullPath) -and (Test-Path $destinationPath)

    if ($delete)
    {
        try
        {
            Remove-Item -Path $destinationPath -Force -Recurse -ErrorAction "SilentlyContinue"

            Write-Host ("{0}: Deleted '{1}'..." -f [DateTime]::Now.ToString("HH:mm:ss:fff"), $destinationPath) -ForegroundColor Green
        }
        catch
        {
            Write-Host ("{0}: Could not delete '{1}'..." -f [DateTime]::Now.ToString("HH:mm:ss:fff"), $destinationPath) -ForegroundColor Red
        }
    }
} | Out-Null

try
{
    # Main loop
    while ($true)
    {
        Sync -Path $Path -Destination $Destination

        Start-Sleep -Milliseconds 200
    }
}
finally 
{
    # Cleanup
    Get-EventSubscriber -SourceIdentifier "FileDeleted" | Unregister-Event

    if ($watcher -ne $null)
    {
        $watcher.Dispose()
        $watcher = $null
    }

    Write-Host ("{0}: Stopped." -f [DateTime]::Now.ToString("HH:mm:ss:fff")) -ForegroundColor Red
}