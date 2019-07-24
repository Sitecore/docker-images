#!/bin/bash

cleanDir=$1
dataDir=$2

# prepare data
if [ ! -f "$dataDir/solr.xml" ]; then
    echo "### No solr.xml found in '$dataDir', seeding..."
   
    cp -R --verbose $cleanDir/. $dataDir/

    echo "### Done seeding."
else
    echo "### Done, existing data found in '$dataDir'..."

    # cleanup old lock files
    find $dataDir/. -name write.lock -print0 | xargs -0 rm -rf
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

asyncRun /opt/docker-solr/scripts/docker-entrypoint.sh solr-foreground