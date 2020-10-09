# escape=`
ARG BASE_IMAGE
ARG ASSETS_IMAGE

FROM $ASSETS_IMAGE as assets
FROM ${BASE_IMAGE} as build

ARG ASSETS_USE_WDP

SHELL ["powershell", "-NoProfile", "-Command", "$ErrorActionPreference = 'Stop';"]

# Copy Publishing Service files
COPY --from=assets ["${ASSETS_USE_WDP}", "/packages/"]

# expand selected wdp into installation directory
RUN Expand-Archive -Path $env:ASSETS_USE_WDP -DestinationPath "/extract"

FROM ${BASE_IMAGE} as final

COPY --from=build /extract/Content/Website /inetpub/wwwroot


