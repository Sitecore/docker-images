# escape=`
ARG BASE_IMAGE

FROM $BASE_IMAGE as builder

ARG WDP_GLOB

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ENV NODE_VERSION 10.16.3

RUN Invoke-WebRequest $('https://nodejs.org/dist/v{0}/node-v{0}-win-x64.zip' -f $env:NODE_VERSION) -OutFile 'node.zip' -UseBasicParsing ; `
    Expand-Archive node.zip -DestinationPath C:\ ; `
    Rename-Item -Path $('C:\\node-v{0}-win-x64' -f $env:NODE_VERSION) -NewName 'C:\\nodejs'

COPY . /install/

# Prepare WDP package
RUN Rename-Item -Path (Resolve-Path (Join-Path 'C:\\install' $env:WDP_GLOB)).Path -NewName 'jss.zip' -Verbose;

FROM $BASE_IMAGE

# BUG: Target path needs to exist when building with Docker Engine 19.03.1, see https://github.com/docker/for-win/issues/4349. Should be removed when fixed.
RUN MKDIR C:\install
COPY --from=builder [ "/install/jss.zip", "/install/install-package.json", "/install/" ]

ENV NPM_CONFIG_LOGLEVEL info

# Install node
COPY --from=builder ["/nodejs", "/nodejs"]

# Install Sitecore, apply tweaks and cleanup
RUN $env:SITENAME = 'sc'; `
    $env:INSTALL_TEMP = 'C:\\install'; `
    Install-SitecoreConfiguration -Path (Join-Path $env:INSTALL_TEMP '\\install-package.json') -Package (Join-Path $env:INSTALL_TEMP '\\jss.zip') -Sitename $env:SITENAME; `
    Remove-Item -Path $env:INSTALL_TEMP -Force -Recurse; 

# Add node path
RUN $env:PATH = 'C:\nodejs;{0}' -f $env:PATH ; `
    [Environment]::SetEnvironmentVariable('PATH', $env:PATH, [EnvironmentVariableTarget]::Machine)

# ServiceMonitor needs to point to the Application Pool that Sitecore runs in instead of the default one, to support environment variables
ENTRYPOINT ["C:\\ServiceMonitor.exe", "w3svc", "sc"]