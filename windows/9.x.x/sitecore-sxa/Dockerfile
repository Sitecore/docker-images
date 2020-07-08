# escape=`
ARG BASE_IMAGE
ARG ASSETS_IMAGE

FROM $ASSETS_IMAGE as assets
FROM $BASE_IMAGE as build

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ARG ASSETS_USE_WDP

COPY --from=assets ["${ASSETS_USE_WDP}", "C:\\temp\\packages\\"]

# expand selected wdp into installation directory
RUN New-Item -Path 'C:\\temp\\wwwroot' -ItemType Directory | Out-Null; `
    Expand-Archive -Path 'C:\\temp\\packages\\*.zip' -DestinationPath 'C:\\temp'; `
    Copy-Item -Path 'C:\\temp\\Content\\Website\\*' -Destination 'C:\\temp\\wwwroot' -Recurse -Force;

# copy tools and transforms
COPY --from=assets ["C:\\install\\tools\\", "C:\\install\\tools\\"]

# find transform files and do transformation
RUN Copy-Item -Path 'C:\\inetpub\\wwwroot\\web.config' -Destination 'C:\\temp\\wwwroot' -Force; `
    (Get-ChildItem -Path 'C:\\temp\\wwwroot\\*.xdt' -Recurse ) | ForEach-Object { & 'C:\\install\\tools\\scripts\\Invoke-XdtTransform.ps1' -Path 'C:\\temp\\wwwroot\\web.config' -XdtPath $_.FullName -XdtDllPath 'C:\\install\\tools\\bin\\Microsoft.Web.XmlTransform.dll'; };

FROM $BASE_IMAGE

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

COPY --from=build ["C:\\temp\\wwwroot\\", "C:\\inetpub\\wwwroot\\"]