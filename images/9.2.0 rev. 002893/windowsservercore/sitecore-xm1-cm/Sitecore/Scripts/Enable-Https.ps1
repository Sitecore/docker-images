param(
    # Certificate DNS name
    [Parameter(Mandatory = $false)]
    [string]$DnsName = "localhost"
)

Import-Module WebAdministration
Write-Host ### Configuring HTTPS...

if (!(Get-WebBinding -Protocol https)) {
    Write-Host ### Generating new SSL certificate...
    Set-Location cert:
    $cert = New-SelfSignedCertificate -DnsName $DnsName -FriendlyName "Sitecore Docker" -CertStoreLocation Cert:\LocalMachine\My

    $rootStore = New-Object System.Security.Cryptography.X509Certificates.X509Store -ArgumentList Root, LocalMachine

    $rootStore.Open("MaxAllowed")
    $rootStore.Add($cert)
    $rootStore.Close()

    Set-Location iis:

    New-Item -Path IIS:\SslBindings\0.0.0.0!443 -Value $cert
    New-WebBinding -Name "sc" -IP "*" -Port 443 -Protocol https
}
else {
    Write-Host ### HTTPS binding already configured. Skipping...
}
