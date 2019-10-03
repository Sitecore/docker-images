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
	
CMD tail -f /dev/nullcd 