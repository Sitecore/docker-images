#!/bin/bash

source=$1

( /opt/mssql/bin/sqlservr & ) | grep -q "Service Broker manager has started"

echo "### Installing databases..."

for filename in $source/*.dacpac; do
    [ -e "$filename" ] || continue
    
    if [[ $filename == *"Xdb.Collection"* ]]; then
        continue
    fi

    fileBaseName=$(basename $filename .dacpac)
    databaseName="${DB_PREFIX}_${fileBaseName/Sitecore./}"
    
    echo "### Installing '$databaseName' from '$filename'..."

    /opt/sqlpackage/sqlpackage /a:Publish /tsn:. /tdn:$databaseName /tu:sa /tp:$SA_PASSWORD /sf:$filename
done

pkill sqlservr 