[CmdletBinding()]
param(
    [Parameter(Mandatory = $false)]
    [hashtable]$WatchDirectoryParameters
)

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
Write-Host ("$(Get-Date -Format $timeFormat): Commerce Engine Development ENTRYPOINT, starting...")

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

# check to see if we should start the msvsmon.exe
$useVsDebugger = (Test-Path -Path "C:\remote_debugger\x64\msvsmon.exe" -PathType "Leaf") -eq $true

if ($useVsDebugger)
{
    # start msvsmon.exe in background
    & "C:\remote_debugger\x64\msvsmon.exe" /noauth /anyuser /silent /nostatus /noclrwarn /nosecuritywarn /nofirewallwarn /nowowwarn /timeout:2147483646

    Write-Host ("$(Get-Date -Format $timeFormat): Started 'msvsmon.exe'.")
}
else
{
    Write-Host ("$(Get-Date -Format $timeFormat): Skipping start of 'msvsmon.exe', to enable you should mount the Visual Studio Remote Debugger directory into 'C:\remote_debugger'.")
}

# check to see if we should start the Watch-Directory.ps1 script
$watchDirectoryJobName = "Watch-Directory.ps1"
$useWatchDirectory = $null -ne $WatchDirectoryParameters -bor (Test-Path -Path "C:\src" -PathType "Container") -eq $true

if ($useWatchDirectory)
{
    # setup default parameters if none is supplied
    if ($null -eq $WatchDirectoryParameters)
    {
        $WatchDirectoryParameters = @{ Path = "C:\src"; Destination = "C:\inetpub\wwwroot"; }
    }

    # start Watch-Directory.ps1 in background, kill foreground process if it fails
    Start-Job -Name $watchDirectoryJobName -ArgumentList $WatchDirectoryParameters -ScriptBlock {
        param([hashtable]$params)

        try
        {
            & "C:\tools\scripts\Watch-Directory.ps1" @params
        }
        finally
        {
            Get-Process -Name "filebeat" | Stop-Process -Force
        }
    } | Out-Null

    # wait to see if job have failed (it will if for example parsing in invalid parameters)...
    Start-Sleep -Milliseconds 1000

    Get-Job -Name $watchDirectoryJobName | ForEach-Object {
        $job = $_

        if ($job.State -ne "Running")
        {
            # writes output stream
            Receive-Job $job

            # exit
            exit 1
        }

        Write-Host "$(Get-Date -Format $timeFormat): Job '$($job.Name)' started..."
    }
}
else
{
    Write-Host ("$(Get-Date -Format $timeFormat): Skipping start of '$watchDirectoryJobName', to enable you should mount a directory into 'C:\src'.")
}

# start ServiceMonitor.exe in background, kill foreground process if it fails
Start-Job -Name "ServiceMonitor.exe" -ScriptBlock {
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
Write-Host ("$(Get-Date -Format $timeFormat): Commerce Engine ready!")

# start filebeat.exe in foreground
& "C:\tools\bin\filebeat\filebeat.exe" -c (Join-Path $PSScriptRoot "\filebeat.yml")