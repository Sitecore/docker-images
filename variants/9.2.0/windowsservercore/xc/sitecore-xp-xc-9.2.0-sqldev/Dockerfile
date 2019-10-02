# escape=`
ARG BASE_IMAGE

FROM $BASE_IMAGE as final

# Extract artifacts
ARG INSTALL_TEMP='c:\\install'
COPY . ${INSTALL_TEMP}
COPY *.ps1 ${INSTALL_PATH}

# Extract and install dacpac's
RUN Expand-Archive -Path (Join-Path $env:INSTALL_TEMP '*.zip') -DestinationPath $env:INSTALL_TEMP; `
	$env:DB_PREFIX='xc'; `
    Expand-Archive -Path (Join-Path $env:INSTALL_TEMP 'Sitecore.Commerce.Engine.OnPrem.Solr*scwdp.zip') -DestinationPath (Join-Path $env:INSTALL_TEMP 'CommerceEngineWdp'); `
	& (Join-Path $env:INSTALL_PATH "\\Install-Databases.ps1") -InstallPath $env:INSTALL_PATH -DataPath $env:DATA_PATH -DatabasePrefix $env:DB_PREFIX; `
	Get-ChildItem -Path $env:INSTALL_PATH -Exclude '*.mdf', '*.ldf', '*.zip', '*.ps1' -Recurse -Force | Remove-Item -Recurse -Force; `
	$env:DB_PREFIX='sc';
#	Expand-Archive -Path (Join-Path $env:INSTALL_TEMP 'Sitecore Commerce Connect Core*.scwdp.zip') -DestinationPath (Join-Path $env:INSTALL_TEMP 'CommerceConnectWdp'); `
#	Expand-Archive -Path (Join-Path $env:INSTALL_TEMP 'Sitecore Commerce ExperienceProfile Core*.scwdp.zip') -DestinationPath (Join-Path $env:INSTALL_TEMP 'CommercexProfilesWdp'); `
#	Expand-Archive -Path (Join-Path $env:INSTALL_TEMP 'Sitecore Commerce ExperienceAnalytics Core*.scwdp.zip') -DestinationPath (Join-Path $env:INSTALL_TEMP 'CommercexAnalyticsWdp'); `
#	Expand-Archive -Path (Join-Path $env:INSTALL_TEMP 'Sitecore Commerce Marketing Automation Core*.scwdp.zip') -DestinationPath (Join-Path $env:INSTALL_TEMP 'CommerceMAWdp'); `
#	Expand-Archive -Path (Join-Path $env:INSTALL_TEMP 'Sitecore Commerce Engine Connect*.scwdp.zip') -DestinationPath (Join-Path $env:INSTALL_TEMP 'CEConnectWdp'); `
#	& (Join-Path $env:INSTALL_PATH "\\Install-Databases.ps1") -InstallPath $env:INSTALL_PATH -DataPath $env:DATA_PATH -DatabasePrefix $env:DB_PREFIX; `
#	Get-ChildItem -Path $env:INSTALL_PATH -Exclude '*.mdf', '*.ldf' -Recurse -Force | Remove-Item -Recurse -Force;