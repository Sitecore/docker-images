[CmdletBinding()]
param(
    [Parameter(Mandatory = $false)]
    [hashtable]$WatchDirectoryParameters
)

# Setup
$ErrorActionPreference = "Stop"
$InformationPreference = "Continue"
$timeFormat = "HH:mm:ss:fff"

# Print start message
Write-Host "$(Get-Date -Format $timeFormat): Development ENTRYPOINT: starting..."

# Check to see if we should start the Watch-Directory.ps1 script
$watchDirectoryJobName = "Watch-Directory.ps1"
$useWatchDirectory = $null -ne $WatchDirectoryParameters -bor (Test-Path -Path "C:\deploy" -PathType "Container") -eq $true

if ($useWatchDirectory)
{
    # Setup default parameters if none is supplied
    if ($null -eq $WatchDirectoryParameters)
    {
        $WatchDirectoryParameters = @{ Path = "C:\deploy"; Destination = "C:\service"; }
    }

    Write-Host "$(Get-Date -Format $timeFormat): Development ENTRYPOINT: '$watchDirectoryJobName' validating..."

    # First a trial-run to catch any parameter validation / setup errors
    $WatchDirectoryParameters["WhatIf"] = $true
    & "C:\tools\scripts\Watch-Directory.ps1" @WatchDirectoryParameters
    $WatchDirectoryParameters["WhatIf"] = $false
    
    Write-Host "$(Get-Date -Format $timeFormat): Development ENTRYPOINT: '$watchDirectoryJobName' starting..."

    # Start Watch-Directory.ps1 in background
    Start-Job -Name $watchDirectoryJobName -ArgumentList $WatchDirectoryParameters -ScriptBlock {
        param([hashtable]$params)

        & "C:\tools\scripts\Watch-Directory.ps1" @params

    } | Out-Null

    Write-Host "$(Get-Date -Format $timeFormat): Development ENTRYPOINT: '$watchDirectoryJobName' started."
}
else
{
    Write-Host ("$(Get-Date -Format $timeFormat): Development ENTRYPOINT: Skipping start of '$watchDirectoryJobName'. To enable you should mount a directory into 'C:\deploy'.")
}

# Print ready message
Write-Host "$(Get-Date -Format $timeFormat): Development ENTRYPOINT: ready!"

& "C:\\service\\$($env:WORKER_EXECUTABLE_NAME_ENV)"