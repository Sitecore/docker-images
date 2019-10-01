# escape=`
ARG BASE_IMAGE
ARG ASSETS_IMAGE

FROM $ASSETS_IMAGE as assets
FROM $BASE_IMAGE as build

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ARG ASSETS_USE_WDP
ARG SC_ROLE_CONFIG_DIRECTORY

COPY --from=assets ["${ASSETS_USE_WDP}", "C:\\temp\\packages\\"]

# expand selected wdp into installation directory
RUN Expand-Archive -Path 'C:\\temp\\packages\\*.zip' -DestinationPath 'C:\\temp'; `
    Copy-Item -Path 'C:\\temp\\Content\\Website\\*' -Destination 'C:\\inetpub\\wwwroot' -Recurse -Force;

# configure wwwroot
RUN Copy-Item -Path 'C:\\inetpub\\wwwroot\\App_Config\\Include\\Examples\\Sitecore.Owin.Authentication.IdentityServer.Disabler.config.example' -Destination 'C:\\inetpub\\wwwroot\\App_Config\\Include\\Sitecore.Owin.Authentication.IdentityServer.Disabler.config'; `
    Copy-Item -Path 'C:\\inetpub\\wwwroot\\App_Config\\Include\\Examples\\Sitecore.LoadBalancing.config.example' -Destination 'C:\\inetpub\\wwwroot\\App_Config\\Include\\Sitecore.LoadBalancing.config'; `
    New-Item -Path 'C:\\inetpub\\wwwroot\\upload' -ItemType Directory | Out-Null; `
    New-Item -Path 'C:\\inetpub\\wwwroot\\sitecore\\shell\\override' -ItemType Directory | Out-Null; `
    Remove-Item -Path 'C:\\inetpub\\wwwroot\\App_Data\\logs' -Force -Recurse;

# copy tools and transforms
COPY --from=assets ["C:\\install\\tools\\", "C:\\inetpub\\wwwroot\\temp\\install\\tools\\"]
COPY ${SC_ROLE_CONFIG_DIRECTORY} C:\\inetpub\\wwwroot\\

# find transform files and do transformation
RUN $xdts = (Get-ChildItem -Path 'C:\\inetpub\\wwwroot\\*.config.xdt'), (Get-ChildItem -Path 'C:\\inetpub\\wwwroot\\App_Config\\*.config.xdt' -Recurse); `
    $xdts | ForEach-Object { & 'C:\\inetpub\\wwwroot\\temp\\install\\tools\\scripts\\Invoke-XdtTransform.ps1' -Path $_.FullName.Replace('.xdt', '') -XdtPath $_.FullName -XdtDllPath 'C:\\inetpub\\wwwroot\\temp\\install\\tools\\bin\\Microsoft.Web.XmlTransform.dll'; }; `
    $xdts | ForEach-Object { Remove-Item -Path $_.FullName; };

# add config patches
COPY .\config\*.config C:\\inetpub\\wwwroot\\App_Config\\Include\\

# add installers
COPY --from=assets ["C:\\install\\setup\\", "C:\\inetpub\\wwwroot\\temp\\install\\setup\\"]

FROM $BASE_IMAGE

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ARG SC_ROLE_DEFINE

COPY --from=build ["C:\\inetpub\\wwwroot\\", "C:\\inetpub\\wwwroot\\"]

RUN $env:INSTALL_TEMP = 'C:\\inetpub\\wwwroot\\temp\\install'; `
    $env:IIS_SITE_PATH = 'IIS:\Sites\Default Web Site'; `
    $env:IIS_APPPOOL_PATH = 'IIS:\AppPools\DefaultAppPool'; `
    Start-Process msiexec.exe -ArgumentList '/i', (Join-Path $env:INSTALL_TEMP '\\setup\\urlrewrite.msi'), '/quiet', '/norestart' -NoNewWindow -Wait; `
    Start-Process (Join-Path $env:INSTALL_TEMP '\\setup\\vc_redist.exe') -ArgumentList '/install', '/passive', '/norestart' -NoNewWindow -Wait; `
    Copy-Item -Path (Join-Path $env:INSTALL_TEMP '\\tools') -Destination 'C:\\tools' -Force; `
    setx /M PATH $($env:PATH + ';C:\tools\scripts;C:\tools\bin') | Out-Null; `
    Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters' -Name 'ServerPriorityTimeLimit' -Value 0 -Type DWord; `
    Add-LocalGroupMember -Group 'Performance Monitor Users' -Member 'IIS AppPool\DefaultAppPool'; `
    Import-Module WebAdministration; `
    Set-ItemProperty -Path $env:IIS_APPPOOL_PATH -Name 'processModel.identityType' -Value 'LocalSystem'; `
    Set-WebConfigurationProperty -PSPath $env:IIS_SITE_PATH -Filter '/appSettings/add[@key=\"role:define\"]' -Name 'value' -Value $env:SC_ROLE_DEFINE; `
    Remove-Item -Path $env:INSTALL_TEMP -Force -Recurse;
