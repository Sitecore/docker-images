#!/bin/bash
set -m
set -e

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

echo "### Starting Solr in background..."

/opt/docker-solr/scripts/docker-entrypoint.sh solr-foreground &
SOLR_PID=$!

echo "### Solr PID = '$SOLR_PID'."

# Pull solr to foreground and support SIGTERM so shutdown works

echo "### Bring Solr to foreground..."

fg

trap "echo '### Stopping PID $SOLR_PID'; kill -SIGTERM $SOLR_PID" SIGINT SIGTERM

# A signal emitted while waiting will make the wait command return code > 128
# Let's wrap it in a loop that doesn't end before the process is indeed stopped
while kill -0 $SOLR_PID > /dev/null 2>&1; do
    wait
done
