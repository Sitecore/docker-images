ARG BASE_IMAGE

FROM $BASE_IMAGE as builder

RUN apt-get -y update \
    && apt-get -y --allow-unauthenticated install unzip \ 
    && wget -progress=bar:force -q -O sqlpackage.zip https://go.microsoft.com/fwlink/?linkid=2087431 \
    && unzip -qq sqlpackage.zip -d /opt/sqlpackage \
    && chmod +x /opt/sqlpackage/sqlpackage

COPY *.zip /opt/wdp/

RUN unzip -qq /opt/wdp/Sitecore*.zip -d /opt/wdp/ \
    && unzip -qq /opt/wdp/Sitecore*_single.scwdp.zip -d /opt/wdp/

ENV ACCEPT_EULA='Y' \ 
    SA_PASSWORD='HASH-epsom-sunset-cost7!' \ 
    MSSQL_PID=Developer \
    DB_PREFIX='sc'

COPY *.bacpac /opt/shards/
COPY *.sh /opt/
RUN chmod +x /opt/install-databases.sh \
    && chmod +x /opt/install-shards.sh \
    && ( /opt/mssql/bin/sqlservr & ) | grep -q "Service Broker manager has started" \
    && ./opt/install-databases.sh /opt/wdp \
    && ./opt/install-shards.sh /opt/shards \
    && pkill sqlservr

FROM $BASE_IMAGE

COPY --from=builder ["/var/opt/mssql/data/sc_*", "/clean/"]
COPY *.sh /opt/

RUN chmod +x /opt/boot.sh && \
    chmod +x /opt/attach-databases.sh && \
    chmod -R 700 /clean && \
    mkdir -p /data && \
    chmod -R 700 /data

ENV ACCEPT_EULA='Y' \ 
    SA_PASSWORD='HASH-epsom-sunset-cost7!' \ 
    MSSQL_PID=Developer \ 
    MSSQL_DATA_DIR='/data' \ 
    MSSQL_LOG_DIR='/data' \
    DB_PREFIX='sc' \
    SQL_HOSTNAME='sql'

ENTRYPOINT ["/opt/boot.sh", "/clean", "/data"]
