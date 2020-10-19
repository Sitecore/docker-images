# escape=`

ARG BASE_BUILD_IMAGE
ARG TOOL_IMAGE
ARG BASE_IMAGE
ARG ASSETS_IMAGE

FROM ${TOOL_IMAGE} as tools


FROM ${BASE_BUILD_IMAGE} as build
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ARG MODULE_NAME
ARG ROLES

COPY tools/ tools/
COPY *.zip /wdp/

WORKDIR /wdp

RUN New-Item -ItemType Directory -Path cm; `
    Get-ChildItem -File | Where-Object {$_.Name -match '^.*(Content Delivery|CD).*$'} | Foreach-Object { if (!(Test-Path ./cd)) { New-Item -ItemType Directory cd} Move-Item $_ -Destination (Resolve-Path ./cd)}; `
    Move-Item *.zip cm/

WORKDIR /

RUN ./tools/Extract-Resources.ps1 -Roles $env:ROLES -SourceFolder /wdp -DestinationFolder /extract

RUN ./tools/Prepare-cd-assets.ps1 -SourceFolder /extract/cm/content -DestinationFolder /extract/cd/content
FROM ${BASE_IMAGE} as production

COPY --from=build /extract /module/

