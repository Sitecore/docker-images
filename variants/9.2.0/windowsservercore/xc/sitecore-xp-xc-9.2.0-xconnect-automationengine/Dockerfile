# escape=`
ARG BASE_IMAGE
ARG BUILD_IMAGE

FROM $BUILD_IMAGE as builder

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

COPY . /install/

# Expand zips, prepare SIF config and WDP package
RUN $env:INSTALL_TEMP = 'C:\\install'; `
	$env:SITENAME = 'AutomationEngine'; `
	$env:MODELS_FOLDER = (Join-Path $env:INSTALL_TEMP 'Models'); `
	$env:MODELS_FOLDER = (Join-Path $env:MODELS_FOLDER $env:SITENAME); `
    Expand-Archive -Path (Join-Path $env:INSTALL_TEMP '*.zip') -DestinationPath $env:INSTALL_TEMP; `
    Expand-Archive -Path (Join-Path $env:INSTALL_TEMP 'Sitecore Commerce Connect Core*.scwdp.zip') -DestinationPath $env:INSTALL_TEMP; `
	Expand-Archive -Path (Join-Path $env:INSTALL_TEMP 'Sitecore Commerce Marketing Automation for AutomationEngine*.zip') -DestinationPath (Join-Path $env:INSTALL_TEMP 'CommerceMAForAutomationEngine'); `
	New-Item -ItemType Container -Path (Join-Path $env:MODELS_FOLDER '\\App_Data\\Models') -Force; `
	Copy-Item -Path (Join-Path $env:INSTALL_TEMP "\\Content\\Website\\XConnectModels\\*") -Destination (Join-Path $env:MODELS_FOLDER '\\App_Data\\Models\\') -Force; `
	Copy-Item -Path (Join-Path $env:INSTALL_TEMP "\\CommerceMAForAutomationEngine\\*") -Destination $env:MODELS_FOLDER -Recurse -Force;

FROM $BASE_IMAGE

# BUG: Target path needs to exist when building with Docker Engine 19.03.1, see https://github.com/docker/for-win/issues/4349. Should be removed when fixed.
RUN	MKDIR C:\install;
	
COPY --from=builder install/Models/ C:\\

EXPOSE 443