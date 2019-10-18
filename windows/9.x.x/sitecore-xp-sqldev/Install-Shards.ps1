[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [ValidateScript( { Test-Path $_ -PathType 'Container' })]
    [string]$InstallPath
)

$shardToolPath = Join-Path $InstallPath "\shardtool"

# Extract shard tool, install shards and remove
Expand-Archive -Path (Join-Path $InstallPath "\\*_*xconnect.scwdp.zip") -DestinationPath $shardToolPath

$dbShardMapManager = "Sitecore.Xdb.Collection.ShardMapManager";
$dbShardNamePrefix = "Sitecore.Xdb.Collection.Shard";
$dbShard0 = "{0}0" -f $dbShardNamePrefix;
$dbShard1 = "{0}1" -f $dbShardNamePrefix;
$dacPacPath = Join-Path $shardToolPath "\\Content\\Website\\App_Data\\collectiondeployment\\Sitecore.Xdb.Collection.Database.Sql.dacpac"
$shardToolExe = Join-Path $shardToolPath "\\Content\\Website\\App_Data\\collectiondeployment\\Sitecore.Xdb.Collection.Database.SqlShardingDeploymentTool.exe"

& $shardToolExe /operation create /connectionstring "Server=.;Trusted_Connection=True;" /dbedition Basic /shardMapManagerDatabaseName $dbShardMapManager /shardMapNames "ContactIdShardMap,DeviceProfileIdShardMap,ContactIdentifiersIndexShardMap" /shardnumber 2 /shardnameprefix $dbShardNamePrefix /shardnamesuffix '""' /dacpac $dacPacPath

Remove-Item -Path $shardToolPath -Force -Recurse

# Detach databases
Invoke-Sqlcmd -Query "EXEC MASTER.dbo.sp_detach_db @dbname = N'$dbShardMapManager', @keepfulltextindexfile = N'false'"
Invoke-Sqlcmd -Query "EXEC MASTER.dbo.sp_detach_db @dbname = N'$dbShard0', @keepfulltextindexfile = N'false'"
Invoke-Sqlcmd -Query "EXEC MASTER.dbo.sp_detach_db @dbname = N'$dbShard1', @keepfulltextindexfile = N'false'"

# Get data path
$server = New-Object Microsoft.SqlServer.Management.Smo.Server($env:COMPUTERNAME)
$dataPath = $server.Properties["DefaultFile"].Value

# Move database log files to install directory without the _log postfix
Move-Item (Join-Path $dataPath ("\{0}`_log.ldf" -f $dbShardMapManager)) -Destination (Join-Path $InstallPath "\${dbShardMapManager}.ldf")
Move-Item (Join-Path $dataPath ("\{0}`_log.ldf" -f $dbShard0)) -Destination (Join-Path $InstallPath "\${dbShard0}.ldf")
Move-Item (Join-Path $dataPath ("\{0}`_log.ldf" -f $dbShard1)) -Destination (Join-Path $InstallPath "\${dbShard1}.ldf")

# Move databases to install directory
Move-Item (Join-Path $dataPath "\*Xdb.Collection*.mdf") -Destination $InstallPath
