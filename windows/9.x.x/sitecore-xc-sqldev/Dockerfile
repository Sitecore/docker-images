# escape=`
ARG BASE_IMAGE
ARG ASSETS_IMAGE

FROM $ASSETS_IMAGE as assets
FROM $BASE_IMAGE

ARG ASSETS_USE_WDP_XCONNECT
ARG ASSETS_USE_WDP_COMMERCE_ENGINE
ARG ASSETS_USE_WDP_CONNECT_CORE
ARG ASSETS_USE_WDP_CONNECT_ENGINE
ARG ASSETS_USE_WDP_MA
ARG ASSETS_USE_WDP_XPROFILES
ARG ASSETS_USE_WDP_XANALYTICS

ENV ACCEPT_EULA='Y' `
    sa_password='HASH-epsom-sunset-cost7!' `
    INSTALL_PATH='C:\\install\\' `
    DATA_PATH='C:\\data\\' `
    SQL_HOSTNAME='sql' `
    SQL_DB_PREFIX='Sitecore.' `
    COMMERCE_DB_PREFIX='SitecoreCommerce9_'

ENV CREATE_ROLES='sitecore\Commerce Administrator,sitecore\Commerce Business User,sitecore\Customer Service Representative,sitecore\Customer Service Representative Administrator,sitecore\Merchandiser,sitecore\Pricer,sitecore\Pricer Manager,sitecore\Promotioner,sitecore\Promotioner Manager,sitecore\Relationship Administrator,sitecore\QA' `
    ADD_ROLES_TO_USER_USER_NAMES='sitecore\Admin' `
    ADD_ROLES_TO_USER_ROLE_NAMES='sitecore\Commerce Administrator' `
    ADD_ROLE_TO_ROLE_MEMBER_ROLE_NAMES='sitecore\Customer Service Representative,sitecore\Relationship Administrator,sitecore\Pricer,sitecore\Promotioner,sitecore\Merchandiser,sitecore\Pricer Manager,sitecore\Promotioner Manager,sitecore\Customer Service Representative Administrator,sitecore\Commerce Administrator,sitecore\Commerce Administrator,sitecore\Commerce Administrator,sitecore\Commerce Administrator' `
    ADD_ROLE_TO_ROLE_TARGET_ROLE_NAMES='sitecore\Commerce Business User,sitecore\Commerce Business User,sitecore\Commerce Business User,sitecore\Commerce Business User,sitecore\Relationship Administrator,sitecore\Pricer,sitecore\Promotioner,sitecore\Customer Service Representative,sitecore\Customer Service Representative Administrator,sitecore\Pricer Manager,sitecore\Promotioner Manager,sitecore\Merchandiser'

COPY --from=assets ["${ASSETS_USE_WDP_XCONNECT}", "${INSTALL_PATH}"]
COPY --from=assets ["${ASSETS_USE_WDP_COMMERCE_ENGINE}", "${INSTALL_PATH}"]
COPY --from=assets ["${ASSETS_USE_WDP_CONNECT_CORE}", "${INSTALL_PATH}"]
COPY --from=assets ["${ASSETS_USE_WDP_CONNECT_ENGINE}", "${INSTALL_PATH}"]
COPY --from=assets ["${ASSETS_USE_WDP_MA}", "${INSTALL_PATH}"]
COPY --from=assets ["${ASSETS_USE_WDP_XPROFILES}", "${INSTALL_PATH}"]
COPY --from=assets ["${ASSETS_USE_WDP_XANALYTICS}", "${INSTALL_PATH}"]

COPY . ${INSTALL_PATH}

RUN & (Join-Path $env:INSTALL_PATH "Attach-Databases.ps1"); ` 
    # Install databases from WDP packages
    & (Join-Path $env:INSTALL_PATH "Extract-Databases.ps1") -Path $env:INSTALL_PATH; `
    & (Join-Path $env:INSTALL_PATH "Install-Databases.ps1") -InstallPath $env:INSTALL_PATH -DataPath $env:DATA_PATH -DatabasePrefix $Env:SQL_DB_PREFIX -CommerceDatabasePrefix $Env:COMMERCE_DB_PREFIX; `    
    # Add Commerce Users and Roles
    & (Join-Path $env:INSTALL_PATH "Users-And-Roles.ps1") -SqlHostname $env:COMPUTERNAME -SqlDatabasePrefix $env:SQL_DB_PREFIX `
        -CreateRoles $env:CREATE_ROLES -AddRolesToUserUserNames $env:ADD_ROLES_TO_USER_USER_NAMES `
        -AddRolesToUserRoleNames $env:ADD_ROLES_TO_USER_ROLE_NAMES -AddRoleToRoleMemberRoleNames $env:ADD_ROLE_TO_ROLE_MEMBER_ROLE_NAMES `
        -AddRoleToRoleTargetRoleNames $env:ADD_ROLE_TO_ROLE_TARGET_ROLE_NAMES; `
    # Rebuild Descendants task
    $env:MasterDatase = '{0}Master' -f $Env:SQL_DB_PREFIX; `
    Invoke-Sqlcmd -Database $Env:MasterDatase -InputFile (Join-Path $env:INSTALL_PATH "RebuildDescendants.sql"); `
    & (Join-Path $env:INSTALL_PATH "Detach-Databases.ps1"); `    
    Get-ChildItem -Path $env:INSTALL_PATH -Exclude "*.mdf", "*.ldf" | Remove-Item -Force -Recurse;
