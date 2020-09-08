# escape=`
ARG BASE_IMAGE
ARG ASSETS_IMAGE

FROM $ASSETS_IMAGE as assets
FROM $BASE_IMAGE as build

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ARG ASSETS_USE_WDP_ADVENTUREWORKS_IMAGES
ARG ASSETS_USE_WDP_HABITAT_IMAGES
ARG ASSETS_USE_WDP_SXA_STOREFRONT
ARG ASSETS_USE_WDP_SXA_STOREFRONT_REFERENCE
ARG ASSETS_USE_WDP_SXA_STOREFRONT_THEME
ARG ASSETS_USE_WDP_SXA_STOREFRONT_CATALOG

COPY --from=assets ["${ASSETS_USE_WDP_ADVENTUREWORKS_IMAGES}", "C:\\temp\\packages\\"]
COPY --from=assets ["${ASSETS_USE_WDP_HABITAT_IMAGES}", "C:\\temp\\packages\\"]
COPY --from=assets ["${ASSETS_USE_WDP_SXA_STOREFRONT}", "C:\\temp\\packages\\"]
COPY --from=assets ["${ASSETS_USE_WDP_SXA_STOREFRONT_REFERENCE}", "C:\\temp\\packages\\"]
COPY --from=assets ["${ASSETS_USE_WDP_SXA_STOREFRONT_THEME}", "C:\\temp\\packages\\"]
COPY --from=assets ["${ASSETS_USE_WDP_SXA_STOREFRONT_CATALOG}", "C:\\temp\\packages\\"]

# expand selected wdp into installation directory
RUN Get-ChildItem 'C:\\temp\\packages\\*.zip' | Expand-Archive -DestinationPath 'C:\\temp' -Force ; `
    Copy-Item -Path 'C:\\temp\\Content\\Website\\*' -Destination 'C:\\inetpub\\wwwroot' -Recurse -Force;

# copy tools and transforms
COPY --from=assets ["C:\\install\\tools\\", "C:\\install\\tools\\"]

# find transform files and do transformation
RUN (Get-ChildItem -Path 'C:\\inetpub\\wwwroot\\*.xdt' -Recurse ) | ForEach-Object { & 'C:\\install\\tools\\scripts\\Invoke-XdtTransform.ps1' -Path 'C:\\inetpub\\wwwroot\\web.config' -XdtPath $_.FullName -XdtDllPath 'C:\\install\\tools\\bin\\Microsoft.Web.XmlTransform.dll'; }; 

# transform sxa storefront web.config values
RUN & "C:\\install\\tools\\scripts\\Invoke-XdtTransform.ps1" -Path 'C:\\inetpub\\wwwroot\\web.config' -XdtPath 'C:\\inetpub\\wwwroot\\MergeFiles\\Merge.SXA.Storefront.config' -XdtDllPath 'C:\\install\\tools\\bin\\Microsoft.Web.XmlTransform.dll'

FROM $BASE_IMAGE

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

COPY --from=build ["C:\\inetpub\\wwwroot\\", "C:\\inetpub\\wwwroot\\"]