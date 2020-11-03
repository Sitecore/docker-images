# escape=`

ARG BASE_BUILD_IMAGE
ARG BASE_IMAGE

FROM ${BASE_IMAGE} as build
SHELL ["pwsh", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ARG ROLES
ARG ASSET_FILE_NAME="*.zip"
COPY tools/ tools/
COPY ["${ASSET_FILE_NAME}", "/wdp/"]

WORKDIR /wdp

RUN New-Item -ItemType Directory -Path cm; `
    Get-ChildItem -File | Where-Object {$_.Name -match '^.*(Content Delivery|CD).*$'} | Foreach-Object { if (!(Test-Path ./cd)) { New-Item -ItemType Directory cd} Move-Item $_ -Destination (Resolve-Path ./cd)} -ErrorAction SilentlyContinue; `
    Move-Item *.zip cm/

WORKDIR /

RUN ./tools/Extract-Resources.ps1 -Roles $env:ROLES -SourceFolder /wdp -DestinationFolder /extract

FROM ${BASE_IMAGE} as production

COPY --from=build /extract /module/