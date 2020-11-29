# escape=`

# The purpose of this DockerFile is to install NodeJS for JSS Integrated Mode. This can be used in CM or CD

ARG BASE_IMAGE

FROM $BASE_IMAGE as base

ARG NodeJsVersion

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

FROM base as installnodejs

RUN New-Item -Path 'C:\\inetpub\\wwwroot\\temp\\install\\setup' -ItemType 'Directory' -Force | Out-Null; `
    & curl.exe -sS -L -o C:\\inetpub\\wwwroot\\temp\\install\\setup\\node.msi https://nodejs.org/dist/v${NodeJsVersion}/node-${NodeJsVersion}-x64.msi;

RUN $env:INSTALL_TEMP = 'C:\\inetpub\\wwwroot\\temp\\install'; `
# setup Node.JS for Experience Editor on CM and for Integrated Mode on CD
Start-Process msiexec.exe -ArgumentList '/i', (Join-Path $env:INSTALL_TEMP '\\setup\\node.msi'), '/quiet', '/norestart' -NoNewWindow -Wait;`
Remove-Item -Path $env:INSTALL_TEMP -Force -Recurse;