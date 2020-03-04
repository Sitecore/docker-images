# escape=`
ARG BUILD_IMAGE
ARG BASE_IMAGE

FROM $BUILD_IMAGE as builder

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

COPY . /install/

# Download tools, prepare WDP package
RUN $env:SIF_PACKAGE_SXA = 'Sitecore Experience Accelerator XM *.scwdp.zip'; `
    $env:INSTALL_TEMP = 'C:\\install'; `
    Rename-Item -Path (Resolve-Path (Join-Path $env:INSTALL_TEMP $env:SIF_PACKAGE_SXA)).Path -NewName 'sxa.zip'; `
    Invoke-WebRequest -Uri 'https://dist.nuget.org/win-x86-commandline/v5.0.2/nuget.exe' -UseBasicParsing -OutFile (Join-Path $env:INSTALL_TEMP '\\nuget.exe'); `
    & (Join-Path $env:INSTALL_TEMP '\\nuget.exe') install 'Microsoft.Web.Xdt' -Version '3.0.0' -OutputDirectory $env:INSTALL_TEMP;

# Runtime
FROM $BASE_IMAGE as final

COPY --from=builder [ "/install/", "/install/" ]

# Install module, apply transforms and cleanup
RUN $env:SITENAME = 'sc'; `
    $env:INSTALL_TEMP = 'C:\\install'; `
    Install-SitecoreConfiguration -Path (Join-Path $env:INSTALL_TEMP '\\install-package.json') -Package (Join-Path $env:INSTALL_TEMP '\\sxa.zip') -Sitename $env:SITENAME; `
    $env:SITE_PATH = 'C:\\inetpub\\{0}' -f $env:SITENAME; `
    $env:XDTDLL_PATH = Join-Path $env:SITE_PATH '\\bin\\Microsoft.Web.XmlTransform.dll'; `
    $env:WEBCONFIG_PATH = Join-Path $env:SITE_PATH '\\Web.config'; `
    Expand-Archive -Path (Join-Path $env:SITE_PATH '\\App_Data\\Transforms\\SXASCCPL.zip') -DestinationPath (Join-Path $env:INSTALL_TEMP '\\SXASCCPL'); `
    Copy-Item -Path (Join-Path $env:INSTALL_TEMP "\\Microsoft.Web.Xdt.*\\lib\\net40\\Microsoft.Web.XmlTransform.dll") -Destination $env:XDTDLL_PATH; `
    & (Join-Path $env:INSTALL_TEMP "\\Invoke-XdtTransform.ps1") -Path $env:WEBCONFIG_PATH -XdtPath (Join-Path $env:INSTALL_TEMP '\\SXASCCPL\\Xdts\\Web.config.xdt') -XdtDllPath $env:XDTDLL_PATH; `
    & (Join-Path $env:INSTALL_TEMP "\\Invoke-XdtTransform.ps1") -Path $env:WEBCONFIG_PATH -XdtPath (Join-Path $env:SITE_PATH '\\App_Config\\Sitecore.XA.Foundation.VersionSpecific.sxaconfig') -XdtDllPath $env:XDTDLL_PATH; `
    Remove-Item -Path $env:INSTALL_TEMP -Force -Recurse;
