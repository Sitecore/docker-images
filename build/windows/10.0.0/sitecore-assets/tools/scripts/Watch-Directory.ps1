<#
.SYNOPSIS
    Sync files from source to destination path.
.DESCRIPTION
    Watches source path for file changes and updates the destination path accordingly.
.PARAMETER Path
    Path to watch for changes.
.PARAMETER Destination
    Destination path to keep updated.
.PARAMETER Sleep
    Milliseconds to sleep between sync operations.
.PARAMETER Timeout
    Timeout for sync operation in milliseconds. Default is 0 (disabled).
.PARAMETER DefaultExcludedFiles
    Default files to skip during sync. Default is "*.user", "*.cs", "*.csproj", "packages.config", "*ncrunch*", ".gitignore", ".gitkeep", ".dockerignore", "*.example", "*.disabled".
.PARAMETER ExcludeFiles
    Additional files to skip during sync.
.PARAMETER DefaultExcludedDirectories
    Default directories to skip during sync. Default is "obj", "Properties", "node_modules".
.PARAMETER ExcludeDirectories
    Additional directories to skip during sync.
.EXAMPLE
    PS C:\> .\Watch-Directory.ps1 -Path 'C:\source' -Destination 'C:\destination' -ExcludeFiles @("web.config")
.INPUTS
    None
.OUTPUTS
    None
#>
[CmdletBinding(SupportsShouldProcess)]
param(
    [Parameter(Mandatory = $true)]
    [ValidateScript( { Test-Path $_ -PathType 'Container' })]
    [string]$Path,

    [Parameter(Mandatory = $true)]
    [ValidateScript( { Test-Path $_ -PathType 'Container' })]
    [string]$Destination,

    [Parameter(Mandatory = $false)]
    [int]$Sleep = 200,

    [Parameter(Mandatory = $false)]
    [int]$Timeout = 0,

    [Parameter(Mandatory = $false)]
    [array]$DefaultExcludedFiles = @("*.user", "*.cs", "*.csproj", "packages.config", "*ncrunch*", ".gitignore", ".gitkeep", ".dockerignore", "*.example", "*.disabled"),

    [Parameter(Mandatory = $false)]
    [array]$ExcludeFiles = @(),

    [Parameter(Mandatory = $false)]
    [array]$DefaultExcludedDirectories = @("obj", "Properties", "node_modules"),

    [Parameter(Mandatory = $false)]
    [array]$ExcludeDirectories = @()
)

# Setup
$ErrorActionPreference = "Stop"
$timeFormat = "HH:mm:ss:fff"

# Setup exclude rules
$fileRules = ($DefaultExcludedFiles + $ExcludeFiles) | Select-Object -Unique
$directoryRules = ($DefaultExcludedDirectories + $ExcludeDirectories) | Select-Object -Unique

Write-Information "$(Get-Date -Format $timeFormat): Excluding files: $($fileRules -join ", ")"
Write-Information "$(Get-Date -Format $timeFormat): Excluding directories: $($directoryRules -join ", ")"

# If -WhatIf was used, stop here
if (!$PSCmdlet.ShouldProcess($Path, "Start file watchers")) {
    return
}

# Cleanup old event if present in current session
Get-EventSubscriber -SourceIdentifier "FileDeleted" -ErrorAction "SilentlyContinue" | Unregister-Event

# Setup delete watcher
$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path = $Path
$watcher.IncludeSubdirectories = $true
$watcher.EnableRaisingEvents = $true

$watcherData = New-Object PSObject -Property @{
    Destination = $Destination
    ExcludeFiles = $fileRules
    TimeFormat = $timeFormat
}

Register-ObjectEvent $watcher Deleted -SourceIdentifier "FileDeleted" -MessageData $watcherData {
    $destinationPath = Join-Path $event.MessageData.Destination $eventArgs.Name
    
    if ((Test-Path $eventArgs.FullPath) -or                                                    # Present on source
        !(Test-Path $destinationPath) -or                                                      # Not present on destination
        (Test-Path -Path $destinationPath -PathType "Container") -or                           # Folder
        (($event.MessageData.ExcludeFiles | % { $eventArgs.Name -like $_ }) -contains $true))  # Excluded
    {
        return
    }

    $retries = 50
    while ($retries -gt 0) 
    {
        try
        {
            Remove-Item -Path $destinationPath -Force -Recurse -ErrorAction Stop
            Write-Information "$(Get-Date -Format $event.MessageData.TimeFormat): Deleted '$destinationPath'..."

            $retries = -1
        }
        catch
        {
            $retries--
            Start-Sleep -Milliseconds 100
        }
    }
    if ($retries -eq 0) 
    {
        Write-Error "$(Get-Date -Format $event.MessageData.TimeFormat): Could not delete '$destinationPath'..."
    }
} | Out-Null

function Sync
{
    param(
        [Parameter(Mandatory = $true)]
        $Path,
        [Parameter(Mandatory = $true)]
        $Destination,
        [Parameter(Mandatory = $false)]
        $ExcludeFiles,
        [Parameter(Mandatory = $false)]
        $ExcludeDirectories
    )

    $command = @("robocopy", "`"$Path`"", "`"$Destination`"", "/E", "/XX", "/MT:1", "/NJH", "/NJS", "/FP", "/NDL", "/NP", "/NS", "/R:5", "/W:1")

    if ($ExcludeDirectories.Count -gt 0)
    {
        $command += "/XD "

        $ExcludeDirectories | ForEach-Object {
            $command += "`"$_`" "
        }

        $command = $command.TrimEnd()
    }

    if ($ExcludeFiles.Count -gt 0)
    {
        $command += "/XF "

        $ExcludeFiles | ForEach-Object {
            $command += "`"$_`" "
        }

        $command = $command.TrimEnd()
    }

    $commandString = $command -join " "

    $dirty = $false
    $raw = &([scriptblock]::create($commandString))
    $raw | ForEach-Object {
        $line = $_.Trim().Replace("`r`n", "").Replace("`t", " ")
        $dirty = ![string]::IsNullOrEmpty($line)

        if ($dirty)
        {
            Write-Information "$(Get-Date -Format $timeFormat): $line"
        }
    }

    if ($dirty)
    {
        Write-Information "$(Get-Date -Format $timeFormat): Done syncing..."
    }
}

try
{
    Write-Information "$(Get-Date -Format $timeFormat): Watching '$Path' for changes, will copy to '$Destination'..."

    # Main loop
    $timer = [System.Diagnostics.Stopwatch]::StartNew()
    while ($Timeout -eq 0 -or $timer.ElapsedMilliseconds -lt $Timeout)
    {
        Sync -Path $Path -Destination $Destination -ExcludeFiles $fileRules -ExcludeDirectories $directoryRules

        Start-Sleep -Milliseconds $Sleep
    }
}
finally
{
    # Cleanup
    Get-EventSubscriber -SourceIdentifier "FileDeleted" | Unregister-Event

    if ($null -ne $watcher)
    {
        $watcher.Dispose()
        $watcher = $null
    }

    Write-Information "$(Get-Date -Format $timeFormat): Stopped."
}