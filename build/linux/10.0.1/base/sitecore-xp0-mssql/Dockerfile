ARG BASE_IMAGE

FROM $BASE_IMAGE as builder

USER root

RUN apt-get -y update \
    && apt-get -y --allow-unauthenticated install unzip \
    && wget -progress=bar:force -q -O sqlpackage.zip https://go.microsoft.com/fwlink/?linkid=2113331 \
    && unzip -qq sqlpackage.zip -d /opt/sqlpackage \
    && chmod +x /opt/sqlpackage/sqlpackage

# install pwsh
RUN wget -q https://packages.microsoft.com/config/ubuntu/16.04/packages-microsoft-prod.deb \
    && dpkg -i packages-microsoft-prod.deb \
    && apt-get update \
    && apt-get install -y powershell \
    && pwsh -command "Set-PackageSource -Name PSGallery -Trusted ; Install-Module -Name SqlServer"

COPY *.zip /opt/wdp/
COPY InstallShards.ps1 /opt
COPY install-databases.sh /opt
COPY replace_log.sh /opt

RUN unzip -qq /opt/wdp/Sitecore*.zip -d /opt/wdp/ \
    && ls /opt/wdp \
    && unzip -qq /opt/wdp/Sitecore*_single.scwdp.zip -d /opt/wdp/single \
    && unzip -qq /opt/wdp/*xp0xconnect.scwdp.zip -d /opt/wdp/xp0xconnect/

ENV ACCEPT_EULA='Y' \
    SA_PASSWORD='envy-$taleness-Jelly-3twin-aided-Sterile-Bawd' \
    MSSQL_PID=Developer

RUN ( /opt/mssql/bin/sqlservr & ) | grep -q "Service Broker manager has started" \
    && chmod +x /opt/replace_log.sh \
    && chmod +x /opt/install-databases.sh \
    && ./opt/install-databases.sh /opt/wdp/single \
    && pwsh /opt/InstallShards.ps1 -SqlServer . -SqlAdminUser sa -SqlAdminPassword $SA_PASSWORD -SqlElasticPoolName xp -ResourcesDirectory /opt/wdp/xp0xconnect/ \
    && pkill sqlservr \
    && /opt/replace_log.sh

FROM $BASE_IMAGE

USER root

COPY --from=builder ["/var/opt/mssql/data/Sitecore*", "/clean/"]
COPY boot.sh /opt/
COPY attach-databases.sh /opt/
COPY install-databases.sh /opt/

RUN chmod +x /opt/boot.sh && \
    chmod +x /opt/attach-databases.sh && \
    chmod +x /opt/install-databases.sh && \
    chmod -R 777 /clean && \
    mkdir -p /var/opt/mssql/data && \
    chmod -R 777 /var/opt/mssql/data

ENV ACCEPT_EULA='Y' \
    SA_PASSWORD='envy-$taleness-Jelly-3twin-aided-Sterile-Bawd' \
    MSSQL_PID=Developer \
    MSSQL_DATA_DIR=/var/opt/mssql/data \
    MSSQL_LOG_DIR=/var/opt/mssql/data

USER mssql

ENTRYPOINT ["/opt/boot.sh", "/clean", "/var/opt/mssql/data"]