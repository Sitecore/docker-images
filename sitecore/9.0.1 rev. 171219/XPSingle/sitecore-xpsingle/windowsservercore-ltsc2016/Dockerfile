# escape=`
ARG BASE_IMAGE
FROM ${BASE_IMAGE}

#BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB
#
#	Global Definitions
#
#--------------------------------------------------------------------------------------------------------------------------

ENV `
	SITE_PREFIX="habitat" `
	SITE_SUFFIX="dev.local" `
	SITE_WEB_ROOT="C:\inetpub\wwwroot" `
	SITE_HOST_NAME="habitat.dev.local" `
	SITE_HABITAT_HOME_HOST_NAME="habitathome.dev.local" `
	SITE_HABITAT_HOME_PREFIX="habitathome" `
	SITE_ERROR_MODE="Off" `
	SITE_HABITAT_HOME_SSL_CERTIFICATE_NAME="habitathome.dev.local" `
	XCONNECT_SITE_NAME="habitat_xconnect.dev.local" `
	XCONNECT_CERTIFICATE_NAME="habitat.dev.local.xConnect.Client" `
	XCONNECT_SITE_ROOT="C:\inetpub\wwwroot\habitat_xconnect.dev.local" `
	XCONNECT_SQL_COLLECTION_USER="habitatcollectionuser" `
	XCONNECT_SQL_COLLECTION_PASSWORD="test12345" `
	SITECORE_SITE_ROOT="C:\inetpub\wwwroot\habitat.dev.local"

# RELEASE: Use next line for image release (reduce number of layers). See "DEBUG" comments below
COPY /InternalAssets /ExternalAssets ${INSTALL_PATH}/

# RELEASE: Use next line for image release (reduce number of layers). See "DEBUG" comments below
RUN	`
`
<####################################################################################################################### `
`
	xConnect `
`
------------------------------------------------------------------------------------------------------------------------#> `
`
<## DEBUG: Use next line for image debug (use additional layers to speed up debugging process by using docker cache). See "RELEASE" comments above `
COPY /InternalAssets/xconnect-solr.json ${INSTALL_PATH}/ `
#> `
`
<#RUN #> `
`
<# Install xConnect Solr Cores: ..................................................................................................... #> `
	`
	Write-Host 'Start: Install xConnect Solr Cores.' ; `
	`
	$sifConfigPath = Join-Path $env:INSTALL_PATH 'xconnect-solr.json' ; `
	`
	Install-SitecoreConfiguration $sifConfigPath `
		-SolrUrl $env:SOLR_URL `
		-SolrRoot $env:SOLR_ROOT `
		-SolrService $env:SOLR_SERVICE_NAME `
		-CorePrefix $env:SITE_PREFIX ; `
	`
	Write-Host 'End: Install xConnect Solr Cores.' ; `
`	
<## DEBUG: Use next line for image debug (use additional layers to speed up debugging process by using docker cache). See "RELEASE" comments above `
COPY /InternalAssets/xconnect-createcert.json ${INSTALL_PATH}/ `
#> `
`
<#RUN #> `
`
<# Install xConnect Certificate (required by WebDeploy package): .................................................... #> `
	`
	Write-Host 'Start: Install xConnect Certificate.' ; `
	`
	$sifConfigPath = Join-Path $env:INSTALL_PATH 'xconnect-createcert.json'; `
	`
	Install-SitecoreConfiguration $sifConfigPath `
		-CertificateName $env:XCONNECT_CERTIFICATE_NAME `
		-CertPath $env:INSTALL_PATH ; `
	`
	Write-Host 'End: Install xConnect Certificate.' ; `
`
<## DEBUG: Use next line for image debug (use additional layers to speed up debugging process by using docker cache). See "RELEASE" comments above `
COPY [ `
	"/ExternalAssets/License.xml", `
	"/ExternalAssets/xconnect-xp0-docker.json", `
	"/ExternalAssets/Sitecore 9.0.1 rev. 171219 (OnPrem)_xp0xconnect.scwdp.zip", `
	"${INSTALL_PATH}/" `
	] `
#> `
`
<#RUN #> `
`
<# Install xConnect:.......................................... #> `
	`
	Write-Host 'Start: Install xConnect' ; `
	`
	$sifConfigPath = Join-Path $env:INSTALL_PATH 'xconnect-xp0-docker.json'; `
	$sifPackagePath = Join-Path $env:INSTALL_PATH 'Sitecore 9.0.1 rev. 171219 (OnPrem)_xp0xconnect.scwdp.zip' ; `
	$licenseFilePath = Join-Path $env:INSTALL_PATH 'license.xml' ; `
	`
	Install-SitecoreConfiguration $sifConfigPath  `
		-Package $sifPackagePath `
		-LicenseFile $licenseFilePath `
		-SiteName $env:XCONNECT_SITE_NAME `
		-XConnectCert $env:XCONNECT_CERTIFICATE_NAME `
		-SqlDbPrefix $env:SITE_PREFIX `  
		-SolrCorePrefix $env:SITE_PREFIX `
		-SqlAdminUser 'sa' `
		-SqlAdminPassword $env:sa_password `
		-SqlServer '.' `
		-SolrUrl $env:SOLR_URL `
		-SqlCollectionUser $env:XCONNECT_SQL_COLLECTION_USER `
		-SqlCollectionPassword $env:XCONNECT_SQL_COLLECTION_PASSWORD `
		-SqlProcessingPoolsUser "sa" `
		-SqlProcessingPoolsPassword $env:sa_password `
		-SqlReferenceDataUser "sa" `
		-SqlReferenceDataPassword $env:sa_password `
		-SqlMarketingAutomationUser "sa" `
		-SqlMarketingAutomationPassword $env:sa_password `
		-SqlMessagingUser "sa" `
		-SqlMessagingPassword $env:sa_password `
		-WebRoot $env:SITE_WEB_ROOT ; `
	`
	Write-Host 'End: Install xConnect' ; `
	`
	Write-Host 'Start: Configuring AppPool for xConnect' ; `
	Set-ItemProperty ('IIS:\AppPools\{0}' -f $env:XCONNECT_SITE_NAME) -Name autoStart  -value $true; `
	Set-ItemProperty ('IIS:\AppPools\{0}' -f $env:XCONNECT_SITE_NAME) -Name startMode -value 'AlwaysRunning'; `
	Set-ItemProperty ('IIS:\AppPools\{0}' -f $env:XCONNECT_SITE_NAME) -Name processModel.idleTimeout -value ([TimeSpan]::FromMinutes(0)); `
	Set-ItemProperty ('IIS:\AppPools\{0}' -f $env:XCONNECT_SITE_NAME) -Name processModel.shutdownTimeLimit -value ([TimeSpan]::FromMinutes(5)); `
	Set-ItemProperty ('IIS:\AppPools\{0}' -f $env:XCONNECT_SITE_NAME) -Name processModel.startupTimeLimit -value ([TimeSpan]::FromMinutes(5)); `
	Set-ItemProperty ('IIS:\AppPools\{0}' -f $env:XCONNECT_SITE_NAME) -Name processModel.pingingEnabled -value $false; `
	Write-Host 'End: Configuring AppPool for xConnect' ; `
	`
	Write-Host 'Start: Set permissions for xConnect' ; `
	Add-LocalGroupMember -Group 'Performance Log Users' -Member ('IIS APPPOOL\{0}' -f $env:XCONNECT_SITE_NAME) ; `
	Add-LocalGroupMember -Group 'Performance Monitor Users' -Member ('IIS APPPOOL\{0}' -f $env:XCONNECT_SITE_NAME) ; `
	Write-Host 'End: Set permissions for xConnect' ; `
	`
`
<## DEBUG: Use next line for image debug (use additional layers to speed up debugging process by using docker cache). See "RELEASE" comments above `
COPY ["/InternalAssets/collectionusergrant.sql", "${INSTALL_PATH}/"] `
#> `
`
<#RUN #> `
`
<# Set rights on the xDB connection database #> `
	`
	Write-Host 'Start: Set rights on the xDB connection database' ; `
	`
	$scriptPath = Join-Path $env:INSTALL_PATH 'collectionusergrant.sql'; `
	$sqlVariables = @(('DatabasePrefix={0}' -f $env:SITE_PREFIX), ('UserName={0}' -f $env:XCONNECT_SQL_COLLECTION_USER), ('Password={0}' -f $env:XCONNECT_SQL_COLLECTION_PASSWORD)) ; `
	Invoke-Sqlcmd `
		-InputFile $scriptPath `
		-Username sa `
		-Password $env:sa_password `
		-Variable $sqlVariables ; `
	`
	Write-Host 'End: Set rights on the xDB connection database' ; `
`
;

RUN `
`
<####################################################################################################################### `
`
	Sitecore `
`
------------------------------------------------------------------------------------------------------------------------#> `
`
<## DEBUG: Use next line for image debug (use additional layers to speed up debugging process by using docker cache). See "RELEASE" comments above `
COPY ["/InternalAssets/sitecore-solr.json", "${INSTALL_PATH}/"] `
#> `
`
<#RUN #> `
`
<# Install Sitecore Solr Cores: ..................................................................................................... #> `
	`
	Write-Host 'Start: Install Sitecore Solr Cores' ; `
	`
	$sifConfigPath = Join-Path $env:INSTALL_PATH 'sitecore-solr.json' ; `
	`
	Install-SitecoreConfiguration $sifConfigPath `
		-SolrUrl $env:SOLR_URL `
		-SolrRoot $env:SOLR_ROOT `
		-SolrService $env:SOLR_SERVICE_NAME `
		-CorePrefix $env:SITE_PREFIX ; `
	`
	Write-Host 'End: Install Sitecore Solr Cores' ; `
;

#<## DEBUG: Use next line for image debug (use additional layers to speed up debugging process by using docker cache). See "RELEASE" comments above `
#COPY ["/ExternalAssets/sitecore-xp0-docker.json", "/ExternalAssets/Sitecore 9.0.1 rev. 171219 (OnPrem)_single.scwdp.zip", "${INSTALL_PATH}/"] `
#> `

RUN `
`
<# Install Sitecore:.......................................... #> `
	`
	Write-Host 'Start: Install Sitecore' ; `
	`
	$sifConfigPath = Join-Path $env:INSTALL_PATH 'sitecore-xp0-docker.json'; `
	$sifPackagePath = Join-Path $env:INSTALL_PATH 'Sitecore 9.0.1 rev. 171219 (OnPrem)_single.scwdp.zip' ; `
	$licenseFilePath = Join-Path $env:INSTALL_PATH 'license.xml' ; `
	`
	Install-SitecoreConfiguration $sifConfigPath  `
		-Package $sifPackagePath `
		-LicenseFile $licenseFilePath `
		-SiteName $env:SITE_HOST_NAME `
		-XConnectCert $env:XCONNECT_CERTIFICATE_NAME `
		-SqlDbPrefix $env:SITE_PREFIX `  
		-SolrCorePrefix $env:SITE_PREFIX `
		-SqlAdminUser 'sa' `
		-SqlAdminPassword $env:sa_password `
		-SqlServer "." `
		-SqlCoreUser 'sa' `
		-SqlCorePassword $env:sa_password `
		-SqlMasterUser 'sa' `
		-SqlMasterPassword $env:sa_password `
		-SqlWebUser 'sa' `
		-SqlWebPassword $env:sa_password `
		-SqlReportingUser 'sa' `
		-SqlReportingPassword $env:sa_password `
		-SqlReferenceDataUser 'sa' `
		-SqlReferenceDataPassword $env:sa_password `
		-SqlFormsUser 'sa' `
		-SqlFormsPassword $env:sa_password `
		-SqlExmMasterUser 'sa' `
		-SqlExmMasterPassword $env:sa_password `
		-SqlMessagingUser 'sa' `
		-SqlMessagingPassword $env:sa_password `
		-SqlMarketingAutomationUser 'sa' `
		-SqlMarketingAutomationPassword $env:sa_password `
		-SqlProcessingPoolsUser 'sa' `
		-SqlProcessingPoolsPassword $env:sa_password `
		-SqlProcessingTasksUser 'sa' `
		-SqlProcessingTasksPassword $env:sa_password `
		-SolrUrl $env:SOLR_URL `
		-XConnectCollectionService ('https://{0}' -f $env:XCONNECT_SITE_NAME) `
		-XConnectReferenceDataService ('https://{0}' -f $env:XCONNECT_SITE_NAME) `
		-MarketingAutomationOperationsService ('https://{0}' -f $env:XCONNECT_SITE_NAME) `
		-MarketingAutomationReportingService ('https://{0}' -f $env:XCONNECT_SITE_NAME) `
		-WebRoot $env:SITE_WEB_ROOT ; `
	`
	Write-Host 'End: Install Sitecore' ; `
	`
	Write-Host 'Start: Configuring AppPool for xConnect' ; `
	Set-ItemProperty ('IIS:\AppPools\{0}' -f $env:SITE_HOST_NAME) -Name autoStart  -value $true; `
	Set-ItemProperty ('IIS:\AppPools\{0}' -f $env:SITE_HOST_NAME) -Name startMode -value 'AlwaysRunning'; `
	Set-ItemProperty ('IIS:\AppPools\{0}' -f $env:SITE_HOST_NAME) -Name processModel.idleTimeout -value ([TimeSpan]::FromMinutes(0)); `
	Set-ItemProperty ('IIS:\AppPools\{0}' -f $env:SITE_HOST_NAME) -Name processModel.shutdownTimeLimit -value ([TimeSpan]::FromMinutes(5)); `
	Set-ItemProperty ('IIS:\AppPools\{0}' -f $env:SITE_HOST_NAME) -Name processModel.startupTimeLimit -value ([TimeSpan]::FromMinutes(5)); `
	Set-ItemProperty ('IIS:\AppPools\{0}' -f $env:SITE_HOST_NAME) -Name processModel.pingingEnabled -value $false; `
	Write-Host 'End: Configuring AppPool for xConnect' ; `
	`
	Write-Host 'Start: Set permissions for Sitecore' ; `
	Add-LocalGroupMember -Group 'Performance Log Users' -Member ('IIS APPPOOL\{0}' -f $env:SITE_HOST_NAME) ; `
	Add-LocalGroupMember -Group 'Performance Monitor Users' -Member ('IIS APPPOOL\{0}' -f $env:SITE_HOST_NAME) ; `
	Write-Host 'End: Set permissions for Sitecore' ; `
	`
	Write-Host 'Start: Update web.config for Sitecore' ; `
	$siteFolder = $env:SITECORE_SITE_ROOT ; `
	$webConfigPath = Join-Path $siteFolder 'web.config' ; `
	$webConfigXML = New-Object XML ; `
	$webConfigXML.Load($webConfigPath) ; `
	$customErrorsNode = $webConfigXML.SelectSingleNode('/configuration/system.web/customErrors') ; `
	$customErrorsNode.SetAttribute('mode', $env:SITE_ERROR_MODE) ; `
	$webConfigXML.Save($webConfigPath) ; `
	Write-Host 'End: Update web.config for Sitecore' ; `
`
<## DEBUG: Use next line for image debug (use additional layers to speed up debugging process by using docker cache). See "RELEASE" comments above `
COPY ["/InternalAssets/sitecore-ssl.json", "${INSTALL_PATH}/"] `
#> `
`
<#RUN #> `
`
<# Set web certificate on Sitecore site: .................................................... #> `
	`
	Write-Host 'Start: Set web certificate on Sitecore site' ; `
	`
	$sifConfigPath = Join-Path $env:INSTALL_PATH 'sitecore-ssl.json'; `
	`
	Install-SitecoreConfiguration $sifConfigPath `
		-SiteName $env:SITE_HOST_NAME `
		-WebRoot $env:SITE_WEB_ROOT ; `
	`
	Write-Host 'End: Set web certificate on Sitecore site' ; `
;

#<####################################################################################################################### `
#`
#	Add Additional Bindings `
#`
#------------------------------------------------------------------------------------------------------------------------#> `

#<## DEBUG: Use next line for image debug (use additional layers to speed up debugging process by using docker cache). See "RELEASE" comments above `
#COPY ["/InternalAssets/habitathome-xp0.json", "${INSTALL_PATH}/"] `
#> `

RUN `
`
<# Add Additional Bindings: .................................................... #> `
	`
	Write-Host 'Start: Add Additional Bindings: Step 1' ; `
	`
	$sifConfigPath = Join-Path $env:INSTALL_PATH 'xconnect-createcert.json'; `
	`
	Install-SitecoreConfiguration $sifConfigPath `
		-CertificateName $env:SITE_HABITAT_HOME_SSL_CERTIFICATE_NAME `
		-CertPath $env:INSTALL_PATH ; `
	`
	Write-Host 'End: Add Additional Bindings: Step 1' ; `
	`
	Write-Host 'Start: Add Additional Bindings: Step 2' ; `
	`
	$sifConfigPath = Join-Path $env:INSTALL_PATH 'habitathome-xp0.json'; `
	`
	Install-SitecoreConfiguration $sifConfigPath `
		-SSLCert $env:SITE_HABITAT_HOME_SSL_CERTIFICATE_NAME `
		-SiteName $env:SITE_HOST_NAME `
		-HostHeader $env:SITE_HABITAT_HOME_HOST_NAME ; `
	`
	Write-Host 'End: Add Additional Bindings: Step 2' ; `
`
`
<####################################################################################################################### `
`
	Cleanup `
`
------------------------------------------------------------------------------------------------------------------------#> `
`
<#RUN #> `
`
<# Cleanup, post installation tweaks and start site:.......................................... #> `
	`
	Write-Host 'Start: Cleanup, post installation tweaks and start site' ; `
	`
	<# Save Boot.ps1 before deleting the installation folder #> `
	if (Test-Path -Path (Join-Path $env:INSTALL_PATH Boot.ps1) -PathType Leaf) {Move-Item -Path (Join-Path $env:INSTALL_PATH Boot.ps1) -Destination / } ; `
	`
	Remove-Item -Path 'C:\*.log'; `
	Remove-Item -Path $env:INSTALL_PATH -Force -Recurse; `
	`
	Write-Host 'End: Cleanup, post installation tweaks and start site' ; `
;	

#BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB
#
#	Docker Image Metadata
#
#--------------------------------------------------------------------------------------------------------------------------

