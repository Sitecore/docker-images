$ErrorActionPreference = "STOP"

Import-Module WebAdministration

$iisWebsiteName = "Default Web Site"
$iisApplicationPoolName = "DefaultAppPool"

# print welcome message
Write-Host ("### Sitecore Development ENTRYPOINT, starting...")

# wait for w3wp to stop
while ($true)
{
    $processName = "w3wp"

    Write-Host "### Waiting for process '$processName' to stop..."

    Stop-Process -Name $processName -Force -ErrorAction "SilentlyContinue"

    $processes = [array](Get-Process -Name $processName -ErrorAction "SilentlyContinue")

    if ($processes.Length -eq 0)
    {
        Write-Host "### Process '$processName' stopped..."

        break;
    }

    Start-Sleep -Seconds 1
}

# wait for site to stop
while ($true)
{
    $requiredState = "Stopped"

    Write-Host "### Waiting on site '$iisWebsiteName' state to be '$requiredState'..."

    $item = Get-ItemProperty "IIS:\Sites\$iisWebsiteName"

    if ($null -ne $item -and $item.State -ne $requiredState)
    {
        $item = Stop-WebSite -Name $iisWebsiteName -Passthru -ErrorAction "SilentlyContinue"
    }

    if ($null -ne $item -and $item.State -eq $requiredState)
    {
        Write-Host "### Site '$iisWebsiteName' state is now '$requiredState'..."

        break
    }

    Start-Sleep -Seconds 1
}

# wait for application pool to stop
while ($true)
{
    $requiredState = "Stopped"

    Write-Host "### Waiting on application pool '$iisApplicationPoolName' state to be '$requiredState'..."

    $item = Get-ItemProperty "IIS:\AppPools\$iisApplicationPoolName"

    if ($null -ne $item -and $item.State -ne $requiredState)
    {
        $item = Stop-WebAppPool -Name $iisApplicationPoolName -Passthru -ErrorAction "SilentlyContinue"
    }

    if ($null -ne $item -and $item.State -eq $requiredState)
    {
        Write-Host "### Application pool '$iisApplicationPoolName' state is now '$requiredState'."

        break
    }

    Start-Sleep -Seconds 1
}

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
}

# wait for ServiceMonitor to start
while ($true)
{
    $processName = "ServiceMonitor"

    Write-Host "### Waiting for process '$processName' to start..."

    $processes = [array](Get-Process -Name $processName -ErrorAction "SilentlyContinue")

    if ($processes.Length -eq 1)
    {
        Write-Host "### Process '$processName' started..."

        break;
    }

    Start-Sleep -Seconds 1
}

# wait for application pool to start
while ($true)
{
    $requiredState = "Started"

    Write-Host "### Waiting on application pool '$iisApplicationPoolName' state to be '$requiredState'..."

    $item = Start-WebAppPool -Name $iisApplicationPoolName -Passthru -ErrorAction "SilentlyContinue"

    if ($null -ne $item -and $item.State -eq $requiredState)
    {
        Write-Host "### Application pool '$iisApplicationPoolName' state is now '$requiredState'."

        break
    }

    Start-Sleep -Seconds 1
}

# wait for site to start
while ($true)
{
    $requiredState = "Started"

    Write-Host "### Waiting on site '$iisWebsiteName' state to be '$requiredState'..."

    $item = Start-WebSite -Name $iisWebsiteName -Passthru -ErrorAction "SilentlyContinue"

    if ($null -ne $item -and $item.State -eq $requiredState)
    {
        Write-Host "### Site '$iisWebsiteName' state is now '$requiredState'."

        break
    }

    Start-Sleep -Seconds 1
}

# print ready message
Write-Host ("### Sitecore ready!")

# start filebeat.exe in foreground
& "C:\tools\bin\filebeat\filebeat.exe" -c (Join-Path $PSScriptRoot "\filebeat.yml")