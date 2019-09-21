# escape=`
ARG BASE_IMAGE
ARG ASSETS_IMAGE

FROM $ASSETS_IMAGE as assets
FROM $BASE_IMAGE as build

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ARG ASSETS_USE_WDP
ARG SC_ROLE_CONFIG_DIRECTORY

COPY --from=assets ["${ASSETS_USE_WDP}", "C:\\install\\packages\\"]

RUN Expand-Archive -Path 'C:\\install\\packages\\*.zip' -DestinationPath 'C:\\install'; `
    New-Item -Path 'C:\\install\\inetpub\\wwwroot' -ItemType 'Directory' | Out-Null; `
    Move-Item -Path 'C:\\install\\Content\\Website\\*' -Destination 'C:\\install\\inetpub\\wwwroot' -Force; `
    Copy-Item -Path 'C:\\install\\inetpub\\wwwroot\\App_Config\\Include\\Examples\\Sitecore.Owin.Authentication.IdentityServer.Disabler.config.example' -Destination 'C:\\install\\inetpub\\wwwroot\\App_Config\\Include\\Sitecore.Owin.Authentication.IdentityServer.Disabler.config'; `
    New-Item -Path 'C:\\install\\inetpub\\wwwroot\\upload' -ItemType Directory | Out-Null; `
    New-Item -Path 'C:\\install\\inetpub\\wwwroot\\sitecore\\shell\\override' -ItemType Directory | Out-Null; `
    Remove-Item -Path 'C:\\install\\inetpub\\wwwroot\\App_Data\\logs' -Force -Recurse;

COPY --from=assets ["C:\\install\\tools\\", "C:\\install\\tools\\"]
COPY ${SC_ROLE_CONFIG_DIRECTORY} C:\\install\\inetpub\\wwwroot\\

RUN $xdts = (Get-ChildItem -Path 'C:\\install\\inetpub\\wwwroot\\*.config.xdt'), (Get-ChildItem -Path 'C:\\install\\inetpub\\wwwroot\\App_Config\\*.config.xdt' -Recurse); `
    $xdts | ForEach-Object { & 'C:\\install\\tools\\scripts\\Invoke-XdtTransform.ps1' -Path $_.FullName.Replace('.xdt', '') -XdtPath $_.FullName -XdtDllPath 'C:\\install\\tools\\bin\\Microsoft.Web.XmlTransform.dll'; }; `
    $xdts | ForEach-Object { Remove-Item -Path $_.FullName; };

COPY .\config\*.config C:\\install\\inetpub\\wwwroot\\App_Config\\Include\\

FROM $BASE_IMAGE

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ARG SC_ROLE_DEFINE

COPY --from=build ["C:\\install\\inetpub\\wwwroot\\", "C:\\inetpub\\wwwroot\\"]
COPY --from=assets ["C:\\install\\tools\\", "C:\\tools\\"]
COPY --from=assets ["C:\\install\\setup\\", "C:\\install\\setup\\"]

RUN $env:INSTALL_TEMP = 'C:\\install'; `
    $env:TOOLS_PATH = 'C:\\tools'; `
    $env:IIS_SITE_PATH = 'IIS:\Sites\Default Web Site'; `
    $env:IIS_APPPOOL_PATH = 'IIS:\AppPools\DefaultAppPool'; `
    Start-Process msiexec.exe -ArgumentList '/i', (Join-Path $env:INSTALL_TEMP '\\setup\\urlrewrite.msi'), '/quiet', '/norestart' -NoNewWindow -Wait; `
    Start-Process (Join-Path $env:INSTALL_TEMP '\\setup\\vc_redist.exe') -ArgumentList '/install', '/passive', '/norestart' -NoNewWindow -Wait; `
    setx /M PATH $($env:PATH + ';C:\tools\scripts;C:\tools\bin') | Out-Null; `
    Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters' -Name 'ServerPriorityTimeLimit' -Value 0 -Type DWord; `
    Add-LocalGroupMember -Group 'Performance Monitor Users' -Member 'IIS AppPool\DefaultAppPool'; `
    Import-Module WebAdministration; `
    Set-ItemProperty -Path $env:IIS_APPPOOL_PATH -Name 'processModel.identityType' -Value 'LocalSystem'; `
    Set-WebConfigurationProperty -PSPath $env:IIS_SITE_PATH -Filter '/appSettings/add[@key=\"role:define\"]' -Name 'value' -Value $env:SC_ROLE_DEFINE; `
    Remove-Item -Path $env:INSTALL_TEMP -Force -Recurse;
