# escape=`
ARG BUILD_IMAGE
ARG BASE_IMAGE

FROM $BUILD_IMAGE as builder

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

COPY . /install/

# Expand zips, prepare SIF config and WDP package
RUN $env:SIF_PACKAGE_PSE = 'Sitecore PowerShell Extensions-5.0.scwdp.zip'; `
     $env:SITENAME = 'sc'; `
     $env:INSTALL_TEMP = 'C:\\install'; ` 
     Rename-Item -Path (Resolve-Path (Join-Path $env:INSTALL_TEMP $env:SIF_PACKAGE_PSE)).Path -NewName 'spe.zip';

FROM $BASE_IMAGE

# BUG: Target path needs to exist when building with Docker Engine 19.03.1, see https://github.com/docker/for-win/issues/4349. Should be removed when fixed.
RUN MKDIR C:\install
COPY --from=builder ["/install/install-package.json", "/install/spe.zip", "/install/" ]

# Install Sitecore, apply tweaks and cleanup
RUN $env:SITENAME = 'sc'; `
     $env:INSTALL_TEMP = 'C:\\install'; `
     Install-SitecoreConfiguration -Path (Join-Path $env:INSTALL_TEMP '\\install-package.json') -Package (Join-Path $env:INSTALL_TEMP '\\spe.zip') `
     -Sitename $env:SITENAME ; `
     Remove-Item -Path $env:INSTALL_TEMP -Force -Recurse; 


# ServiceMonitor needs to point to the Application Pool that Sitecore runs in instead of the default one, to support environment variables
ENTRYPOINT ["C:\\ServiceMonitor.exe", "w3svc", "sc"]