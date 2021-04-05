# escape=`
ARG BASE_IMAGE
ARG ASSETS_IMAGE

FROM $ASSETS_IMAGE as assets
FROM $BASE_IMAGE as build

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ARG ASSETS_USE_WDP

COPY --from=assets ["${ASSETS_USE_WDP}", "C:\\temp\\packages\\"]

# expand selected wdp into installation directory
RUN Expand-Archive -Path 'C:\\temp\\packages\\*.zip' -DestinationPath 'C:\\temp'; `
    Copy-Item -Path 'C:\\temp\\Content\\Website\\*' -Destination 'C:\\inetpub\\wwwroot' -Recurse -Force;

# copy tools and transforms
COPY --from=assets ["C:\\install\\tools\\", "C:\\install\\tools\\"]

# run connectionstring transform
RUN & 'C:\\install\\tools\\scripts\\Invoke-XdtTransform.ps1' `
    -Path 'C:\\inetpub\\wwwroot\\App_Config\\ConnectionStrings.config' `
    -XdtPath 'C:\\inetpub\\wwwroot\\App_Data\\Transforms\\AzureBlobStorageProvider\\Xdts\\App_Config\\ConnectionStrings.config.xdt' `
    -XdtDllPath 'C:\\install\\tools\\bin\\Microsoft.Web.XmlTransform.dll';

FROM $BASE_IMAGE

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

COPY --from=build ["C:\\inetpub\\wwwroot\\", "C:\\inetpub\\wwwroot\\"]

