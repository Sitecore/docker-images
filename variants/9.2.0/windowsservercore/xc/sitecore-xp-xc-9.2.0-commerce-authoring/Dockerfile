# escape=`
ARG BASE_IMAGE

FROM $BASE_IMAGE as builder

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

COPY . /install/

# Expand zips and prepare SIF config
RUN $env:INSTALL_TEMP = 'C:\\install'; `
    Expand-Archive -Path (Resolve-Path (Join-Path $env:INSTALL_TEMP '\\Sitecore.Commerce*.zip')).Path -DestinationPath $env:INSTALL_TEMP; `
	Expand-Archive -Path (Resolve-Path (Join-Path $env:INSTALL_TEMP '\\Sitecore Azure Toolkit*.zip')).Path -DestinationPath (Join-Path $env:INSTALL_TEMP 'sat'); `
    Expand-Archive -Path (Join-Path $env:INSTALL_TEMP 'SIF.Sitecore.Commerce.*.zip') -DestinationPath (Join-Path $env:INSTALL_TEMP 'sif'); `
	Import-Module (Join-Path $env:INSTALL_TEMP '\sat\tools\Sitecore.Cloud.Cmdlets.psm1') -Verbose; `
	Import-Module (Join-Path $env:INSTALL_TEMP '\sat\tools\Sitecore.Cloud.Cmdlets.dll') -Verbose; `
	Remove-SCDatabaseOperations -Path (Resolve-Path (Join-Path $env:INSTALL_TEMP '\\Sitecore.Commerce.Engine.OnPrem.Solr*.scwdp.zip')).Path -Destination (Join-Path $env:INSTALL_TEMP 'sif') -Force -Verbose;

FROM $BASE_IMAGE

# BUG: Target path needs to exist when building with Docker Engine 19.03.1, see https://github.com/docker/for-win/issues/4349. Should be removed when fixed.
RUN MKDIR C:\install; `
	Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1')); `
	choco install dotnetcore-windowshosting --version 2.2.5  -y --params="Quiet";

COPY . /install/
COPY --from=builder /install/sif /install

# Install CommerceEngine using SIF
RUN	$env:INSTALL_TEMP = 'C:\\install'; `
	$env:COMMERCE_ENGINE_WDP_FULL_PATH = (Resolve-Path (Join-Path $env:INSTALL_TEMP '\\Sitecore.Commerce.Engine.OnPrem.Solr*.scwdp.zip')).Path; `
	$env:SITENAME = 'Authoring'; `
	$env:PORT = '5000'; `
	$env:MINION_INSTANCE = 'false'; `
	$env:ENVIRONMENT_NAME = ('Habitat{0}' -f $env:SITENAME); `
	$env:SITE_HOST_HEADER_NAME = 'sc'; `
	$env:COMMERCE_SERVICES_HOST_POSTFIX = ('commerce.{0}' -f $env:SITE_HOST_HEADER_NAME); `
#	$env:IDENTITY_SERVER_SITE_NAME = ('identityserver.{0}' -f $env:COMMERCE_SERVICES_HOST_POSTFIX); `
	$env:IDENTITY_SERVER_SITE_NAME = 'sclocalidentityserver.dev.local'; `
	$env:SITECORE_USERNAME = 'admin'; `
	$env:SITECORE_DOMAIN = 'sitecore'; `
	$env:SITECORE_PASSWORD = 'b'; `
	$env:HOST_PREFIX = ($env:SITENAME.ToLower()); `
	$env:COMMERCE_ENGINE_CERTIFICATE_NAME = ('{0}.storefront.engine' -f $env:SITE_HOST_HEADER_NAME); `
	$env:SITECORE_IDENTITY_SERVER_URL = ('https://{0}' -f $env:IDENTITY_SERVER_SITE_NAME); `
	$env:BIZ_FX_PORT = '4200'; `
	$env:COMMERCE_SERVICES_DB_SERVER = 'sql'; `
	$env:SQL_ADMIN_USER = 'sa'; `
    $env:SQL_ADMIN_PASSWORD = 'HASH-epsom-sunset-cost7!'; `
	$env:COMMERCE_SERVICES_DB_NAME = 'xc_Sitecore.Commerce.Engine.Shared.DB'; `
	$env:COMMERCE_SERVICES_GLOBAL_DB_NAME = 'xc_Sitecore.Commerce.Engine.Global.DB'; `
	$env:USER_DOMAIN = $env:COMPUTERNAME; `
	$env:USER_NAME = 'CSRuntimeUser'; `
	$env:USER_PASSWORD = '@rj3nV@nV1'; `
	$env:COMMERCE_SEARCH_PROVIDER = 'SOLR'; `
	$env:SOLR_URL = 'http://solr:8983/solr/'; `
	$env:SEARCH_INDEX_PREFIX = 'xc_'; `
	$env:REDIS_CONFIGURATION = '172.28.0.1'; `
	$env:REDIS_INSTANCE_NAME = 'Redis'; `
	$env:ENGINE_SHOPS_URL = ('https://{0}.{1}' -f 'shops', $env:COMMERCE_SERVICES_HOST_POSTFIX); `
	$env:ENGINE_AUTHORING_URL = ('https://{0}.{1}' -f 'authoring', $env:COMMERCE_SERVICES_HOST_POSTFIX); `
	$env:ENGINE_MINIONS_URL = ('https://{0}.{1}' -f 'minions', $env:COMMERCE_SERVICES_HOST_POSTFIX); `
	& (Join-Path $env:INSTALL_TEMP "\\Ensure-Local-User.ps1") `
	-UserDomain $env:USER_DOMAIN `
	-UserName $env:USER_NAME `
	-UserPassword $env:USER_PASSWORD; `
	Install-SitecoreConfiguration -Path (Join-Path $env:INSTALL_TEMP '\\Configuration\\Commerce\\CommerceEngine\\CommerceEngine.Instance.Deploy.json') `
	-CommerceEngineWdpFullPath $env:COMMERCE_ENGINE_WDP_FULL_PATH `
	-SiteName $env:SITENAME `
	-SiteHostHeaderName $env:SITE_HOST_HEADER_NAME `
	-SitecoreUsername $env:SITECORE_USERNAME `
	-SitecoreDomain $env:SITECORE_DOMAIN `
	-SitecoreUserPassword $env:SITECORE_PASSWORD `
	-HostPrefix $env:HOST_PREFIX `
	-CommerceServicesHostPostfix $env:COMMERCE_SERVICES_HOST_POSTFIX `
	-EnvironmentName $env:ENVIRONMENT_NAME `
	-CommerceEngineCertificateName $env:COMMERCE_ENGINE_CERTIFICATE_NAME `
	-Port $env:PORT `
	-SitecoreIdentityServerUrl $env:SITECORE_IDENTITY_SERVER_URL `
	-MinionInstance $env:MINION_INSTANCE `
	-BizFxPort $env:BIZ_FX_PORT `
	-CommerceServicesDbServer $env:COMMERCE_SERVICES_DB_SERVER `
	-SqlAdminUser $env:SQL_ADMIN_USER `
	-SqlAdminPassword $env:SQL_ADMIN_PASSWORD `
	-CommerceServicesDbName $env:COMMERCE_SERVICES_DB_NAME `
	-CommerceServicesGlobalDbName $env:COMMERCE_SERVICES_GLOBAL_DB_NAME `
	-UserDomain $env:USER_DOMAIN `
	-UserName $env:USER_NAME `
	-UserPassword $env:USER_PASSWORD `
	-CommerceSearchProvider $env:COMMERCE_SEARCH_PROVIDER `
	-SolrUrl $env:SOLR_URL `
	-SearchIndexPrefix $env:SEARCH_INDEX_PREFIX `
	-RedisConfiguration $env:REDIS_CONFIGURATION `
	-RedisInstanceName $env:REDIS_INSTANCE_NAME `
	-EngineShopsUrl $env:ENGINE_SHOPS_URL `
	-EngineAuthoringUrl $env:ENGINE_AUTHORING_URL `
	-EngineMinionsUrl $env:ENGINE_MINIONS_URL
	
EXPOSE 443
# CMD tail -f /dev/nullcd 