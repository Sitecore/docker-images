# escape=`
ARG BASE_IMAGE

FROM $BASE_IMAGE as builder

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

# Extract artifacts to install dir
ARG INSTALL_TEMP='c:\\install'
COPY . ${INSTALL_TEMP}

RUN	Invoke-WebRequest -Uri 'https://dist.nuget.org/win-x86-commandline/v5.0.2/nuget.exe' -UseBasicParsing -OutFile (Join-Path $env:INSTALL_TEMP '\\nuget.exe'); `
    & (Join-Path $env:INSTALL_TEMP '\\nuget.exe') install 'Microsoft.Web.Xdt' -Version '3.0.0' -OutputDirectory $env:INSTALL_TEMP;
	
FROM $BASE_IMAGE

COPY --from=builder [ "/install/", "/install/" ]

# Extract zips and copy to webroot
RUN	$env:SITENAME = 'sc'; `
	$env:INSTALL_TEMP = 'c:\\install'; `
	$env:SITE_PATH = ('C:\\inetpub\\{0}' -f $env:SITENAME); `
	$env:XDTDLL_PATH = (Join-Path $env:SITE_PATH '\\bin\\Microsoft.Web.XmlTransform.dll'); `
    $env:WEBCONFIG_PATH = (Join-Path $env:SITE_PATH '\\Web.config'); `
	$env:COMMERCE_INCLUDE_PATH = (Join-Path $env:SITE_PATH '\\App_Config\\Include\\Y.Commerce.Engine\\'); `
	$env:COMMERCE_HOST = 'authoring.commerce.sc'; `
	$env:COMMERCE_ENVIRONMENT = 'HabitatAuthoring'; `
	$env:COMMERCE_SHOP_NAME = 'CommerceEngineDefaultStorefront'; `
	$env:COMMERCE_SHOP_CURRENCY = 'USD'; `
	$env:COMMERCE_CERTIFICATE_ID = ('{0}.storefront.engine' -f $env:SITENAME); `
	$env:COMMERCE_CERTIFICATE_STORE_PATH = 'Cert:\LocalMachine\My'; `
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
    Copy-Item -Path (Join-Path $env:INSTALL_TEMP "\\Microsoft.Web.Xdt.*\\lib\\net40\\Microsoft.Web.XmlTransform.dll") -Destination $env:XDTDLL_PATH; `
	# Note: the dll below shouldn't end up on a production env...
	Copy-Item -Path (Join-Path $env:INSTALL_TEMP "\\Sitecore.Services.HttpAuthentication.dll") -Destination ('C:\\inetpub\\{0}\\bin\\Sitecore.Services.HttpAuthentication.dll' -f $env:SITENAME) -Force; `
	& (Join-Path $env:INSTALL_TEMP "\\Invoke-XdtTransform.ps1") `
	-Path $env:WEBCONFIG_PATH `
	-XdtPath (Join-Path $env:SITE_PATH '\\MergeFiles\\Sitecore.Commerce.Engine.Connectors.Merge.Config') `
	-XdtDllPath $env:XDTDLL_PATH; `
	& (Join-Path $env:INSTALL_TEMP "\\Update-Commerce-Connection-Details.ps1") `
	-EngineConnectIncludeDir $env:COMMERCE_INCLUDE_PATH `
	-CommerceServicesHost $env:COMMERCE_HOST `
	-CommerceServicesEnvironment $env:COMMERCE_ENVIRONMENT `
	-CommerceServicesShopName $env:COMMERCE_SHOP_NAME `
	-CommerceServicesShopCurrency $env:COMMERCE_SHOP_CURRENCY `
	-CommerceServicesCertificateId $env:COMMERCE_CERTIFICATE_ID `
	-CommerceServicesCertificateStorePath $env:COMMERCE_CERTIFICATE_STORE_PATH; `
	& (Join-Path $env:INSTALL_TEMP "\\Enable-Config-Files.ps1") `
	-ConfigDir $env:COMMERCE_INCLUDE_PATH `
	-ConfigFileList $env:COMMERCE_ENABLE_CONFIGS; `
	Remove-Item -Path $env:INSTALL_TEMP -Force -Recurse;