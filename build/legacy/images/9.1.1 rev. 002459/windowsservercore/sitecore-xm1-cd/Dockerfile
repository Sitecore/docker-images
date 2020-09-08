# escape=`
ARG BASE_IMAGE

FROM $BASE_IMAGE as builder

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

COPY . /install/

# Expand zips, prepare SIF config and WDP package
RUN $env:SIF_CONFIG = 'sitecore-XM1-cd.json'; `
    $env:SIF_PACKAGE = 'Sitecore*_cd.scwdp.zip'; `
    $env:SITENAME = 'sc'; `
    $env:INSTALL_TEMP = 'C:\\install'; `
    Expand-Archive -Path (Join-Path $env:INSTALL_TEMP '*.zip') -DestinationPath $env:INSTALL_TEMP; `
    Expand-Archive -Path (Join-Path $env:INSTALL_TEMP '*Configuration files*.zip') -DestinationPath $env:INSTALL_TEMP; `
    $config = Get-Content (Join-Path $env:INSTALL_TEMP $env:SIF_CONFIG) | ConvertFrom-Json; `
    $config.Variables.'Site.PhysicalPath' = 'C:\inetpub\{0}' -f $env:SITENAME; `
    ConvertTo-Json $config -Depth 50 | Set-Content -Path (Join-Path $env:INSTALL_TEMP $env:SIF_CONFIG); `
    Rename-Item -Path (Resolve-Path (Join-Path $env:INSTALL_TEMP $env:SIF_CONFIG)).Path -NewName 'config.json'; `
    Rename-Item -Path (Resolve-Path (Join-Path $env:INSTALL_TEMP $env:SIF_PACKAGE)).Path -NewName 'package.zip';

FROM $BASE_IMAGE

# BUG: Target path needs to exist when building with Docker Engine 19.03.1, see https://github.com/docker/for-win/issues/4349. Should be removed when fixed.
RUN MKDIR C:\install
COPY --from=builder ["/install/config.json", "/install/package.zip", "/install/license.xml", "/install/"]
COPY --from=builder ["/install/Sitecore", "/Sitecore"]

# Install Sitecore, apply tweaks and cleanup
RUN $env:SITENAME = 'sc'; `
    $env:INSTALL_TEMP = 'C:\\install'; `
    $env:SQL_ADMIN_USER = 'sa'; `
    $env:SQL_ADMIN_PASSWORD = 'HASH-epsom-sunset-cost7!'; `
    $env:SQL_HOST = 'sql'; `
    $env:SQL_DB_PREFIX = 'sc'; `
    $env:SOLR_URL = 'http://solr:8983/solr'; `
    $env:IDENTITYSERVER_URL = 'https://127.0.0.1'; `
    Install-SitecoreConfiguration -Path (Join-Path $env:INSTALL_TEMP '\\config.json') -Package (Join-Path $env:INSTALL_TEMP '\\package.zip') `
    -LicenseFile (Join-Path $env:INSTALL_TEMP '\\license.xml') `
    -Sitename $env:SITENAME `
    -SitecoreIdentityAuthority $env:IDENTITYSERVER_URL `
    -SolrUrl $env:SOLR_URL `
    -SolrCorePrefix $env:SITENAME `
    -SqlServer $env:SQL_HOST `
    -SqlDbPrefix $env:SITENAME `
    -SqlSecurityUser $env:SQL_ADMIN_USER -SqlSecurityPassword $env:SQL_ADMIN_PASSWORD `
    -SqlWebUser $env:SQL_ADMIN_USER -SqlWebPassword $env:SQL_ADMIN_PASSWORD `
    -SqlFormsUser $env:SQL_ADMIN_USER -SqlFormsPassword $env:SQL_ADMIN_PASSWORD `
    -Skip "CreateHostHeader", "CreateBindings"; `
    $iisPath = ('IIS:\Sites\{0}' -f $env:SITENAME); `
    Set-WebConfiguration -PSPath $iisPath -Filter '/system.web/customErrors/@mode' -Value 'Off'; `
    Add-LocalGroupMember -Group 'Performance Monitor Users' -Member ('IIS AppPool\{0}' -f $env:SITENAME); `
    Set-ItemProperty ('IIS:\AppPools\{0}' -f $env:SITENAME) -Name 'processModel.identityType' -Value 'LocalSystem'; `
    Move-Item -Path ('C:\\inetpub\\{0}\\App_Config\\Include\\Examples\\Sitecore.Owin.Authentication.IdentityServer.Disabler.config.example' -f $env:SITENAME) -Destination ('C:\\inetpub\\{0}\\App_Config\\Include\\Sitecore.Owin.Authentication.IdentityServer.Disabler.config' -f $env:SITENAME); `
    Remove-Item -Path 'C:\\*.log'; `
    Remove-Item -Path ('C:\\inetpub\\{0}\\App_Data\\logs' -f $env:SITENAME) -Force -Recurse; `
    Remove-Item -Path $env:INSTALL_TEMP -Force -Recurse;

# ServiceMonitor needs to point to the Application Pool that Sitecore runs in instead of the default one, to support environment variables
ENTRYPOINT ["C:\\ServiceMonitor.exe", "w3svc", "sc"]