[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [ValidateScript( { Test-Path $_ -PathType 'Container' })]
    [string]$InstallPath,
    [Parameter(Mandatory = $true)]
    [ValidateScript( { Test-Path $_ -PathType 'Container' })]
    [string]$DataPath,
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [string]$SqlHostname,
    [Parameter(Mandatory = $false)]
    [ValidateNotNullOrEmpty()]
    [string]$DatabasePrefix = "Sitecore"
)

$timeFormat = "HH:mm:ss:fff"

$noDatabases = $null -eq (Get-ChildItem -Path $DataPath -Filter "*.mdf")

if ($noDatabases)
{
    Write-Host "$(Get-Date -Format $timeFormat): Sitecore databases not found in '$DataPath', seeding clean databases..."

    Get-ChildItem -Path $InstallPath | ForEach-Object {
        Copy-Item -Path $_.FullName -Destination $DataPath
    }
}
else
{
    Write-Host "$(Get-Date -Format $timeFormat): Existing Sitecore databases found in '$DataPath'..."
}

Write-Host "$(Get-Date -Format $timeFormat): Waiting for the the MSSQLSERVER service to start..."
(Get-Service MSSQLSERVER).WaitForStatus('Running')
Write-Host "$(Get-Date -Format $timeFormat): MSSQLSERVER service is now running!" -ForegroundColor Green

Get-ChildItem -Path $DataPath -Filter "*.mdf" | ForEach-Object {
    $databaseName = $_.BaseName.Replace("_Primary", "")
    $mdfPath = $_.FullName
    $ldfPath = $mdfPath.Replace(".mdf", ".ldf")

    try {
        Write-Host "$(Get-Date -Format $timeFormat): Setting single user for [$databaseName]..."
        Invoke-Sqlcmd -Query "IF EXISTS (SELECT 1 FROM SYS.DATABASES WHERE NAME = '$databaseName') ALTER DATABASE [$databaseName] SET SINGLE_USER WITH ROLLBACK IMMEDIATE" -Querytimeout 65535 -ConnectionTimeout 65535

        Write-Host "$(Get-Date -Format $timeFormat): Reattaching '$databaseName'..."

        $sqlcmd = "IF EXISTS (SELECT 1 FROM SYS.DATABASES WHERE NAME = '$databaseName') BEGIN EXEC sp_detach_db [$databaseName] END;CREATE DATABASE [$databaseName] ON (FILENAME = N'$mdfPath') FOR ATTACH;"
        if (Test-Path $ldfPath) {
            $sqlcmd = "IF EXISTS (SELECT 1 FROM SYS.DATABASES WHERE NAME = '$databaseName') BEGIN EXEC sp_detach_db [$databaseName] END;CREATE DATABASE [$databaseName] ON (FILENAME = N'$mdfPath'), (FILENAME = N'$ldfPath') FOR ATTACH;"
        }

        # Pass in explicit long timeouts because by default its not infinite (in contrary to what the documentation claims)
        Invoke-Sqlcmd -Query $sqlcmd -Querytimeout 65535 -ConnectionTimeout 65535
    } catch {
        $ErrorMessage = $_.Exception.Message
        Write-Host "$(Get-Date -Format $timeFormat): The following error occurred while attaching $databaseName : $ErrorMessage"
        Write-Host "$(Get-Date -Format $timeFormat): Repairing '$databaseName'..."

        $repairCmd = "ALTER DATABASE [$databaseName] SET EMERGENCY; DBCC CHECKDB ([$databaseName], REPAIR_ALLOW_DATA_LOSS) WITH NO_INFOMSGS";
        Invoke-Sqlcmd -Query $repairCmd -Querytimeout 65535 -ConnectionTimeout 65535
    }
}

Write-Host "$(Get-Date -Format $timeFormat): Preparing Sitecore databases..."

# See http://jonnekats.nl/2017/sql-connection-issue-xconnect/ for details...
Invoke-Sqlcmd -Query ("EXEC sp_MSforeachdb 'IF charindex(''Sitecore'', ''?'' ) = 1 BEGIN EXEC [?]..sp_changedbowner ''sa'' END'")
Invoke-Sqlcmd -Query ("UPDATE [{0}.Xdb.Collection.ShardMapManager].[__ShardManagement].[ShardsGlobal] SET ServerName = '{1}'" -f $DatabasePrefix, $SqlHostname)
Invoke-Sqlcmd -Query ("UPDATE [{0}.Xdb.Collection.Shard0].[__ShardManagement].[ShardsLocal] SET ServerName = '{1}'" -f $DatabasePrefix, $SqlHostname)
Invoke-Sqlcmd -Query ("UPDATE [{0}.Xdb.Collection.Shard1].[__ShardManagement].[ShardsLocal] SET ServerName = '{1}'" -f $DatabasePrefix, $SqlHostname)

Write-Host "$(Get-Date -Format $timeFormat): Sitecore databases ready!"

& C:\Start.ps1 -sa_password $env:sa_password -ACCEPT_EULA $env:ACCEPT_EULA -attach_dbs \"$env:attach_dbs\" -Verbose
