#!/bin/bash

dataDir=$1 
cleanDir=/clean

if [ -z "$(ls -A $dataDir)" ]; then
    echo "### No data found in '$dataDir', seeding clean cores..."
   
    cp -R --verbose $cleanDir/. $dataDir/

    echo "### Done seeding."
else
    echo "### Done, existing data found in '$dataDir'..."
fi

bash /opt/docker-solr/scripts/docker-entrypoint.sh solr-foreground