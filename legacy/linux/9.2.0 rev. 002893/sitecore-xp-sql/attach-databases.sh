#!/bin/bash

dataDir=$1

echo "### Attaching databases in '$dataDir':"

ls $dataDir 

for filename in $dataDir/*.mdf; do
    [ -e "$filename" ] || continue

    fileBaseName=$(basename $filename .mdf)
    databaseName="${fileBaseName/_Primary/}"
    ldfPath="$dataDir/$fileBaseName.ldf"
    mdfPath=$filename 

    echo "### Attaching '$databaseName' using '$mdfPath' and '$ldfPath'..."

    /opt/mssql-tools/bin/sqlcmd -S . -U SA -P $SA_PASSWORD -t 60 -l 300 -Q "CREATE DATABASE [$databaseName] ON (FILENAME = '$mdfPath'),(FILENAME = '$ldfPath') FOR ATTACH"
done

echo "### Preparing shards..."

/opt/mssql-tools/bin/sqlcmd -S . -U SA -P $SA_PASSWORD -t 60 -l 300 -Q "EXEC sp_MSforeachdb 'IF charindex(''${DB_PREFIX}'', ''?'' ) = 1 BEGIN EXEC [?]..sp_changedbowner ''sa'' END'"
/opt/mssql-tools/bin/sqlcmd -S . -U SA -P $SA_PASSWORD -t 60 -l 300 -Q "UPDATE [${DB_PREFIX}_Xdb.Collection.ShardMapManager].[__ShardManagement].[ShardsGlobal] SET ServerName = '${SQL_HOSTNAME}'"
/opt/mssql-tools/bin/sqlcmd -S . -U SA -P $SA_PASSWORD -t 60 -l 300 -Q "UPDATE [${DB_PREFIX}_Xdb.Collection.Shard0].[__ShardManagement].[ShardsLocal] SET ServerName = '${SQL_HOSTNAME}'"
/opt/mssql-tools/bin/sqlcmd -S . -U SA -P $SA_PASSWORD -t 60 -l 300 -Q "UPDATE [${DB_PREFIX}_Xdb.Collection.Shard1].[__ShardManagement].[ShardsLocal] SET ServerName = '${SQL_HOSTNAME}'"

echo "### Databases ready."