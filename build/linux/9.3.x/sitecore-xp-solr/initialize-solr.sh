#!/bin/bash
echo "initialize-solr"
set -e
CORES_DIR='/opt/solr/server/solr'
ORIG_IFS=${IFS}
IFS=', '
for core in ${CORE_NAMES}; do
    echo "Creating '$CORES_DIR/$core'..."
    if [[ $core == *"xdb"* ]];
    then
        echo "XDB schema:'$core'"
        cp -r /opt/solr/server/solr/configsets/_default/ $CORES_DIR/$core; \
        cp /opt/xdb/$MANAGED_SCHEMA_XDB_NAME $CORES_DIR/$core/conf/managed-schema; \
    else
        echo "Default schema:'$core'"
        cp -r /opt/solr/server/solr/configsets/_default/ $CORES_DIR/$core; \
        cp /opt/managed-schema $CORES_DIR/$core/conf/managed-schema; \

    fi
    printf "name=$core\nconfig=solrconfig.xml\nupdate.autoCreateFields=false\ndataDir=data" >  "$CORES_DIR/$core/core.properties"

done
IFS=${ORIG_IFS}