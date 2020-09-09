ARG BASE_IMAGE

FROM $BASE_IMAGE as builder

USER root

RUN apt-get -y update \
    && apt-get -y --allow-unauthenticated install unzip \
    && wget -progress=bar:force -q -O sqlpackage.zip https://go.microsoft.com/fwlink/?linkid=2113331 \
    && unzip -qq sqlpackage.zip -d /opt/sqlpackage \
    && chmod +x /opt/sqlpackage/sqlpackage

COPY *.zip /opt/wdp/

RUN unzip -qq /opt/wdp/Sitecore*.zip -d /opt/wdp/ \
    && unzip -qq /opt/wdp/Sitecore*_cm.scwdp.zip -d /opt/wdp/

COPY install-databases.sh /opt/

ENV ACCEPT_EULA='Y' \
    SA_PASSWORD='envy-$taleness-Jelly-3twin-aided-Sterile-Bawd' \
    MSSQL_PID=Developer

RUN ( /opt/mssql/bin/sqlservr & ) | grep -q "Service Broker manager has started" \
    && chmod +x /opt/install-databases.sh && ./opt/install-databases.sh /opt/wdp \
    && pkill sqlservr

FROM $BASE_IMAGE

COPY --from=builder ["/var/opt/mssql/data/Sitecore*", "/clean/"]
COPY boot.sh /opt/
COPY attach-databases.sh /opt/

USER root

RUN chmod +x /opt/boot.sh && \
    chmod +x /opt/attach-databases.sh && \
    chmod -R 777 /clean && \
    mkdir -p /var/opt/mssql/data && chmod -R 777 /var/opt/mssql/data

ENV ACCEPT_EULA='Y' \
    SA_PASSWORD='envy-$taleness-Jelly-3twin-aided-Sterile-Bawd' \
    MSSQL_PID=Developer \
    MSSQL_DATA_DIR=/var/opt/mssql/data \
    MSSQL_LOG_DIR=/var/opt/mssql/data

USER mssql

ENTRYPOINT ["/opt/boot.sh", "/clean", "/var/opt/mssql/data"]
