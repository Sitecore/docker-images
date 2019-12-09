# setup
$ErrorActionPreference = "STOP"

# print start message
Write-Host ("### Sitecore Development ENTRYPOINT, starting...")

# check to see if we should start the Watch-Directory.ps1 script
$useWatchDirectory = (Test-Path -Path "C:\src" -PathType "Container") -eq $true

if ($useWatchDirectory)
{
    # start Watch-Directory.ps1 in background, kill foreground process if it fails
    Start-Job -Name "WatchDirectory.ps1" {
        try
        {
            # TODO: Handle additional Watch-Directory params, use param splattering?

            & "C:\tools\scripts\Watch-Directory.ps1" -Path "C:\src" -Destination "C:\worker" -ExcludeFiles "Web.config"
        }
        finally
        {
            Get-Process -Name "filebeat" | Stop-Process -Force
        }
    } | ForEach-Object {
        Write-Host ("### Started '$($_.Name)'.")
    }
}
else
{
    Write-Host ("### Skipping start of 'WatchDirectory.ps1', to enable you should mount a directory into 'C:\src'.")
}

& C:\\worker\\$($env:SC_ROLE_EXE)