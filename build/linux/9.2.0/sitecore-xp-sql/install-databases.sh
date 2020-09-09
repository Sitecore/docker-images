#!/bin/bash

source=$1

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
