# escape=`
ARG BASE_IMAGE

FROM $BASE_IMAGE as builder

ARG WDP_GLOB

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ENV NODE_VERSION 10.16.3

RUN Invoke-WebRequest $('https://nodejs.org/dist/v{0}/node-v{0}-win-x64.zip' -f $env:NODE_VERSION) -OutFile 'node.zip' -UseBasicParsing ; `
    Expand-Archive node.zip -DestinationPath C:\ ; `
    Rename-Item -Path $('C:\\node-v{0}-win-x64' -f $env:NODE_VERSION) -NewName 'C:\\nodejs';

COPY . /install/

# Prepare WDP package
RUN $env:INSTALL_TEMP = 'C:\\install'; `
    Rename-Item -Path (Resolve-Path (Join-Path 'C:\\install' $env:WDP_GLOB)).Path -NewName 'jss.zip' -Verbose; `
    Invoke-WebRequest -Uri 'https://dist.nuget.org/win-x86-commandline/v5.0.2/nuget.exe' -UseBasicParsing -OutFile (Join-Path $env:INSTALL_TEMP '\\nuget.exe'); `
    & (Join-Path $env:INSTALL_TEMP '\\nuget.exe') install 'Microsoft.Web.Xdt' -Version '3.0.0' -OutputDirectory $env:INSTALL_TEMP;

FROM $BASE_IMAGE

COPY --from=builder [ "/install/", "/install/" ]

ENV NPM_CONFIG_LOGLEVEL info

# Install node
COPY --from=builder ["/nodejs", "/nodejs"]

# Install Sitecore, apply tweaks and cleanup
RUN $env:SITENAME = 'sc'; `
    $env:INSTALL_TEMP = 'C:\\install'; `
    Install-SitecoreConfiguration -Path (Join-Path $env:INSTALL_TEMP '\\install-package.json') -Package (Join-Path $env:INSTALL_TEMP '\\jss.zip') -Sitename $env:SITENAME; `
    $env:SITE_PATH = 'C:\\inetpub\\{0}' -f $env:SITENAME; `
    $env:XDTDLL_PATH = Join-Path $env:SITE_PATH '\\bin\\Microsoft.Web.XmlTransform.dll'; `
    $env:WEBCONFIG_PATH = Join-Path $env:SITE_PATH '\\Web.config'; `
    Move-Item -Path (Join-Path $env:SITE_PATH '\\App_Data\\Transforms\\JSS*.sccpl') -Destination (Join-Path $env:INSTALL_TEMP '\\JSS-sccpl.zip'); `
    Expand-Archive -Path (Join-Path $env:INSTALL_TEMP '\\JSS-sccpl.zip') -DestinationPath (Join-Path $env:INSTALL_TEMP '\\JSS-sccpl'); `
    Copy-Item -Path (Join-Path $env:INSTALL_TEMP "\\Microsoft.Web.Xdt.*\\lib\\net40\\Microsoft.Web.XmlTransform.dll") -Destination $env:XDTDLL_PATH; `
    & (Join-Path $env:INSTALL_TEMP "\\Invoke-XdtTransform.ps1") -Path $env:WEBCONFIG_PATH -XdtPath (Join-Path $env:INSTALL_TEMP '\\JSS-sccpl\\Xdts\\Web.config.xdt') -XdtDllPath $env:XDTDLL_PATH; `
    Remove-Item -Path $env:INSTALL_TEMP -Force -Recurse; 

# Add node path
RUN $env:PATH = 'C:\nodejs;{0}' -f $env:PATH ; `
    [Environment]::SetEnvironmentVariable('PATH', $env:PATH, [EnvironmentVariableTarget]::Machine)
