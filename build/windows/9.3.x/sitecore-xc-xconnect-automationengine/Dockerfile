# escape=`
ARG BASE_IMAGE
ARG ASSETS_IMAGE

FROM $ASSETS_IMAGE as assets
FROM $BASE_IMAGE as build

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ARG ASSETS_USE_WDP
ARG ASSETS_USE_WDP_AUTOMATION
ARG SC_ROLE_NAME

COPY --from=assets ["${ASSETS_USE_WDP}", "C:\\temp\\packages\\"]
COPY --from=assets ["${ASSETS_USE_WDP_AUTOMATION}", "C:\\temp\\packages\\"]

# expand selected wdp into installation directory
RUN Get-ChildItem 'C:\\temp\\packages\\*.zip' | Expand-Archive -DestinationPath 'C:\\temp'; `
    Copy-Item -Path ('C:\\temp\\App_Data\\jobs\\continuous\\{0}\\*' -f $env:SC_ROLE_NAME) -Destination 'C:\\worker' -Recurse -Force; `
    Copy-Item -Path 'C:\\temp\\Content\\Website\\XConnectFiles\\Configs\\sc.XConnect.Segmentation.Commerce.Predicates.xml' -Destination 'C:\\worker\\App_Data\\Config\\sitecore\\Segmentation' -Recurse -Force;

FROM $BASE_IMAGE

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

COPY --from=build ["C:\\worker\\", "C:\\worker\\"]
