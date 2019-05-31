# escape=`
ARG BUILD_IMAGE
ARG BASE_IMAGE

FROM $BUILD_IMAGE as builder

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

COPY . /install/

# Expand zips, prepare SIF config and WDP package
RUN $env:SIF_PACKAGE_SXA = 'Sitecore Experience Accelerator 1.8.1 rev. 190319 for 9.1.1.scwdp.zip'; `
    $env:SITENAME = 'sc'; `
    $env:INSTALL_TEMP = 'C:\\install'; `
    Rename-Item -Path (Resolve-Path (Join-Path $env:INSTALL_TEMP $env:SIF_PACKAGE_SXA)).Path -NewName 'sxa.zip';

# # Runtime
FROM $BASE_IMAGE as final

COPY --from=builder [ "/install/sxa.zip", "/install/install-package.json", "/install/" ]

# Install Sitecore, apply tweaks and cleanup
RUN $env:SITENAME = 'sc'; `
    $env:INSTALL_TEMP = 'C:\\install'; `
    Install-SitecoreConfiguration -Path (Join-Path $env:INSTALL_TEMP '\\install-package.json') -Package (Join-Path $env:INSTALL_TEMP '\\sxa.zip') `
    -Sitename $env:SITENAME ; `
    Remove-Item -Path $env:INSTALL_TEMP -Force -Recurse; 


# ServiceMonitor needs to point to the Application Pool that Sitecore runs in instead of the default one, to support environment variables
ENTRYPOINT ["C:\\ServiceMonitor.exe", "w3svc", "sc"]