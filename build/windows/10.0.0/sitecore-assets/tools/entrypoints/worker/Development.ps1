[CmdletBinding()]
param(
    [Parameter(Mandatory = $false)]
    [hashtable]$WatchDirectoryParameters
)

# setup
$ErrorActionPreference = "STOP"

$timeFormat = "HH:mm:ss:fff"

# print start message
Write-Host ("$(Get-Date -Format $timeFormat): Sitecore Development ENTRYPOINT, starting...")

# check to see if we should start the Watch-Directory.ps1 script
$watchDirectoryJobName = "Watch-Directory.ps1"
$useWatchDirectory = $null -ne $WatchDirectoryParameters -bor (Test-Path -Path "C:\src" -PathType "Container") -eq $true

if ($useWatchDirectory)
{
    # setup default parameters if none is supplied
    if ($null -eq $WatchDirectoryParameters)
    {
        $WatchDirectoryParameters = @{ Path = "C:\src"; Destination = "C:\worker"; }
    }

    # start Watch-Directory.ps1 in background, kill foreground process if it fails
    Start-Job -Name $watchDirectoryJobName -ArgumentList $WatchDirectoryParameters -ScriptBlock {
        param([hashtable]$params)

        & "C:\tools\scripts\Watch-Directory.ps1" @params

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

& "C:\\worker\\$($env:SC_ROLE_EXE)"
