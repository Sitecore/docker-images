# escape=`
ARG BUILD_IMAGE
ARG BASE_IMAGE

FROM $BUILD_IMAGE as builder

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

COPY . /install/

# Expand zips, prepare SIF config and WDP package
RUN $env:SIF_CONFIG = 'xconnect-XP0.json'; `
    $env:SIF_PACKAGE = 'Sitecore*_xp0xconnect.scwdp.zip'; `
    $env:SITENAME = 'xconnect'; `
    $env:INSTALL_TEMP = 'C:\\install'; `
    Expand-Archive -Path (Join-Path $env:INSTALL_TEMP '*.zip') -DestinationPath $env:INSTALL_TEMP; `
    Expand-Archive -Path (Join-Path $env:INSTALL_TEMP '*Configuration files*.zip') -DestinationPath $env:INSTALL_TEMP; `
    $config = Get-Content (Join-Path $env:INSTALL_TEMP $env:SIF_CONFIG)  | Where-Object { $_ -notmatch '^\s*\/\/'} | Out-String | ConvertFrom-Json; `
    $config.Tasks.InstallWDP.Params.Arguments | Add-Member -Name 'Skip' -Value @(@{'ObjectName' = 'dbDacFx'}, @{'ObjectName' = 'dbFullSql'}) -MemberType NoteProperty; `
    $config.Variables.'Site.PhysicalPath' = 'C:\inetpub\{0}' -f $env:SITENAME; `
    ConvertTo-Json $config -Depth 50 | Set-Content -Path (Join-Path $env:INSTALL_TEMP $env:SIF_CONFIG); `
    Rename-Item -Path (Resolve-Path (Join-Path $env:INSTALL_TEMP $env:SIF_CONFIG)).Path -NewName 'config.json'; `
    Rename-Item -Path (Resolve-Path (Join-Path $env:INSTALL_TEMP $env:SIF_PACKAGE)).Path -NewName 'package.zip';

FROM $BASE_IMAGE

# BUG: Target path needs to exist when building with Docker Engine 19.03.1, see https://github.com/docker/for-win/issues/4349. Should be removed when fixed.
RUN MKDIR C:\install
COPY --from=builder ["/install/config.json", "/install/package.zip", "/install/license.xml", "/install/disable-solr-ssl.json", "/install/"]
COPY --from=builder ["/install/Sitecore", "/Sitecore"]

# Install XConnect, disable ssl, apply tweaks and cleanup
RUN $env:SITENAME = 'xconnect'; `
    $env:INSTALL_TEMP = 'C:\\install'; `
    $env:SQL_ADMIN_USER = 'sa'; `
    $env:SQL_ADMIN_PASSWORD = 'HASH-epsom-sunset-cost7!'; `
    $env:SQL_HOST = 'sql'; `
    $env:SQL_DB_PREFIX = 'sc'; `
    $env:SOLR_URL = 'http://solr:8983/solr'; `
    $env:XCONNECT_CERT_NAME = 'xconnect-client'; `
    $env:XCONNECT_SSL_NAME = 'xconnect'; `
    Install-SitecoreConfiguration -Path (Join-Path $env:INSTALL_TEMP '\\config.json') -Package (Join-Path $env:INSTALL_TEMP '\\package.zip') `
    -LicenseFile (Join-Path $env:INSTALL_TEMP '\\license.xml') `
    -Sitename $env:SITENAME `
    -SolrUrl $env:SOLR_URL `
    -SolrCorePrefix $env:SQL_DB_PREFIX `
    -XConnectCert $env:XCONNECT_CERT_NAME `
    -SSLCert $env:XCONNECT_SSL_NAME `
    -SqlServer $env:SQL_HOST `
    -SqlDbPrefix $env:SQL_DB_PREFIX `
    -SqlAdminUser $env:SQL_ADMIN_USER -SqlAdminPassword $env:SQL_ADMIN_PASSWORD `
    -SqlCollectionUser $env:SQL_ADMIN_USER -SqlCollectionPassword $env:SQL_ADMIN_PASSWORD `
    -SqlMessagingUser $env:SQL_ADMIN_USER -SqlMessagingPassword $env:SQL_ADMIN_PASSWORD `
    -SqlProcessingEngineUser $env:SQL_ADMIN_USER -SqlProcessingEnginePassword $env:SQL_ADMIN_PASSWORD `
    -SqlMarketingAutomationUser $env:SQL_ADMIN_USER -SqlMarketingAutomationPassword $env:SQL_ADMIN_PASSWORD `
    -SqlReferenceDataUser $env:SQL_ADMIN_USER -SqlReferenceDataPassword $env:SQL_ADMIN_PASSWORD `
    -SqlProcessingPoolsUser $env:SQL_ADMIN_USER -SqlProcessingPoolsPassword $env:SQL_ADMIN_PASSWORD `
    -Skip "StopServices", "RemoveServices", "RemoveDefaultBinding", "CleanShards", "CreateShards", "CreateShardApplicationDatabaseServerLoginSqlCmd", "CreateShardManagerApplicationDatabaseUserSqlCmd", "CreateShard0ApplicationDatabaseUserSqlCmd", "CreateShard1ApplicationDatabaseUserSqlCmd", "InstallServices", "StartServices", "ConfigureSolrSchemas"; `
    Install-SitecoreConfiguration -Path (Join-Path $env:INSTALL_TEMP '\\disable-solr-ssl.json') -Sitename $env:SITENAME; `
    Set-WebConfiguration -PSPath ('IIS:\Sites\{0}' -f $env:SITENAME) -Filter '/system.web/customErrors/@mode' -Value 'Off'; `
    Add-LocalGroupMember -Group 'Performance Monitor Users' -Member ('IIS AppPool\{0}' -f $env:SITENAME); `
    Remove-Item -Path 'C:\\*.log'; `
    Remove-Item -Path ('C:\\inetpub\\{0}\\App_Data\\logs' -f $env:SITENAME) -Force -Recurse; `
    Remove-Item -Path $env:INSTALL_TEMP -Force -Recurse;

EXPOSE 443
