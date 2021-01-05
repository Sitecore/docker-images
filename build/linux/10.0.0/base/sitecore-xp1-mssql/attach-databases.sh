#!/bin/bash

dataDir=$1

for attempt in {1..10}
do
    echo "### Connection attempt $attempt..."

    /opt/mssql-tools/bin/sqlcmd -S . -U sa -P $SA_PASSWORD -t 120 -l 120 -Q "SELECT Name from sys.Databases" >/dev/null 2>&1

    if [[ $? == 0 ]]; then
        echo "### Connected."

        break
    else
        echo "### Retrying..."

        sleep 1
    fi
done

echo "### Attaching databases in '$dataDir':"

set -e

for filename in $dataDir/Sitecore.*.mdf; do
    [ -e "$filename" ] || continue

    fileBaseName=$(basename $filename .mdf)
    databaseName="${fileBaseName/_Primary/}"
    ldfPath="$dataDir/$fileBaseName.ldf"
    mdfPath=$filename

    echo "### Attaching '$databaseName' from '$mdfPath' and '$ldfPath'..."

    /opt/mssql-tools/bin/sqlcmd -S . -U sa -P $SA_PASSWORD -t 60 -l 300 -Q "CREATE DATABASE [$databaseName] ON (FILENAME = '$mdfPath'),(FILENAME = '$ldfPath') FOR ATTACH"
done

echo "### Databases ready."