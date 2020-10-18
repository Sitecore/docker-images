ARG BASE_IMAGE

FROM $BASE_IMAGE as builder

ARG CORE_NAMES
ARG MANAGED_SCHEMA_DEFAULT_NAME
ARG MANAGED_SCHEMA_XDB_NAME

USER root

RUN mkdir /opt/xdb

COPY ${MANAGED_SCHEMA_DEFAULT_NAME} /opt/managed-schema
COPY ${MANAGED_SCHEMA_XDB_NAME} /opt/xdb

COPY initialize-solr.sh /opt/initialize-solr.sh
RUN chmod +x /opt/initialize-solr.sh;/opt/initialize-solr.sh

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
