# escape=`
ARG BASE_IMAGE
ARG ASSETS_IMAGE

FROM $ASSETS_IMAGE as assets
FROM $BASE_IMAGE

ARG ASSETS_USE_WDP
ARG ASSETS_USE_WDP_XCONNECT

ENV ACCEPT_EULA='Y' `
    sa_password='HASH-epsom-sunset-cost7!' `
    INSTALL_PATH='C:\\install\\' `
    DATA_PATH='C:\\data\\' `
    SQL_HOSTNAME='sql'

COPY --from=assets ["${ASSETS_USE_WDP}", "${INSTALL_PATH}"]
COPY --from=assets ["${ASSETS_USE_WDP_XCONNECT}", "${INSTALL_PATH}"]
COPY . ${INSTALL_PATH}

RUN New-Item -Path $env:DATA_PATH -ItemType Directory | Out-Null; `
    & (Join-Path $env:INSTALL_PATH "\\Extract-Databases.ps1") -Path $env:INSTALL_PATH; `
    & (Join-Path $env:INSTALL_PATH "\\Install-Databases.ps1") -InstallPath $env:INSTALL_PATH -DataPath $env:DATA_PATH; `
    & (Join-Path $env:INSTALL_PATH "\\Install-Shards.ps1") -InstallPath $env:INSTALL_PATH; `
    Copy-Item -Path (Join-Path $env:INSTALL_PATH "\\Boot.ps1") -Destination 'C:\\'; `
    Get-ChildItem -Path $env:INSTALL_PATH -Exclude '*.mdf', '*.ldf' -Recurse -Force | Remove-Item -Force;

CMD C:/Boot.ps1 -InstallPath $env:INSTALL_PATH -DataPath $env:DATA_PATH -SqlHostname $env:SQL_HOSTNAME;