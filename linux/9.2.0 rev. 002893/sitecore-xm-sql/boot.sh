#!/bin/bash

cleanDir=$1
dataDir=$2

# prepare data
if ls $dataDir/*.mdf 1> /dev/null 2>&1; then
    echo "### Done, existing data found in '$dataDir'..."
else
    echo "### No data found in '$dataDir', seeding..."
   
    cp -R --verbose $cleanDir/. $dataDir/

    echo "### Done seeding."
fi

asyncRun() {
    "$@" &
    pid="$!"
    trap "echo 'Stopping PID $pid'; kill -SIGTERM $pid" SIGINT SIGTERM

    # A signal emitted while waiting will make the wait command return code > 128
    # Let's wrap it in a loop that doesn't end before the process is indeed stopped
    while kill -0 $pid > /dev/null 2>&1; do
        wait
    done
}

# run attach script in "background"
nohup bash -c "/opt/attach-databases.sh $dataDir &"

# run sql server and support SIGTERM so shutdown works
asyncRun /opt/mssql/bin/sqlservr
