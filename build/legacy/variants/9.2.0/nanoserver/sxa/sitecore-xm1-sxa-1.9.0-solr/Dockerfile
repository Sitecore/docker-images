# escape=`
ARG BASE_IMAGE
ARG BUILD_IMAGE

FROM $BASE_IMAGE as base

FROM $BUILD_IMAGE as builder

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

COPY --from=base /clean /clean/

# HOTFIX: this comes from @scottmulligan on SXA 1.9.0 rev. 190605 which is a pre-pre-release
COPY managed-schema /temp/

RUN $env:INDEX_NAME = 'sitecore_sxa_master_index'; `
    Copy-Item -Path 'C:\\clean\\sc_master_index' -Destination (Join-Path 'C:\\install\\' $env:INDEX_NAME) -Recurse -Force; `
    Copy-Item -Path 'C:\\temp\\managed-schema' -Destination ('c:\\install\\{0}\\conf' -f $env:INDEX_NAME) -Force; `
    ('name={0}' -f $env:INDEX_NAME), 'update.autoCreateFields=false' | Out-File -FilePath ('c:\\install\\{0}\\core.properties' -f $env:INDEX_NAME) -Force;

RUN $env:INDEX_NAME = 'sitecore_sxa_web_index'; `
    Copy-Item -Path 'C:\\clean\\sc_web_index' -Destination (Join-Path 'C:\\install\\' $env:INDEX_NAME) -Recurse -Force; `
    Copy-Item -Path 'C:\\temp\\managed-schema' -Destination ('c:\\install\\{0}\\conf' -f $env:INDEX_NAME) -Force; `
    ('name={0}' -f $env:INDEX_NAME), 'update.autoCreateFields=false' | Out-File -FilePath ('c:\\install\\{0}\\core.properties' -f $env:INDEX_NAME) -Force;

FROM $BASE_IMAGE

COPY --from=builder ["/install", "/clean/"]
