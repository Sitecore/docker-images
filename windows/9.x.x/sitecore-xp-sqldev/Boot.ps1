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

Get-ChildItem -Path $DataPath -Filter "*.mdf" | ForEach-Object {
    $databaseName = $_.BaseName.Replace("_Primary", "")
    $mdfPath = $_.FullName
    $ldfPath = $mdfPath.Replace(".mdf", ".ldf")
    $sqlcmd = "IF EXISTS (SELECT 1 FROM SYS.DATABASES WHERE NAME = '$databaseName') BEGIN EXEC sp_detach_db [$databaseName] END;CREATE DATABASE [$databaseName] ON (FILENAME = N'$mdfPath'), (FILENAME = N'$ldfPath') FOR ATTACH;"

    Write-Host "$(Get-Date -Format $timeFormat): Attaching '$databaseName'..."

    Invoke-Sqlcmd -Query $sqlcmd
}

Write-Host "$(Get-Date -Format $timeFormat): Preparing Sitecore databases..."

# See http://jonnekats.nl/2017/sql-connection-issue-xconnect/ for details...
Invoke-Sqlcmd -Query ("EXEC sp_MSforeachdb 'IF charindex(''Sitecore'', ''?'' ) = 1 BEGIN EXEC [?]..sp_changedbowner ''sa'' END'")
Invoke-Sqlcmd -Query ("UPDATE [{0}.Xdb.Collection.ShardMapManager].[__ShardManagement].[ShardsGlobal] SET ServerName = '{1}'" -f $DatabasePrefix, $SqlHostname)
Invoke-Sqlcmd -Query ("UPDATE [{0}.Xdb.Collection.Shard0].[__ShardManagement].[ShardsLocal] SET ServerName = '{1}'" -f $DatabasePrefix, $SqlHostname)
Invoke-Sqlcmd -Query ("UPDATE [{0}.Xdb.Collection.Shard1].[__ShardManagement].[ShardsLocal] SET ServerName = '{1}'" -f $DatabasePrefix, $SqlHostname)

Write-Host "$(Get-Date -Format $timeFormat): Sitecore databases ready!"

& C:\Start.ps1 -sa_password $env:sa_password -ACCEPT_EULA $env:ACCEPT_EULA -attach_dbs \"$env:attach_dbs\" -Verbose
