# escape=`
ARG BUILD_IMAGE
ARG BASE_IMAGE

FROM $BUILD_IMAGE as build

ARG SC_USE_WDP

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

COPY . /install/

RUN $env:INSTALL_TEMP = 'C:\\install'; `
    Expand-Archive -Path (Join-Path $env:INSTALL_TEMP '*.zip') -DestinationPath $env:INSTALL_TEMP; `
    Expand-Archive -Path (Join-Path $env:INSTALL_TEMP $env:SC_USE_WDP) -DestinationPath $env:INSTALL_TEMP; `
    Copy-Item -Path 'C:\\install\\license.xml' -Destination 'C:\\install\\Content\\Website\\App_Data'; `
    Copy-Item -Path 'C:\\install\\Content\\Website\\App_Config\\Include\\Examples\\Sitecore.Owin.Authentication.IdentityServer.Disabler.config.example' -Destination 'C:\\install\\Content\\Website\\App_Config\\Include\\Sitecore.Owin.Authentication.IdentityServer.Disabler.config'; `
    Copy-Item -Path 'C:\\install\\Content\\Website\\App_Config\\Include\\Examples\\Sitecore.LoadBalancing.config.example' -Destination 'C:\\install\\Content\\Website\\App_Config\\Include\\Sitecore.LoadBalancing.config'; `
    Copy-Item -Path 'C:\\install\\Content\\Website\\App_Config\\Include\\Examples\\DataFolder.config.example' -Destination 'C:\\install\\Content\\Website\\App_Config\\Include\\DataFolder.config'; `
    New-Item -Path 'C:\\install\\Content\\Website\\upload' -ItemType Directory | Out-Null; `
    Remove-Item -Path 'C:\\install\\Content\\Website\\App_Data\\logs' -Force -Recurse; `
    $webConfigPath = 'C:\\install\\Content\\Website\\Web.config'; `
    $webConfig = Get-Content -Path $webConfigPath; `
    $webConfig = $webConfig.Replace('<add key=\"Telerik.AsyncUpload.ConfigurationEncryptionKey\" value=\"\"/>', ''); `
    $webConfig = $webConfig.Replace('<add key=\"Telerik.Upload.ConfigurationHashKey\" value=\"\"/>', ''); `
    $webConfig = $webConfig.Replace('<add key=\"Telerik.Web.UI.DialogParametersEncryptionKey\" value=\"\"/>', ''); `
    $webConfig | Set-Content -Path $webConfigPath -Encoding utf8; `
    (Get-Content -Path 'C:\\install\\Content\\Website\\App_Config\\Include\\DataFolder.config').Replace('>/data<', '>C:\inetpub\wwwroot\App_Data<') | Set-Content -Path 'C:\\install\\Content\\Website\\App_Config\\Include\\DataFolder.config' -Encoding utf8; `
    '<configuration xmlns:patch=\"http://www.sitecore.net/xmlconfig/\"><sitecore><settings><setting name=\"Counters.Enabled\"><patch:attribute name=\"value\">false</patch:attribute></setting></settings></sitecore></configuration>' | Set-Content -Path 'C:\\install\\Content\\Website\\App_Config\\Include\\DisablePerformanceCounters.config' -Encoding utf8;

FROM $BASE_IMAGE

ARG SC_ROLE_DEFINE

COPY --from=build ["/install/Content/Website/", "/inetpub/wwwroot/"]

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

# TODO: How about using xdt transforms for web.config, connectionstring.config, sitecore patches (PER role)?

RUN $env:SQL_USER = 'sa'; `
    $env:SQL_PASSWORD = 'HASH-epsom-sunset-cost7!'; `
    $env:SQL_HOST = 'sql'; `
    $env:SQL_DB_PREFIX = 'sc'; `
    $env:SOLR_URL = 'http://solr:8983/solr'; `
    $env:IDENTITYSERVER_SECRET = 'R6mYfCbM4Ci0niMBuzKVHIKc'; `
    $env:TELERIK_KEY = 'E67vGAporNBSF3G5Q03z7x0VdLYen1Fl5XRWNaFw9SFu6pECbA2CapczEEKIkbcamOvcCsvQzNCPI5bw7UG06yRGBAYGj8sH7NvKMwH8dpRZcRgv0X904ziHqRLWSokAFus1rjXfsAJKvzh9G9kOfqGF9DitWfWvRDZ2eP7lLlaxjxTLti0MijfrYZrw0L8343pdQdobNvmtGHItQmOmdoiFRJByheBtvU7Gm7Cq5D9ek9soaURf2mreiCnsMEJp'; `
    $env:IIS_SITE_PATH = 'IIS:\Sites\Default Web Site'; `
    $env:IIS_APPPOOL_PATH = 'IIS:\AppPools\DefaultAppPool'; `
    $env:CONNECTIONSTRINGS_PATH = 'C:\\inetpub\\wwwroot\\App_Config\\ConnectionStrings.config'; `
    $connectionStrings = Get-Content -Path $env:CONNECTIONSTRINGS_PATH; `
    $connectionStrings = $connectionStrings.Replace('user id=user;password=password;Data Source=(server);Database=Sitecore_', ('user id={0};password={1};Data Source={2};Database={3}_' -f $env:SQL_USER, $env:SQL_PASSWORD, $env:SQL_HOST, $env:SQL_DB_PREFIX)); `
    $connectionStrings = $connectionStrings.Replace('https://localhost:8993/solr', $env:SOLR_URL); `
    $connectionStrings = $connectionStrings.Replace('Set client secret for Sitecore Identity server here.', $env:IDENTITYSERVER_SECRET); `
    $connectionStrings | Set-Content -Path $env:CONNECTIONSTRINGS_PATH -Encoding utf8; `
    Import-Module WebAdministration; `
    Set-ItemProperty -Path $env:IIS_APPPOOL_PATH -Name 'processModel.identityType' -Value 'LocalSystem'; `
    Clear-WebConfiguration -PSPath $env:IIS_SITE_PATH -Filter '/system.webserver/rewrite/rules/rule'; `
    Set-WebConfiguration -PSPath $env:IIS_SITE_PATH -Filter '/system.web/customErrors/@mode' -Value 'Off'; `
    Set-WebConfigurationProperty -PSPath $env:IIS_SITE_PATH -Filter '/appSettings/add[@key=\"role:define\"]' -Name 'value' -Value $env:SC_ROLE_DEFINE; `
    Set-WebConfigurationProperty -PSPath $env:IIS_SITE_PATH -Filter '/appSettings/add[@key=\"Telerik.AsyncUpload.ConfigurationEncryptionKey\"]' -Name 'value' -Value $env:TELERIK_KEY; `
    Set-WebConfigurationProperty -PSPath $env:IIS_SITE_PATH -Filter '/appSettings/add[@key=\"Telerik.Upload.ConfigurationHashKey\"]' -Name 'value' -Value $env:TELERIK_KEY; `
    Set-WebConfigurationProperty -PSPath $env:IIS_SITE_PATH -Filter '/appSettings/add[@key=\"Telerik.Web.UI.DialogParametersEncryptionKey\"]' -Name 'value' -Value $env:TELERIK_KEY;