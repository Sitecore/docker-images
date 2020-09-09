# escape=`
ARG BASE_IMAGE
ARG ASSETS_IMAGE

FROM $ASSETS_IMAGE as assets
FROM $BASE_IMAGE

ARG ASSETS_USE_WDP

ENV INSTALL_PATH='C:\\install\\' `
    INSTALL_MODULE_PATH='C:\\install-module\\' `
    DATA_PATH='C:\\data\\' `
    TEMP_PATH='c:\\temp'

COPY --from=assets ["${ASSETS_USE_WDP}", "${INSTALL_MODULE_PATH}"]
COPY . ${INSTALL_MODULE_PATH}

RUN & (Join-Path $env:INSTALL_MODULE_PATH "\\Extract-Databases.ps1") -Path $env:INSTALL_MODULE_PATH; `
    & (Join-Path $env:INSTALL_MODULE_PATH "\\Install-Databases.ps1") -InstallPath $env:INSTALL_PATH -DataPath $env:DATA_PATH -ModulePath $env:INSTALL_MODULE_PATH -DatabasePrefix Sitecore; `
    Get-ChildItem -Path $env:INSTALL_PATH -Exclude "*.mdf", "*.ldf" | Remove-Item -Force; `
    Get-ChildItem -Path $env:INSTALL_MODULE_PATH | Remove-Item -Force;