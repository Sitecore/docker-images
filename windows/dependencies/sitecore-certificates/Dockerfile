# escape=`
ARG BUILD_IMAGE
ARG BASE_IMAGE

FROM $BUILD_IMAGE as build

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

RUN $env:ROOT_CERT_NAME = 'sitecore-root'; `
    $env:XCONNECT_SSL_CERT_NAME = 'xconnect'; `
    $env:XCONNECT_CLIENT_CERT_NAME = 'xconnect-client'; `
    $env:COMMERCE_CLIENT_CERT_NAME = 'commerce-client'; `
    $env:IDENTITY_CLIENT_CERT_NAME = 'identity-client'; `
    $env:IDENTITY_SSL_CERT_NAME = 'identity'; `
    $env:CM_SSL_CERT_NAME = 'cm'; `
    $env:AUTHORINGHOST_SSL_CERT_NAME = 'authoringhost'; `
    $env:CERT_STORE = 'Cert:\LocalMachine\My'; `
    $env:CERT_PASSWORD = 'Twelve4-4Cranial-Rag-kayo4-Ragweed-This8-grunge9-0Foss-7finalist-hubby'; `
    New-Item -Path 'C:\\certificates' -ItemType 'Directory' | Out-Null; `
    $password = ConvertTo-SecureString -String $env:CERT_PASSWORD -Force -AsPlainText; `
    $rootCert = New-SelfSignedCertificate -Certstorelocation $env:CERT_STORE -DnsName $env:ROOT_CERT_NAME -KeyUsage 'CRLSign', 'CertSign' -KeyExportPolicy 'Exportable' -Provider 'Microsoft Enhanced RSA and AES Cryptographic Provider' -HashAlgorithm 'SHA256'; `
    $rootCert | Export-PfxCertificate -FilePath ('C:\\certificates\\{1}.pfx' -f $env:CERT_PATH, $env:ROOT_CERT_NAME) -Password $password | Out-Null; `
    New-SelfSignedCertificate -CertStoreLocation $env:CERT_STORE -DnsName $env:XCONNECT_SSL_CERT_NAME, '127.0.0.1', 'localhost' -Signer $rootCert -KeyExportPolicy 'Exportable' -Provider 'Microsoft Enhanced RSA and AES Cryptographic Provider' | Export-PfxCertificate -FilePath ('C:\\certificates\\{1}.pfx' -f $env:CERT_PATH, $env:XCONNECT_SSL_CERT_NAME) -Password $password | Out-Null; `
    New-SelfSignedCertificate -CertStoreLocation $env:CERT_STORE -DnsName $env:XCONNECT_CLIENT_CERT_NAME -Signer $rootCert -KeyExportPolicy 'Exportable' -Provider 'Microsoft Enhanced RSA and AES Cryptographic Provider' | Export-PfxCertificate -FilePath ('C:\\certificates\\{1}.pfx' -f $env:CERT_PATH, $env:XCONNECT_CLIENT_CERT_NAME) -Password $password | Out-Null; `
    New-SelfSignedCertificate -CertStoreLocation $env:CERT_STORE -DnsName $env:COMMERCE_CLIENT_CERT_NAME -Signer $rootCert -KeyExportPolicy 'Exportable' -Provider 'Microsoft Enhanced RSA and AES Cryptographic Provider' | Export-PfxCertificate -FilePath ('C:\\certificates\\{1}.pfx' -f $env:CERT_PATH, $env:COMMERCE_CLIENT_CERT_NAME) -Password $password | Out-Null; `
    New-SelfSignedCertificate -CertStoreLocation $env:CERT_STORE -DnsName $env:IDENTITY_CLIENT_CERT_NAME -Signer $rootCert -KeyExportPolicy 'Exportable' -Provider 'Microsoft Enhanced RSA and AES Cryptographic Provider' | Export-PfxCertificate -FilePath ('C:\\certificates\\{1}.pfx' -f $env:CERT_PATH, $env:IDENTITY_CLIENT_CERT_NAME) -Password $password | Out-Null; `
    New-SelfSignedCertificate -CertStoreLocation $env:CERT_STORE -DnsName $env:IDENTITY_SSL_CERT_NAME, '127.0.0.1', 'localhost' -Signer $rootCert -KeyExportPolicy 'Exportable' -Provider 'Microsoft Enhanced RSA and AES Cryptographic Provider' | Export-PfxCertificate -FilePath ('C:\\certificates\\{1}.pfx' -f $env:CERT_PATH, $env:IDENTITY_SSL_CERT_NAME) -Password $password | Out-Null; `
    New-SelfSignedCertificate -CertStoreLocation $env:CERT_STORE -DnsName $env:CM_SSL_CERT_NAME, '127.0.0.1', 'localhost' -Signer $rootCert -KeyExportPolicy 'Exportable' -Provider 'Microsoft Enhanced RSA and AES Cryptographic Provider' | Export-PfxCertificate -FilePath ('C:\\certificates\\{1}.pfx' -f $env:CERT_PATH, $env:CM_SSL_CERT_NAME) -Password $password | Out-Null; `
    New-SelfSignedCertificate -CertStoreLocation $env:CERT_STORE -DnsName $env:AUTHORINGHOST_SSL_CERT_NAME, '127.0.0.1', 'localhost' -Signer $rootCert -KeyExportPolicy 'Exportable' -Provider 'Microsoft Enhanced RSA and AES Cryptographic Provider' | Export-PfxCertificate -FilePath ('C:\\certificates\\{1}.pfx' -f $env:CERT_PATH, $env:AUTHORINGHOST_SSL_CERT_NAME) -Password $password | Out-Null; `
    Import-PfxCertificate -FilePath ('C:\\certificates\\sitecore-root.pfx') -CertStoreLocation 'cert:\localmachine\root' -Password $password | Out-Null; `
    (Get-ChildItem -Path $env:CERT_STORE | Where-Object { $_.Subject -eq ('CN={0}' -f $env:ROOT_CERT_NAME ) }).Thumbprint | Out-File -FilePath ('C:\\certificates\\{0}.thumbprint' -f $env:ROOT_CERT_NAME) -NoNewline -Encoding utf8; `
    (Get-ChildItem -Path $env:CERT_STORE | Where-Object { $_.Subject -eq ('CN={0}' -f $env:XCONNECT_SSL_CERT_NAME ) }).Thumbprint | Out-File -FilePath ('C:\\certificates\\{0}.thumbprint' -f $env:XCONNECT_SSL_CERT_NAME) -NoNewline -Encoding utf8; `
    (Get-ChildItem -Path $env:CERT_STORE | Where-Object { $_.Subject -eq ('CN={0}' -f $env:XCONNECT_CLIENT_CERT_NAME ) }).Thumbprint | Out-File -FilePath ('C:\\certificates\\{0}.thumbprint' -f $env:XCONNECT_CLIENT_CERT_NAME) -NoNewline -Encoding utf8; `
    (Get-ChildItem -Path $env:CERT_STORE | Where-Object { $_.Subject -eq ('CN={0}' -f $env:COMMERCE_CLIENT_CERT_NAME ) }).Thumbprint | Out-File -FilePath ('C:\\certificates\\{0}.thumbprint' -f $env:COMMERCE_CLIENT_CERT_NAME) -NoNewline -Encoding utf8; `
    (Get-ChildItem -Path $env:CERT_STORE | Where-Object { $_.Subject -eq ('CN={0}' -f $env:IDENTITY_CLIENT_CERT_NAME ) }).Thumbprint | Out-File -FilePath ('C:\\certificates\\{0}.thumbprint' -f $env:IDENTITY_CLIENT_CERT_NAME) -NoNewline -Encoding utf8; `
    (Get-ChildItem -Path $env:CERT_STORE | Where-Object { $_.Subject -eq ('CN={0}' -f $env:IDENTITY_SSL_CERT_NAME ) }).Thumbprint | Out-File -FilePath ('C:\\certificates\\{0}.thumbprint' -f $env:IDENTITY_SSL_CERT_NAME) -NoNewline -Encoding utf8; `
    (Get-ChildItem -Path $env:CERT_STORE | Where-Object { $_.Subject -eq ('CN={0}' -f $env:CM_SSL_CERT_NAME ) }).Thumbprint | Out-File -FilePath ('C:\\certificates\\{0}.thumbprint' -f $env:CM_SSL_CERT_NAME) -NoNewline -Encoding utf8; `
    (Get-ChildItem -Path $env:CERT_STORE | Where-Object { $_.Subject -eq ('CN={0}' -f $env:AUTHORINGHOST_SSL_CERT_NAME ) }).Thumbprint | Out-File -FilePath ('C:\\certificates\\{0}.thumbprint' -f $env:AUTHORINGHOST_SSL_CERT_NAME) -NoNewline -Encoding utf8; `
    $env:CERT_PASSWORD | Out-File -FilePath 'C:\\certificates\\password' -NoNewline -Encoding utf8;

FROM $BASE_IMAGE

COPY --from=build ["C:\\certificates\\", "C:\\certificates\\"]