# escape=`
ARG BASE_IMAGE

FROM $BASE_IMAGE as final

ENV CREATE_ROLES='sitecore\Commerce Administrator,sitecore\Commerce Business User,sitecore\Customer Service Representative,sitecore\Customer Service Representative Administrator,sitecore\Merchandiser,sitecore\Pricer,sitecore\Pricer Manager,sitecore\Promotioner,sitecore\Promotioner Manager,sitecore\Relationship Administrator,sitecore\QA' `
    ADD_ROLES_TO_USER_USER_NAMES='sitecore\Admin' `
    ADD_ROLES_TO_USER_ROLE_NAMES='sitecore\Commerce Administrator' `
    ADD_ROLE_TO_ROLE_MEMBER_ROLE_NAMES='sitecore\Customer Service Representative,sitecore\Relationship Administrator,sitecore\Pricer,sitecore\Promotioner,sitecore\Merchandiser,sitecore\Pricer Manager,sitecore\Promotioner Manager,sitecore\Customer Service Representative Administrator,sitecore\Commerce Administrator,sitecore\Commerce Administrator,sitecore\Commerce Administrator,sitecore\Commerce Administrator' `
    ADD_ROLE_TO_ROLE_TARGET_ROLE_NAMES='sitecore\Commerce Business User,sitecore\Commerce Business User,sitecore\Commerce Business User,sitecore\Commerce Business User,sitecore\Relationship Administrator,sitecore\Pricer,sitecore\Promotioner,sitecore\Customer Service Representative,sitecore\Customer Service Representative Administrator,sitecore\Pricer Manager,sitecore\Promotioner Manager,sitecore\Merchandiser' `
	XC_DB_PREFIX='xc'

# Extract artifacts
ARG INSTALL_TEMP='c:\\install'
COPY . ${INSTALL_TEMP}
COPY *.ps1 ${INSTALL_PATH}

# Extract and install dacpac's
RUN	Expand-Archive -Path (Join-Path $env:INSTALL_TEMP '*.zip') -DestinationPath $env:INSTALL_TEMP; `
	& (Join-Path $env:INSTALL_PATH "\\Attach-Databases.ps1") -InstallPath $env:INSTALL_PATH -DataPath $env:DATA_PATH; `
	Expand-Archive -Path (Join-Path $env:INSTALL_TEMP 'Sitecore.Commerce.Engine.OnPrem.Solr*scwdp.zip') -DestinationPath (Join-Path $env:INSTALL_TEMP 'CommerceEngineWdp'); `
	& (Join-Path $env:INSTALL_PATH "\\Install-Databases.ps1") -InstallPath $env:INSTALL_PATH -DataPath $env:DATA_PATH -DatabasePrefix $env:XC_DB_PREFIX; `
	Get-ChildItem -Path $env:INSTALL_PATH -Exclude '*.mdf', '*.ldf', '*.zip', '*.ps1' -Recurse -Force | Remove-Item -Recurse -Force; `
	Expand-Archive -Path (Join-Path $env:INSTALL_TEMP 'Sitecore Commerce Connect Core*.scwdp.zip') -DestinationPath (Join-Path $env:INSTALL_TEMP 'CommerceConnectWdp'); `
	Expand-Archive -Path (Join-Path $env:INSTALL_TEMP 'Sitecore Commerce ExperienceProfile Core*.scwdp.zip') -DestinationPath (Join-Path $env:INSTALL_TEMP 'CommercexProfilesWdp'); `
	Expand-Archive -Path (Join-Path $env:INSTALL_TEMP 'Sitecore Commerce ExperienceAnalytics Core*.scwdp.zip') -DestinationPath (Join-Path $env:INSTALL_TEMP 'CommercexAnalyticsWdp'); `
	Expand-Archive -Path (Join-Path $env:INSTALL_TEMP 'Sitecore Commerce Marketing Automation Core*.scwdp.zip') -DestinationPath (Join-Path $env:INSTALL_TEMP 'CommerceMAWdp'); `
	Expand-Archive -Path (Join-Path $env:INSTALL_TEMP 'Sitecore Commerce Engine Connect*.scwdp.zip') -DestinationPath (Join-Path $env:INSTALL_TEMP 'CEConnectWdp'); `
	& (Join-Path $env:INSTALL_PATH "\\Install-Databases.ps1") -InstallPath $env:INSTALL_PATH -DataPath $env:DATA_PATH -DatabasePrefix $env:DB_PREFIX; `
	& (Join-Path $env:INSTALL_PATH "\\Users-And-Roles.ps1") -SqlHostname $env:COMPUTERNAME -SqlDatabasePrefix $env:DB_PREFIX -CreateRoles $env:CREATE_ROLES -AddRolesToUserUserNames $env:ADD_ROLES_TO_USER_USER_NAMES -AddRolesToUserRoleNames $env:ADD_ROLES_TO_USER_ROLE_NAMES -AddRoleToRoleMemberRoleNames $env:ADD_ROLE_TO_ROLE_MEMBER_ROLE_NAMES -AddRoleToRoleTargetRoleNames $env:ADD_ROLE_TO_ROLE_TARGET_ROLE_NAMES; `
	& (Join-Path $env:INSTALL_PATH "\\Detach-Databases.ps1") -InstallPath $env:INSTALL_PATH -DataPath $env:DATA_PATH; `
	Copy-Item -Path (Join-Path $env:INSTALL_PATH "\\Boot.ps1") -Destination 'C:\\'; `
	Get-ChildItem -Path $env:INSTALL_PATH -Exclude '*.mdf', '*.ldf' -Recurse -Force | Remove-Item -Recurse -Force;
	
CMD C:/Boot.ps1 -InstallPath $env:INSTALL_PATH -DataPath $env:DATA_PATH -SqlHostname $env:SQL_HOSTNAME -DatabasePrefix $env:DB_PREFIX -CommerceDatabasePrefix $env:XC_DB_PREFIX;