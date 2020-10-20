# escape=`
ARG BASE_IMAGE
ARG ASSETS_IMAGE

FROM $ASSETS_IMAGE as assets
FROM $BASE_IMAGE as build

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ARG ASSETS_USE_WDP_SH_FEATUREINTEGRATION
ARG ASSETS_USE_WDP_SH_FEATUREINTEGRATION_INSIGHTS

ARG SC_ROLE_CONFIG_DIRECTORY

COPY --from=assets ["${ASSETS_USE_WDP_SH_FEATUREINTEGRATION}", "C:\\temp\\packages\\"]
COPY --from=assets ["${ASSETS_USE_WDP_SH_FEATUREINTEGRATION_INSIGHTS}", "C:\\temp\\packages\\"]

# expand selected wdp and copy to install into the webroot
RUN Get-ChildItem 'C:\\temp\\packages\\*.zip' | Expand-Archive -DestinationPath 'C:\\temp' -Force ; `
    Copy-Item -Path 'C:\\temp\\Content\\Website\\*' -Destination 'C:\\inetpub\\wwwroot' -Recurse -Force;

# configure wwwroot
RUN Remove-Item -Path 'C:\\inetpub\\wwwroot\\App_Config\\Include\\Sitecore.Owin.Authentication.IdentityServer.Disabler.config' -Force; 

# copy tools and configs
COPY --from=assets ["C:\\install\\tools\\", "C:\\inetpub\\wwwroot\\temp\\install\\tools\\"]
COPY ${SC_ROLE_CONFIG_DIRECTORY} C:\\inetpub\\wwwroot\\
COPY .\config\*.config C:\\inetpub\\wwwroot\\App_Config\\Include\\

# find transform files and do transformation
RUN $xdts = [System.Collections.ArrayList]@(); `
    $xdts.AddRange(@(Get-ChildItem -Path 'C:\\inetpub\\wwwroot\\*.config.xdt')); `
    $xdts.AddRange(@(Get-ChildItem -Path 'C:\\inetpub\\wwwroot\\App_Config\\*.config.xdt' -Recurse)); `
    $xdts | ForEach-Object { & 'C:\\inetpub\\wwwroot\\temp\\install\\tools\\scripts\\Invoke-XdtTransform.ps1' -Path $_.FullName.Replace('.xdt', '') -XdtPath $_.FullName -XdtDllPath 'C:\\inetpub\\wwwroot\\temp\\install\\tools\\bin\\Microsoft.Web.XmlTransform.dll'; }; `
    $xdts | ForEach-Object { Remove-Item -Path $_.FullName; };
