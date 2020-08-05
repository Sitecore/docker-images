# setup
$ErrorActionPreference = "STOP"

Import-Module WebAdministration

$timeFormat = "HH:mm:ss:fff"

function Wait-WebItemState
{
    param(
        [ValidateNotNullOrEmpty()]
        [string]$IISPath
        ,
        [ValidateSet("Started", "Stopped")]
        [string]$State
    )

    while ($true)
    {
        Write-Host "$(Get-Date -Format $timeFormat): Waiting on item '$IISPath' state to be '$State'..."

        try
        {
            $item = Get-Item -Path $IISPath

            if ($null -ne $item -and $item.State -ne $State)
            {
                if ($State -eq "Started")
                {
                    $item = Start-WebItem -PSPath $IISPath -Passthru -ErrorAction "SilentlyContinue"
                }
                elseif ($State -eq "Stopped")
                {
                    $item = Stop-WebItem -PSPath $IISPath -Passthru -ErrorAction "SilentlyContinue"
                }
            }
        }
        catch
        {
            $item = $null
        }

        if ($null -ne $item -and $item.State -eq $State)
        {
            Write-Host "$(Get-Date -Format $timeFormat): Waiting on item '$IISPath' completed."

            break
        }

        Start-Sleep -Milliseconds 500
    }
}

# print start message
Write-Host ("$(Get-Date -Format $timeFormat): xConnect Production ENTRYPOINT, starting...")

# wait for w3wp to stop
while ($true)
{
    $processName = "w3wp"

    Write-Host "$(Get-Date -Format $timeFormat): Waiting for process '$processName' to stop..."

    $running = [array](Get-Process -Name $processName -ErrorAction "SilentlyContinue").Length -gt 0

    if ($running)
    {
        Stop-Process -Name $processName -Force -ErrorAction "SilentlyContinue"
    }
    else
    {
        Write-Host "$(Get-Date -Format $timeFormat): Process '$processName' stopped..."

        break;
    }

    Start-Sleep -Milliseconds 500
}

# wait for application pool to stop
Wait-WebItemState -IISPath "IIS:\AppPools\DefaultAppPool" -State "Stopped"

# start ServiceMonitor.exe in background, kill foreground process if it fails
Start-Job -Name "ServiceMonitor.exe" {
    try
    {
        & "C:\ServiceMonitor.exe" "w3svc"
    }
    finally
    {
        Get-Process -Name "filebeat" | Stop-Process -Force
    }
} | Out-Null

# wait for the ServiceMonitor.exe process is running
while ($true)
{
    $processName = "ServiceMonitor"

    Write-Host "$(Get-Date -Format $timeFormat): Waiting for process '$processName' to start..."

    $running = [array](Get-Process -Name $processName -ErrorAction "SilentlyContinue").Length -eq 1

    if ($running)
    {
        Write-Host "$(Get-Date -Format $timeFormat): Process '$processName' started..."

        break;
    }

    Start-Sleep -Milliseconds 500
}

# wait for application pool to start
Wait-WebItemState -IISPath "IIS:\AppPools\DefaultAppPool" -State "Started"

# print ready message
Write-Host ("$(Get-Date -Format $timeFormat): xConnect ready!")

# start filebeat.exe in foreground
& "C:\tools\bin\filebeat\filebeat.exe" -c (Join-Path $PSScriptRoot "\filebeat.yml")