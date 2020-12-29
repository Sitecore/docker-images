# escape=`
ARG BASE_IMAGE
ARG ASSETS_IMAGE
ARG TOOL_IMAGE

FROM $ASSETS_IMAGE as assets
FROM ${TOOL_IMAGE} as tools

FROM ${BASE_IMAGE} as final
COPY --from=tools /tools/ /tools/
COPY --from=assets /module/cm/content /inetpub/wwwroot
ADD https://github.com/microsoft/windows-container-tools/releases/download/v1.1/LogMonitor.exe .\LogMonitor\LogMonitor.exe
ADD https://raw.githubusercontent.com/microsoft/iis-docker/master/windowsservercore-insider/LogMonitorConfig.json .\LogMonitor\LogMonitorConfig.json
ADD https://dotnetbinaries.blob.core.windows.net/servicemonitor/2.0.1.10/ServiceMonitor.exe .\ServiceMonitor.exe
ENTRYPOINT [ "powershell.exe", "C:\\tools\\entrypoints\\iis\\development.ps1" ]
