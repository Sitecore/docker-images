# escape=`

ARG BASE_IMAGE
ARG MODULE_ASSETS

FROM ${MODULE_ASSETS} as module_assets

FROM $BASE_IMAGE as base

ARG ROLE

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

COPY --from=module_assets c:\module\${ROLE}\content c:\inetpub\wwwroot

FROM base as content

COPY --from=module_assets C:\module\tools C:\module\tools

RUN C:\module\tools\Initialize-Content.ps1 -TargetPath C:\inetpub\wwwroot; `
    Remove-Item -Path C:\module -Recurse -Force;

FROM content as installnodejs

COPY --from=content C:\inetpub\wwwroot C:\inetpub\wwwroot

RUN New-Item -Path 'C:\\inetpub\\wwwroot\\temp\\install\\setup' -ItemType 'Directory' -Force | Out-Null; `
    & curl.exe -sS -L -o C:\\inetpub\\wwwroot\\temp\\install\\setup\\node.msi https://nodejs.org/dist/v15.0.1/node-v15.0.1-x64.msi;

RUN $env:INSTALL_TEMP = 'C:\\inetpub\\wwwroot\\temp\\install'; `
# setup Node.JS for Experience Editor on CM and for Integrated Mode on CD
Start-Process msiexec.exe -ArgumentList '/i', (Join-Path $env:INSTALL_TEMP '\\setup\\node.msi'), '/quiet', '/norestart' -NoNewWindow -Wait;`
Remove-Item -Path $env:INSTALL_TEMP -Force -Recurse;