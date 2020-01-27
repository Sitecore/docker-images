# escape=`
ARG BASE_IMAGE
ARG ASSETS_IMAGE
ARG CERTIFICATES_IMAGE

FROM $ASSETS_IMAGE as assets
FROM $CERTIFICATES_IMAGE as certificates
FROM $BASE_IMAGE as build

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ARG ASSETS_USE_WDP_CONNECT_CORE
ARG ASSETS_USE_WDP_ENGINE_CONNECT
ARG ASSETS_USE_WDP_MA
ARG ASSETS_USE_WDP_XPROFILES
ARG ASSETS_USE_WDP_XANALYTICS

ARG SC_ROLE_CONFIG_DIRECTORY

COPY --from=assets ["${ASSETS_USE_WDP_CONNECT_CORE}", "C:\\temp\\packages\\"]
COPY --from=assets ["${ASSETS_USE_WDP_ENGINE_CONNECT}", "C:\\temp\\packages\\"]
COPY --from=assets ["${ASSETS_USE_WDP_MA}", "C:\\temp\\packages\\"]
COPY --from=assets ["${ASSETS_USE_WDP_XPROFILES}", "C:\\temp\\packages\\"]
COPY --from=assets ["${ASSETS_USE_WDP_XANALYTICS}", "C:\\temp\\packages\\"]

# expand selected wdp into installation directory
RUN Get-ChildItem 'C:\\temp\\packages\\*.zip' | Expand-Archive -DestinationPath 'C:\\temp' -Force ; `
    Copy-Item -Path 'C:\\temp\\Content\\Website\\*' -Destination 'C:\\inetpub\\wwwroot' -Recurse -Force;

# copy tools, certificates and transforms
COPY --from=assets ["C:\\install\\tools\\", "C:\\inetpub\\wwwroot\\temp\\install\\tools\\"]
COPY --from=certificates ["C:\\certificates\\", "C:\\inetpub\\wwwroot\\temp\\install\\certificates\\"]
COPY ${SC_ROLE_CONFIG_DIRECTORY} C:\\inetpub\\wwwroot\\

# find transform files, replace variables and do transformation
RUN & 'C:\\inetpub\\wwwroot\\temp\\install\\tools\\scripts\\Invoke-XdtTransform.ps1' -Path 'C:\\inetpub\\wwwroot\\Web.config' `
        -XdtPath 'C:\\inetpub\\wwwroot\\MergeFiles\\Sitecore.Commerce.Engine.Connectors.Merge.Config' `
        -XdtDllPath 'C:\\inetpub\\wwwroot\\temp\\install\\tools\\bin\\Microsoft.Web.XmlTransform.dll'; `
    $env:COMMERCE_CONFIG_PATH = 'C:\\inetpub\\wwwroot\\App_Config\\Include\\Y.Commerce.Engine\\'; `
    mv (Join-Path $env:COMMERCE_CONFIG_PATH 'Sitecore.Commerce.Engine.DataProvider.config.disabled') `
        (Join-Path $env:COMMERCE_CONFIG_PATH 'Sitecore.Commerce.Engine.DataProvider.config'); `
    mv (Join-Path $env:COMMERCE_CONFIG_PATH 'Sitecore.Commerce.Engine.Connectors.Index.Common.config.disabled') `
        (Join-Path $env:COMMERCE_CONFIG_PATH 'Sitecore.Commerce.Engine.Connectors.Index.Common.config'); `
    mv (Join-Path $env:COMMERCE_CONFIG_PATH 'Sitecore.Commerce.Engine.Connectors.Index.Solr.config.disabled') `
        (Join-Path $env:COMMERCE_CONFIG_PATH 'Sitecore.Commerce.Engine.Connectors.Index.Solr.config'); `
    $xdts = [System.Collections.ArrayList]@(); `
    $xdts.AddRange(@(Get-ChildItem -Path 'C:\\inetpub\\wwwroot\\App_Config\\Include\\Y.Commerce.Engine\\*.config.xdt' -Recurse)); `
    $xdts | ForEach-Object { & 'C:\\inetpub\\wwwroot\\temp\\install\\tools\\scripts\\Invoke-XdtTransform.ps1' -Path $_.FullName.Replace('.xdt', '') -XdtPath $_.FullName -XdtDllPath 'C:\\inetpub\\wwwroot\\temp\\install\\tools\\bin\\Microsoft.Web.XmlTransform.dll'; }; `
    $xdts | ForEach-Object { Remove-Item -Path $_.FullName; };

FROM $BASE_IMAGE

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

COPY --from=build ["C:\\inetpub\\wwwroot\\", "C:\\inetpub\\wwwroot\\"]

RUN $env:INSTALL_TEMP = 'C:\\inetpub\\wwwroot\\temp\\install'; `
    $env:IIS_SITE_NAME = 'Default Web Site'; `
    $password = ConvertTo-SecureString -String (Get-Content -Path (Join-Path $env:INSTALL_TEMP '\\certificates\\password')) -Force -AsPlainText; `
    # install certificates
    Import-PfxCertificate -FilePath (Join-Path $env:INSTALL_TEMP '\\certificates\\sitecore-root.pfx') -CertStoreLocation 'cert:\localmachine\root' -Password $password | Out-Null; `
    Import-PfxCertificate -FilePath (Join-Path $env:INSTALL_TEMP '\\certificates\\sitecore-root.pfx') -CertStoreLocation 'cert:\localmachine\my' -Password $password | Out-Null; `
    # configure SSL binding because Commerce Engine requires HTTPS (see Sitecore ticket #542018)
    Import-Module WebAdministration; `
    $cmCert = Import-PfxCertificate -FilePath (Join-Path $env:INSTALL_TEMP '\\certificates\\cm.pfx') -CertStoreLocation 'cert:\localmachine\my' -Password $password; `
    New-WebBinding -Name $env:IIS_SITE_NAME -IPAddress '*' -Port '443' -Protocol "https" -HostHeader '*'; `
    $binding = Get-WebBinding -Name $env:IIS_SITE_NAME -Protocol "https"; `
    $binding.AddSslCertificate($cmCert.GetCertHashString(), 'my'); `
    # configure SSL flags
    Set-WebConfigurationProperty -PSPath 'machine/webroot/apphost' -Filter 'system.webServer/security/access' -Name 'sslFlags' -Value 'SslNegotiateCert'; `
    # delete temporary files
    Remove-Item -Path $env:INSTALL_TEMP -Force -Recurse;
