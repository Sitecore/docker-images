# escape=`
ARG BASE_IMAGE

FROM $BASE_IMAGE as build

ARG SC_USE_WDP

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

COPY license.xml /install/
COPY *.zip /install/

RUN Expand-Archive -Path 'C:\\install\\*.zip' -DestinationPath 'C:\\install'; `
    Expand-Archive -Path (Join-Path 'C:\\install\\' $env:SC_USE_WDP) -DestinationPath 'C:\\install'; `
    Copy-Item -Path 'C:\\install\\license.xml' -Destination 'C:\\install\\Content\\Website\\App_Data'; `
    Copy-Item -Path 'C:\\install\\Content\\Website\\App_Config\\Include\\Examples\\Sitecore.Owin.Authentication.IdentityServer.Disabler.config.example' -Destination 'C:\\install\\Content\\Website\\App_Config\\Include\\Sitecore.Owin.Authentication.IdentityServer.Disabler.config'; `
    Copy-Item -Path 'C:\\install\\Content\\Website\\App_Config\\Include\\Examples\\Sitecore.LoadBalancing.config.example' -Destination 'C:\\install\\Content\\Website\\App_Config\\Include\\Sitecore.LoadBalancing.config'; `
    New-Item -Path 'C:\\install\\Content\\Website\\upload' -ItemType Directory | Out-Null; `
    Remove-Item -Path 'C:\\install\\Content\\Website\\App_Data\\logs' -Force -Recurse;

COPY *.xdt /install/

RUN & Invoke-XdtTransform.ps1 -Path 'C:\\install\\Content\\Website\\App_Config\\ConnectionStrings.config' -XdtPath 'C:\\install\\ConnectionStrings.config.xdt'; `
    & Invoke-XdtTransform.ps1 -Path 'C:\\install\\Content\\Website\\Web.config' -XdtPath 'C:\\install\\Web.config.xdt';

COPY *.config C:\\install\\Content\\Website\\App_Config\\Include\\

FROM $BASE_IMAGE

ARG SC_ROLE_DEFINE

COPY --from=build ["/install/Content/Website/", "/inetpub/wwwroot/"]

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

# TODO: Flatten: all wdps, downloads, tools could come from BUILD_IMAGE == then each final image can be directly from aspnet:4.8 and very explicit

RUN $env:IIS_SITE_PATH = 'IIS:\Sites\Default Web Site'; `
    $env:IIS_APPPOOL_PATH = 'IIS:\AppPools\DefaultAppPool'; `
    Import-Module WebAdministration; `
    Set-ItemProperty -Path $env:IIS_APPPOOL_PATH -Name 'processModel.identityType' -Value 'LocalSystem'; `
    Set-WebConfigurationProperty -PSPath $env:IIS_SITE_PATH -Filter '/appSettings/add[@key=\"role:define\"]' -Name 'value' -Value $env:SC_ROLE_DEFINE;
