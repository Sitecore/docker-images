param(
    [Parameter(Mandatory)]
    [ValidateScript( { Test-Path $_ -PathType Container })]
    [string]$ResourcesDirectory,
    [Parameter(Mandatory)][string]$SqlServer,
    [Parameter(Mandatory)][string]$SqlAdminUser,
    [Parameter(Mandatory)][string]$SqlAdminPassword,
    [string]$SqlElasticPoolName
)

function Set-VariablesInSqlScript
{
    param(
        [string]$pathToScript,
        [string]$SqlServer,
        [string]$ShardNamePrefix
    )

    $content = Get-Content -Path $pathToScript

    $content = $content -replace 'dbserverplaceholder.database.windows.net', $SqlServer
    $content = $content -replace 'PlaceholderShard0', "$($shardNamePrefix)0"
    $content = $content -replace 'PlaceholderShard1', "$($shardNamePrefix)1"

    Set-Content $content -Path $pathToScript
}

function New-DacpacDeployment
{
    param(
        [string]$DacpacPath,
        [string]$SqlServer,
        [string]$SqlAdminUser,
        [string]$SqlAdminPassword,
        [string]$DatabaseName
    )

    $sqlPackageExePath = "/opt/sqlpackage/sqlpackage"

    & $sqlPackageExePath /a:Publish /sf:"$DacpacPath" /tsn:"$SqlServer" /tdn:"$DatabaseName" /tu:"$SqlAdminUser" /tp:"$SqlAdminPassword" /p:AllowIncompatiblePlatform=True

    if ($LASTEXITCODE -ne 0)
    {
        throw "sqlpackage exited with code $LASTEXITCODE"
    }
}

function New-SqlScriptDeployment
{
    param(
        [string]$ScriptPath,
        [string]$SqlServer,
        [string]$SqlAdminUser,
        [string]$SqlAdminPassword,
        [string]$DatabaseName
    )
    /opt/mssql-tools/bin/sqlcmd -i $ScriptPath -S $SqlServer -d $DatabaseName `
        -U $SqlAdminUser -P $SqlAdminPassword

    if ($LASTEXITCODE -ne 0)
    {
        throw "/opt/mssql-tools/bin/sqlcmd exited with code $LASTEXITCODE"
    }
}

function New-DatabaseElasticPool
{
    param(
        [string]$SqlElasticPoolName,
        [string]$SqlServer,
        [string]$SqlAdminUser,
        [string]$SqlAdminPassword,
        [string]$SqlDatabase
    )
    Write-Host "Start creating database '$SqlDatabase' with azure elastic pool '$SqlElasticPoolName'"
    $Query = "CREATE DATABASE [$SqlDatabase]"

    & /opt/mssql-tools/bin/sqlcmd -Q $Query -S "$SqlServer" -U "$SqlAdminUser" -P "$SqlAdminPassword"

    if ($LASTEXITCODE -ne 0)
    {
        throw "/opt/mssql-tools/bin/sqlcmd exited with code $LASTEXITCODE while creating database $databaseName with elasic pool"
    }
}

$dbShardMapManager = "Sitecore.Xdb.Collection.ShardMapManager"
$shardNamePrefix = "Sitecore.Xdb.Collection.Shard"

if ($SqlElasticPoolName)
{

    New-DatabaseElasticPool -SqlElasticPoolName $SqlElasticPoolName -SqlServer $SqlServer -SqlAdminUser $SqlAdminUser `
        -SqlAdminPassword $SqlAdminPassword -SqlDatabase $dbShardMapManager

    New-DatabaseElasticPool -SqlElasticPoolName $SqlElasticPoolName -SqlServer $SqlServer -SqlAdminUser $SqlAdminUser `
        -SqlAdminPassword $SqlAdminPassword -SqlDatabase "$($shardNamePrefix)0"

    New-DatabaseElasticPool -SqlElasticPoolName $SqlElasticPoolName -SqlServer $SqlServer -SqlAdminUser $SqlAdminUser `
        -SqlAdminPassword $SqlAdminPassword -SqlDatabase "$($shardNamePrefix)1"

    New-DacpacDeployment -DacpacPath (Join-Path $ResourcesDirectory "Sitecore.Xdb.Collection.Shard0.dacpac") -SqlServer $SqlServer -SqlAdminUser $SqlAdminUser `
        -SqlAdminPassword $SqlAdminPassword -DatabaseName "$($shardNamePrefix)0"

    New-DacpacDeployment -DacpacPath (Join-Path $ResourcesDirectory "Sitecore.Xdb.Collection.Shard1.dacpac") -SqlServer $SqlServer -SqlAdminUser $SqlAdminUser `
        -SqlAdminPassword $SqlAdminPassword -DatabaseName "$($shardNamePrefix)1"

    Set-VariablesInSqlScript (Join-Path $ResourcesDirectory "smm_azure.sql") -SqlServer $SqlServer -ShardNamePrefix $shardNamePrefix
    Set-VariablesInSqlScript (Join-Path $ResourcesDirectory "shard0_azure.sql") -SqlServer $SqlServer -ShardNamePrefix $shardNamePrefix
    Set-VariablesInSqlScript (Join-Path $ResourcesDirectory "shard1_azure.sql") -SqlServer $SqlServer -ShardNamePrefix $shardNamePrefix

    New-SqlScriptDeployment -ScriptPath (Join-Path $ResourcesDirectory "smm_azure.sql") -SqlServer $SqlServer `
        -SqlAdminUser $SqlAdminUser -SqlAdminPassword $SqlAdminPassword -DatabaseName $dbShardMapManager

    New-SqlScriptDeployment -ScriptPath (Join-Path $ResourcesDirectory "shard0_azure.sql") -SqlServer $SqlServer `
        -SqlAdminUser $SqlAdminUser -SqlAdminPassword $SqlAdminPassword -DatabaseName "$($shardNamePrefix)0"

    New-SqlScriptDeployment -ScriptPath (Join-Path $ResourcesDirectory "shard1_azure.sql") -SqlServer $SqlServer `
        -SqlAdminUser $SqlAdminUser -SqlAdminPassword $SqlAdminPassword -DatabaseName "$($shardNamePrefix)1"
}
else
{
    $shardNameSuffix = '""'
    $dacPacPath = (Join-Path $ResourcesDirectory "Sitecore.Xdb.Collection.Database.Sql.dacpac")
    $shardToolExe = (Join-Path $ResourcesDirectory "collectiondeployment\Sitecore.Xdb.Collection.Database.SqlShardingDeploymentTool.exe")

    $ShardDeploymentToolConnectionString = "Server=$($SqlServer);User ID=$($SqlAdminUser);Password=$($SqlAdminPassword)"

    & $shardToolExe /operation create /connectionstring $ShardDeploymentToolConnectionString /shardMapManagerDatabaseName $dbShardMapManager `
        /dbedition Basic /shardnumber 2 /shardnameprefix $shardNamePrefix /shardnamesuffix $shardNameSuffix /dacpac $dacPacPath
}