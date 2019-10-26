Start-Job -Name "ServiceMonitor" {
    & C:\ServiceMonitor.exe "w3svc"

    Get-Process -Name "filebeat" | Stop-Process -Force
} | Out-Null

& "C:\tools\bin\filebeat\filebeat.exe" -c "C:\tools\boot\filebeat.yml"