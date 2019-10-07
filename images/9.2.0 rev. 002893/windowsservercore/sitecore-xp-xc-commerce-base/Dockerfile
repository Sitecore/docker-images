# escape=`
ARG BASE_IMAGE

FROM $BASE_IMAGE

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