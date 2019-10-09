# escape=`
ARG BASE_IMAGE

FROM $BASE_IMAGE

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

COPY . /install/
RUN MKDIR C:\certificates

# Create and install certificates
RUN $env:INSTALL_TEMP = 'C:\\install'; `
	$env:COMMERCE_SERVICES_HOST_POSTFIX = 'sc'; `
    $env:CERT_PATH = 'C:\\certificates'; `
	$env:ROOT_CERT_DNS_NAME = 'DO_NOT_TRUST_SitecoreRootCert'; `
	$env:ROOT_CERT_STORE = 'cert:\LocalMachine\Root'; `
	$env:CLIENT_CERT_STORE = 'cert:\LocalMachine\My'; `	
	$env:SIGNED_ENGINE_CERT_NAME = ('{0}.storefront.engine' -f $env:COMMERCE_SERVICES_HOST_POSTFIX); `
	$env:SIGNED_CERT_NAME = 'Commerce Engine SSL Certificate'; `
	$env:LOCALHOST_SIGNED_CERT_NAME = 'localhost'; `
	$env:INCLUDE_PRIVATE_KEY = 'true'; `
	& (Join-Path $env:INSTALL_TEMP "\\New-Signed-Certificate.ps1") `
	-RootCertDnsName $env:ROOT_CERT_DNS_NAME `
	-RootCertStore $env:ROOT_CERT_STORE `
	-CertStoreLocation $env:CLIENT_CERT_STORE `
	-Name $env:SIGNED_ENGINE_CERT_NAME `
	-FriendlyName $env:SIGNED_ENGINE_CERT_NAME `
	-DnsName $env:SIGNED_ENGINE_CERT_NAME `
	-Path $env:CERT_PATH `
	-IncludePrivateKeyString $env:INCLUDE_PRIVATE_KEY; `
	& (Join-Path $env:INSTALL_TEMP "\\New-Signed-Certificate.ps1") `
	-RootCertDnsName $env:ROOT_CERT_DNS_NAME `
	-RootCertStore $env:ROOT_CERT_STORE `
	-CertStoreLocation $env:CLIENT_CERT_STORE `
	-Name $env:SIGNED_CERT_NAME `
	-FriendlyName $env:SIGNED_CERT_NAME `
	-DnsName ('*.commerce.{0}' -f $env:COMMERCE_SERVICES_HOST_POSTFIX) `
	-Path $env:CERT_PATH `
	-IncludePrivateKeyString $env:INCLUDE_PRIVATE_KEY; `
	& (Join-Path $env:INSTALL_TEMP "\\New-Commerce-Signed-Certificate.ps1") `
	-RootCertDnsName $env:ROOT_CERT_DNS_NAME `
	-RootCertStore $env:ROOT_CERT_STORE `	
	-CertStoreLocation $env:CLIENT_CERT_STORE `
	-Name $env:LOCALHOST_SIGNED_CERT_NAME `
	-FriendlyName $env:LOCALHOST_SIGNED_CERT_NAME `
	-DnsName $env:LOCALHOST_SIGNED_CERT_NAME `
	-Path $env:CERT_PATH; `
    Remove-Item -Path $env:CERT_PATH -Force -Recurse; `
    Remove-Item -Path $env:INSTALL_TEMP -Force -Recurse;
