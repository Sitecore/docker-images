#!/bin/bash
set -m
set -e

cleanDir=$1
dataDir=$2

# prepare data
if ls $dataDir/Sitecore.*.mdf 1> /dev/null 2>&1; then
    echo "### Done, existing data found in '$dataDir'..."
else
    echo "### No data found in '$dataDir', seeding..."

    cp -R --verbose $cleanDir/. $dataDir/

    echo "### Done seeding."
fi

echo "### Starting SQLServer in background..."

/opt/mssql/bin/sqlservr &
SQL_PID=$!

echo "### SQL Server PID = '$SQL_PID'."

./opt/attach-databases.sh $dataDir

# Pull sql server to foreground and support SIGTERM so shutdown works

echo "### Bring SQLServer to foreground..."

fg

trap "echo '### Stopping PID $SQL_PID'; kill -SIGTERM $SQL_PID" SIGINT SIGTERM

# A signal emitted while waiting will make the wait command return code > 128
# Let's wrap it in a loop that doesn't end before the process is indeed stopped
while kill -0 $SQL_PID > /dev/null 2>&1; do
    wait
done
