# escape=`
ARG BASE_IMAGE

FROM $BASE_IMAGE

ENV ACCEPT_EULA='Y' `
    sa_password='HASH-epsom-sunset-cost7!' `
    DB_PREFIX='sc' `
    INSTALL_PATH='c:/install/' `
    DATA_PATH='c:/data/' `
    SQL_HOSTNAME='sql'

COPY . ${INSTALL_PATH}

RUN New-Item -Path $env:DATA_PATH -ItemType Directory | Out-Null; `
    & (Join-Path $env:INSTALL_PATH "\\Extract-Databases.ps1") -Path $env:INSTALL_PATH; `
    & (Join-Path $env:INSTALL_PATH "\\Install-Databases.ps1") -InstallPath $env:INSTALL_PATH -DataPath $env:DATA_PATH -DatabasePrefix $env:DB_PREFIX; `
    & (Join-Path $env:INSTALL_PATH "\\Install-Shards.ps1") -InstallPath $env:INSTALL_PATH -DatabasePrefix $env:DB_PREFIX; `
    Move-Item -Path (Join-Path $env:INSTALL_PATH "\\Boot.ps1") -Destination 'C:\\Boot.ps1' -Force; `
    Get-ChildItem -Path $env:INSTALL_PATH -Exclude '*.mdf', '*.ldf' -Recurse -Force | Remove-Item -Force;

CMD C:/Boot.ps1 -InstallPath $env:INSTALL_PATH -DataPath $env:DATA_PATH -SqlHostname $env:SQL_HOSTNAME -DatabasePrefix $env:DB_PREFIX;
