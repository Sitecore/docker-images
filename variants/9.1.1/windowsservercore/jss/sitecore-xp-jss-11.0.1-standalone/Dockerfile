# escape=`
ARG BUILD_IMAGE
ARG BASE_IMAGE

FROM $BUILD_IMAGE as builder

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ENV GPG_VERSION 2.3.4

# RUN Invoke-WebRequest $('https://files.gpg4win.org/gpg4win-vanilla-{0}.exe' -f $env:GPG_VERSION) -OutFile 'gpg4win.exe' -UseBasicParsing ; `
#     Start-Process .\gpg4win.exe -ArgumentList '/S' -NoNewWindow -Wait

# RUN @( `
#     '94AE36675C464D64BAFA68DD7434390BDBE9B9C5', `
#     'FD3A5288F042B6850C66B31F09FE44734EB7990E', `
#     '71DCFD284A79C3B38668286BC97EC7A07EDE3FC1', `
#     'DD8F2338BAE7501E3DD5AC78C273792F7D83545D', `
#     'C4F0DFFF4E8C1A8236409D08E73BC641CC11F4C8', `
#     'B9AE9905FFD7803F25714661B63B535A4C206CA9', `
#     '77984A986EBC2AA786BC0F66B01FBB92821C587A', `
#     '8FCCA13FEF1D0C2E91008E09770F7A9A5AE15600', `
#     '4ED778F539E3634C779C87C6D7062848A1AB005C', `
#     'A48C2BEE680E841632CD4E44F07496B3EB3C1762', `
#     'B9E2F5981AA6E0CD28160D9FF13993A75599653C' `
#     ) | foreach { `
#       gpg --keyserver ha.pool.sks-keyservers.net --recv-keys $_ ; `
#     }

ENV NODE_VERSION 10.15.3

# RUN Invoke-WebRequest $('https://nodejs.org/dist/v{0}/SHASUMS256.txt.asc' -f $env:NODE_VERSION) -OutFile 'SHASUMS256.txt.asc' -UseBasicParsing ; `
#     gpg --batch --decrypt --output SHASUMS256.txt SHASUMS256.txt.asc

RUN Invoke-WebRequest $('https://nodejs.org/dist/v{0}/node-v{0}-win-x64.zip' -f $env:NODE_VERSION) -OutFile 'node.zip' -UseBasicParsing ; `
    # $sum = $(cat SHASUMS256.txt.asc | sls $('  node-v{0}-win-x64.zip' -f $env:NODE_VERSION)) -Split ' ' ; `
    # if ((Get-FileHash node.zip -Algorithm sha256).Hash -ne $sum[0]) { Write-Error 'SHA256 mismatch' } ; `
    Expand-Archive node.zip -DestinationPath C:\ ; `
    Rename-Item -Path $('C:\node-v{0}-win-x64' -f $env:NODE_VERSION) -NewName 'C:\nodejs'
COPY . /install/

# Expand zips, prepare SIF config and WDP package
RUN $env:SIF_PACKAGE_JSS = 'Sitecore JavaScript Services Server for Sitecore 9.1.1 XP 11.0.1 rev. 190318.scwdp.zip'; `
    $env:SITENAME = 'sc'; `
    $env:INSTALL_TEMP = 'C:\\install'; `
    Rename-Item -Path (Resolve-Path (Join-Path $env:INSTALL_TEMP $env:SIF_PACKAGE_JSS)).Path -NewName 'jss.zip';

FROM $BASE_IMAGE

# BUG: Target path needs to exist when building with Docker Engine 19.03.1, see https://github.com/docker/for-win/issues/4349. Should be removed when fixed.
RUN MKDIR C:\install
COPY --from=builder [ "/install/jss.zip", "/install/install-package.json", "/install/" ]

ENV NPM_CONFIG_LOGLEVEL info
# Install node
COPY --from=builder /nodejs /nodejs

# Install Sitecore, apply tweaks and cleanup
RUN $env:SITENAME = 'sc'; `
    $env:INSTALL_TEMP = 'C:\\install'; `
    Install-SitecoreConfiguration -Path (Join-Path $env:INSTALL_TEMP '\\install-package.json') -Package (Join-Path $env:INSTALL_TEMP '\\jss.zip') `
    -Sitename $env:SITENAME ; `
    Remove-Item -Path $env:INSTALL_TEMP -Force -Recurse; 

# Add node path 
RUN $env:PATH = 'C:\nodejs;{0}' -f $env:PATH ; `
    [Environment]::SetEnvironmentVariable('PATH', $env:PATH, [EnvironmentVariableTarget]::Machine)

# ServiceMonitor needs to point to the Application Pool that Sitecore runs in instead of the default one, to support environment variables
ENTRYPOINT ["C:\\ServiceMonitor.exe", "w3svc", "sc"]