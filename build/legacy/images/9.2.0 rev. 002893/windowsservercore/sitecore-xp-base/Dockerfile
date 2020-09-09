# escape=`
ARG BASE_IMAGE

FROM $BASE_IMAGE as builder

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

COPY . /install/

# Expand zips and prepare SIF config
RUN $env:SIF_CONFIG = 'createcert.json'; `
    $env:INSTALL_TEMP = 'C:\\install'; `
    Expand-Archive -Path (Join-Path $env:INSTALL_TEMP '*.zip') -DestinationPath $env:INSTALL_TEMP; `
    Expand-Archive -Path (Join-Path $env:INSTALL_TEMP '*Configuration files*.zip') -DestinationPath $env:INSTALL_TEMP; `
    Rename-Item -Path (Resolve-Path (Join-Path $env:INSTALL_TEMP $env:SIF_CONFIG)).Path -NewName 'config.json';

FROM $BASE_IMAGE

# BUG: Target path needs to exist when building with Docker Engine 19.03.1, see https://github.com/docker/for-win/issues/4349. Should be removed when fixed.
RUN MKDIR C:\install
COPY --from=builder ["/install/config.json", "/install/"]

# Create and install certificates
RUN $env:INSTALL_TEMP = 'C:\\install'; `
    $env:CERT_PATH = 'C:\\certificates'; `
    $env:XCONNECT_CERT_NAME = 'xconnect-client'; `
    $env:XCONNECT_SSL_NAME = 'xconnect'; `
    Install-SitecoreConfiguration -Path (Join-Path $env:INSTALL_TEMP '\\config.json') -CertificateName $env:XCONNECT_CERT_NAME -CertPath $env:CERT_PATH; `
    $certPassword = (ConvertTo-SecureString -String 'Sp1JJvsrkXtWW9fOSFUh' -Force -AsPlainText); `
    New-SelfSignedCertificate -CertStoreLocation 'cert:\localmachine\my' -DnsName $env:XCONNECT_SSL_NAME -KeyExportPolicy Exportable -Provider 'Microsoft Enhanced RSA and AES Cryptographic Provider' | Export-PfxCertificate -FilePath ('{0}\\{1}.pfx' -f $env:CERT_PATH, $env:XCONNECT_SSL_NAME) -Password $certPassword; `
    Import-PfxCertificate -FilePath (Join-Path $env:CERT_PATH ('\\{0}.pfx' -f $env:XCONNECT_SSL_NAME)) -CertStoreLocation 'cert:\localmachine\root' -Password $certPassword; `
    Remove-Item -Path $env:CERT_PATH -Force -Recurse; `
    Remove-Item -Path $env:INSTALL_TEMP -Force -Recurse;
