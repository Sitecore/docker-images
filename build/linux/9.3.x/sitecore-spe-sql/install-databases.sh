#!/bin/bash
source=$1

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

echo "### Installing databases..."

set -e

for filename in $source/*.dacpac; do
    [ -e "$filename" ] || continue

    fileBaseName=$(basename $filename .dacpac)
    databaseName="Sitecore.${fileBaseName}"

    echo "### Installing '$databaseName' from '$filename'..."

    /opt/sqlpackage/sqlpackage /a:Publish /tsn:. /tdn:$databaseName /tu:sa /tp:$SA_PASSWORD /sf:$filename /tt:120 /q
done
