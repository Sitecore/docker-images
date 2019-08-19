# escape=`
ARG BASE_IMAGE

FROM $BASE_IMAGE as builder

ARG WDP_GLOB

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

COPY . /install/

# Prepare WDP package
RUN Rename-Item -Path (Resolve-Path (Join-Path 'C:\\install' $env:WDP_GLOB)).Path -NewName 'jss.zip' -Verbose;

FROM $BASE_IMAGE

# BUG: Target path needs to exist when building with Docker Engine 19.03.1, see https://github.com/docker/for-win/issues/4349. Should be removed when fixed.
RUN MKDIR C:\install
COPY --from=builder [ "/install/jss.zip", "/install/install-package.json", "/install/" ]

# Install WDP, apply tweaks and cleanup
RUN $env:SITENAME = 'sc'; `
    $env:INSTALL_TEMP = 'C:\\install'; `
    Install-SitecoreConfiguration -Path (Join-Path $env:INSTALL_TEMP '\\install-package.json') -Package (Join-Path $env:INSTALL_TEMP '\\jss.zip') -Sitename $env:SITENAME; `
    Remove-Item -Path $env:INSTALL_TEMP -Force -Recurse; 

# ServiceMonitor needs to point to the Application Pool that Sitecore runs in instead of the default one, to support environment variables
ENTRYPOINT ["C:\\ServiceMonitor.exe", "w3svc", "sc"]