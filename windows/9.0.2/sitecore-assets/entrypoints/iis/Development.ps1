# print welcome message
Write-Host ("### Sitecore Development ENTRYPOINT, starting...")

# check to see if we should start the VS remote debugger
$useVsDebugger = (Test-Path -Path "C:\remote_debugger\x64\msvsmon.exe" -PathType "Leaf") -eq $true

if ($useVsDebugger)
{
    # start msvsmon.exe in background
    & "C:\remote_debugger\x64\msvsmon.exe" /noauth /anyuser /silent /nostatus /noclrwarn /nosecuritywarn /nofirewallwarn /nowowwarn /timeout:2147483646

    Write-Host ("### Started 'msvsmon.exe'.")
}
else
{
    Write-Host ("### Skipping start of 'msvsmon.exe', to enable you should mount the Visual Studio Remote Debugger directory into 'C:\remote_debugger'.")
}

# check to see if we should start the Watch-Directory script
$useWatchDirectory = (Test-Path -Path "C:\src" -PathType "Container") -eq $true

if ($useWatchDirectory)
{
    # start Watch-Directory.ps1 in background, kill foreground process if it fails
    Start-Job -Name "WatchDirectory.ps1" {
        try
        {
            # TODO: Handle additional Watch-Directory params, use param splattering?

            & "C:\tools\scripts\Watch-Directory.ps1" -Path "C:\src" -Destination "C:\inetpub\wwwroot" -ExcludeFiles "Web.config"
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

# inject Sitecore config files
Copy-Item -Path (Join-Path $PSScriptRoot "\*.config") -Destination "C:\inetpub\wwwroot\App_Config\Include"

# start servicemonitor.exe in background, kill foreground process if it fails
Start-Job -Name "ServiceMonitor.exe" {
    try
    {
        & "C:\ServiceMonitor.exe" "w3svc"
    }
    finally
    {
        Get-Process -Name "filebeat" | Stop-Process -Force
    }
} | ForEach-Object {
    Write-Host ("### Started '$($_.Name)'.")
}

# print ready message
Write-Host ("### Sitecore ready!")

# start filebeat.exe in foreground
& "C:\tools\bin\filebeat\filebeat.exe" -c (Join-Path $PSScriptRoot "\filebeat.yml")