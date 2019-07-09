# escape=`
ARG BASE_IMAGE

FROM $BASE_IMAGE as builder

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

COPY *.zip /install/

RUN $env:WDP_PACKAGE = 'HabitatHome-*.scwdp.zip'; `
    $env:INSTALL_TEMP = 'C:\\install'; `
    Expand-Archive -Path (Join-Path $env:INSTALL_TEMP $env:WDP_PACKAGE) -DestinationPath $env:INSTALL_TEMP; `
    New-Item -Path (Join-Path $env:INSTALL_TEMP "\\Models\\") -ItemType Directory | Out-Null; `
    Copy-Item -Path (Join-Path $env:INSTALL_TEMP "\\Content\\Website\\App_Data\\xConnectModels\\*.*") -Destination (Join-Path $env:INSTALL_TEMP "\\Models") -Force;

FROM $BASE_IMAGE as final

COPY --from=builder ["/install/Models/", "/IndexWorker/App_Data/Models/"]
