#!/bin/bash

source=$1

echo "### Installing shards..."

for filename in $source/*.bacpac; do
    [ -e "$filename" ] || continue

    fileBaseName=$(basename $filename .bacpac)
    databaseName="${DB_PREFIX}_${fileBaseName/Sitecore./}"
    
    echo "### Installing '$databaseName' from '$filename'..."

    /opt/sqlpackage/sqlpackage /a:Import /tsn:. /tdn:$databaseName /tu:sa /tp:$SA_PASSWORD /sf:$filename
done
