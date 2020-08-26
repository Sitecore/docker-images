# escape=`
ARG BASE_IMAGE
ARG ASSETS_IMAGE
ARG TOOL_IMAGE

FROM $ASSETS_IMAGE as assets
FROM $TOOL_IMAGE as tools
FROM ${BASE_IMAGE} as build

ARG ASSETS_USE_WDP

SHELL ["powershell", "-NoProfile", "-Command", "$ErrorActionPreference = 'Stop';"]

# Copy files
COPY --from=assets ["${ASSETS_USE_WDP}", "/packages/"]

# expand selected wdp into installation directory
RUN Expand-Archive -Path $env:ASSETS_USE_WDP -DestinationPath "/output"; `
    Copy-Item /output/content/website/* /inetpub/wwwroot/ -Recurse;

# put transforms on the container
COPY ./sitecore/ C:/inetpub/wwwroot/sitecore
COPY ./sitecorehost.xml.xdt C:/inetpub/wwwroot/

COPY --from=tools /tools /tools

# # find transform files and do transformation
RUN $xdts = (Get-ChildItem -Path 'C:/inetpub/wwwroot/*.xml.xdt'), (Get-ChildItem -Path 'C:/inetpub/wwwroot/sitecore/Sitecore.Horizon.Authoring.Plugin/Config/*.xml.xdt'), (Get-ChildItem -Path 'C:/inetpub/wwwroot/sitecore/Sitecore.Horizon.ContentHub.Dam.Plugin/Config/*.xml.xdt'); `
    $xdts | ForEach-Object { & 'C:/tools/scripts/Invoke-XdtTransform.ps1' -Path $_.FullName.Replace('.xdt', '') -XdtPath $_.FullName -XdtDllPath 'C:/tools/bin/Microsoft.Web.XmlTransform.dll'; }; `
    $xdts | ForEach-Object { Remove-Item -Path $_.FullName; };

FROM ${BASE_IMAGE} as final

COPY --from=build /inetpub/wwwroot/ /inetpub/wwwroot/

# enable support for WebSocket protocol in IIS
RUN Import-Module ServerManager; `
Install-WindowsFeature -name Web-WebSockets;