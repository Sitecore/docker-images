# escape=`
ARG BASE_IMAGE
ARG ASSETS_IMAGE
#ARG TOOL_IMAGE

FROM ${ASSETS_IMAGE} as assets
FROM ${BASE_IMAGE} as build
#FROM ${TOOL_IMAGE} as tools

ARG ASSETS_USE_WDP

SHELL ["powershell", "-NoProfile", "-Command", "$ErrorActionPreference = 'Stop';"]
ENV PACKAGE="/packages/HorizonHost.1.36.0.scwdp.zip"
# Copy files
COPY --from=assets ${PACKAGE} /packages/

# expand selected wdp into installation directory
RUN Expand-Archive -Path $env:PACKAGE -DestinationPath "/output/"; `
    Copy-Item /output/content/website/* /inetpub/wwwroot/ -Recurse;

FROM ${BASE_IMAGE} as final
COPY --from=build /inetpub/wwwroot/ /inetpub/wwwroot/

# enable support for WebSocket protocol in IIS
RUN Import-Module ServerManager; `
    Install-WindowsFeature -name Web-WebSockets;