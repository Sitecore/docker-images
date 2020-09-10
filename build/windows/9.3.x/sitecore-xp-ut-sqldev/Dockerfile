# escape=`
ARG BASE_IMAGE
ARG ASSETS_IMAGE

FROM $ASSETS_IMAGE as assets
FROM $BASE_IMAGE as build

ARG ASSETS_USE_DACPAC_ZIP

ENV INSTALL_PATH='C:\\install\\' `
    DATA_PATH='C:\\data\\' `
    TEMP_PATH='c:\\temp'

COPY --from=assets ["${ASSETS_USE_DACPAC_ZIP}", "${INSTALL_PATH}"]

COPY . ${INSTALL_PATH}

RUN & (Join-Path $env:INSTALL_PATH "\\Extract-Databases.ps1") -Path $env:INSTALL_PATH; `
    & (Join-Path $env:INSTALL_PATH "\\Install-Databases.ps1") -InstallPath $env:INSTALL_PATH -DataPath $env:DATA_PATH; `
    Get-ChildItem -Path $env:INSTALL_PATH -Exclude "*.mdf", "*.ldf" | Remove-Item -Force;