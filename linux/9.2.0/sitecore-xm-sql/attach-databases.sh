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

echo "### Databases ready."