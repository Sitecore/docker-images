$ErrorActionPreference = "STOP"

# print welcome message
Write-Host ("### Sitecore Production ENTRYPOINT, starting...")

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