ARG BASE_IMAGE

FROM $BASE_IMAGE as builder

ARG CORE_NAMES

COPY managed-schema.* /opt/

USER root

RUN set -e; \
    CORES_DIR='/opt/solr/server/solr'; \
    ORIG_IFS=${IFS}; \
    IFS=', '; \
    for core in ${CORE_NAMES}; do \
        echo "Creating '$CORES_DIR/$core'..."; \
        /bin/cp -rf /opt/solr/server/solr/configsets/_default/ $CORES_DIR/$core; \
        /bin/cp -f "/opt/managed-schema.default" $CORES_DIR/$core/conf/managed-schema; \
        touch "$CORES_DIR/$core/core.properties"; \
    done; \
    IFS=${ORIG_IFS}; \
    /bin/cp -f --verbose "/opt/managed-schema.xdb" $CORES_DIR/*_xdb/conf/managed-schema; \ 
    /bin/cp -f --verbose "/opt/managed-schema.xdb" $CORES_DIR/*_xdb_rebuild/conf/managed-schema;

FROM $BASE_IMAGE

COPY --from=builder ["/opt/solr/server/solr", "/clean"]
COPY boot.sh /opt/boot.sh

USER root

RUN chmod +x /opt/boot.sh && \
    chown -R $SOLR_USER:$SOLR_USER /clean && \
    chmod -R 700 /clean && \
    mkdir -p /data && \
    chown -R $SOLR_USER:$SOLR_USER /data && \
    chmod -R 700 /data

USER $SOLR_USER

ENV SOLR_HOME=/data

ENTRYPOINT ["/opt/boot.sh", "/clean", "/data"]
