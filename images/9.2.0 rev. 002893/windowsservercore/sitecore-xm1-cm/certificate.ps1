Import-Module WebAdministration

Set-Location cert:
$cert = New-SelfSignedCertificate -DnsName "localhost" -FriendlyName "Sitecore Docker" -CertStoreLocation Cert:\LocalMachine\My

$rootStore = New-Object System.Security.Cryptography.X509Certificates.X509Store -ArgumentList Root, LocalMachine

$rootStore.Open("MaxAllowed")
$rootStore.Add($cert)
$rootStore.Close()

Set-Location iis:

New-Item -path IIS:\SslBindings\0.0.0.0!443 -value $cert
New-WebBinding -Name "sc" -IP "*" -Port 443 -Protocol https
iisreset