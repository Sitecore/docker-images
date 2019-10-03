# escape=`
ARG BASE_IMAGE

FROM $BASE_IMAGE as builder

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

# Extract artifacts to install dir
ARG INSTALL_TEMP='c:\\install'
COPY . ${INSTALL_TEMP}

# Extract zips and copy to webroot
RUN	$env:SITENAME = 'sc'; `
	$env:SITE_PATH = 'C:\\inetpub\\{0}' -f $env:SITENAME; `
	$env:XDTDLL_PATH = Join-Path $env:SITE_PATH '\\bin\\Microsoft.Web.XmlTransform.dll'; `
    $env:WEBCONFIG_PATH = Join-Path $env:SITE_PATH '\\Web.config'; `
	$env:COMMERCE_INCLUDE_PATH = Join-Path $env:SITE_PATH '\\App_Config\\Include\\Y.Commerce.Engine\\'; `
	$env:COMMERCE_HOST = 'commerceauthoring.sc9.com'; `
#	$env:COMMERCE_PORT = ''; `
	$env:COMMERCE_ENVIRONMENT = 'sclocalAuthoring'; `
	$env:COMMERCE_SHOP_NAME = 'CommerceEngineDefaultStorefront'; `
	$env:COMMERCE_SHOP_CURRENCY = 'USD'; `
	$env:COMMERCE_CERTIFICATE_THUMBPRINT = 'C161F1302DE466C306F52FCA411A7EC9901AE60A'; `
	$env:COMMERCE_ENABLE_CONFIGS = 'Sitecore.Commerce.Engine.DataProvider.config,Sitecore.Commerce.Engine.Connectors.Index.Solr.config,Sitecore.Commerce.Engine.Connectors.Index.Common.config'; `
	Expand-Archive -Path (Join-Path $env:INSTALL_TEMP '*.zip') -DestinationPath $env:INSTALL_TEMP; `
	Expand-Archive -Path (Join-Path $env:INSTALL_TEMP 'Sitecore Commerce Connect Core*.scwdp.zip') -DestinationPath (Join-Path $env:INSTALL_TEMP 'CommerceConnectWdp'); `
	Expand-Archive -Path (Join-Path $env:INSTALL_TEMP 'Sitecore Commerce ExperienceProfile Core*.scwdp.zip') -DestinationPath (Join-Path $env:INSTALL_TEMP 'CommercexProfilesWdp'); `
	Expand-Archive -Path (Join-Path $env:INSTALL_TEMP 'Sitecore Commerce ExperienceAnalytics Core*.scwdp.zip') -DestinationPath (Join-Path $env:INSTALL_TEMP 'CommercexAnalyticsWdp'); `
	Expand-Archive -Path (Join-Path $env:INSTALL_TEMP 'Sitecore Commerce Marketing Automation Core*.scwdp.zip') -DestinationPath (Join-Path $env:INSTALL_TEMP 'CommerceMAWdp'); `
	Expand-Archive -Path (Join-Path $env:INSTALL_TEMP 'Sitecore Commerce Engine Connect*.scwdp.zip') -DestinationPath (Join-Path $env:INSTALL_TEMP 'CEConnectWdp'); `
	Copy-Item -Path (Join-Path $env:INSTALL_TEMP "\\CommerceConnectWdp\\Content\\Website\\*") -Destination ('C:\\inetpub\\{0}\\' -f $env:SITENAME) -Recurse -Force; `
	Copy-Item -Path (Join-Path $env:INSTALL_TEMP "\\CommercexProfilesWdp\\Content\\Website\\*") -Destination ('C:\\inetpub\\{0}\\' -f $env:SITENAME) -Recurse -Force; `
	Copy-Item -Path (Join-Path $env:INSTALL_TEMP "\\CommercexAnalyticsWdp\\Content\\Website\\*") -Destination ('C:\\inetpub\\{0}\\' -f $env:SITENAME) -Recurse -Force; `
	Copy-Item -Path (Join-Path $env:INSTALL_TEMP "\\CommerceMAWdp\\Content\\Website\\*") -Destination ('C:\\inetpub\\{0}\\' -f $env:SITENAME) -Recurse -Force; `
	Copy-Item -Path (Join-Path $env:INSTALL_TEMP "\\CEConnectWdp\\Content\\Website\\*") -Destination $env:SITE_PATH -Recurse -Force; `
	& (Join-Path $env:INSTALL_TEMP "\\Invoke-XdtTransform.ps1") -Path $env:WEBCONFIG_PATH -XdtPath (Join-Path $env:SITE_PATH '\\MergeFiles\\Sitecore.Commerce.Engine.Connectors.Merge.Config') -XdtDllPath $env:XDTDLL_PATH; `
	& (Join-Path $env:INSTALL_TEMP "\\Update-Commerce-Connection-Details.ps1") -EngineConnectIncludeDir $env:COMMERCE_INCLUDE_PATH -CommerceServicesHost $env:COMMERCE_HOST -CommerceServicesEnvironment $env:COMMERCE_ENVIRONMENT -CommerceServicesShopName $env:COMMERCE_SHOP_NAME -CommerceServicesShopCurrency $env:COMMERCE_SHOP_CURRENCY -CommerceServicesCertificateThumbprint $env:COMMERCE_CERTIFICATE_THUMBPRINT; `
	& (Join-Path $env:INSTALL_TEMP "\\Enable-Config-Files.ps1") -ConfigDir $env:COMMERCE_INCLUDE_PATH -ConfigFileList $env:COMMERCE_ENABLE_CONFIGS;
	
#	CMD tail -f /dev/nullcd 