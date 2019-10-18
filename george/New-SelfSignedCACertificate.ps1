$rootCAParams = @{
	DnsName = "DO_NOT_TRUST_SitecoreDockerCA"
	KeyLength = 2048
	KeyAlgorithm = "RSA"
	HashAlgorithm = "SHA256"
	KeyExportPolicy = "Exportable"
	NotAfter = (Get-Date).AddYears(5)
	CertStoreLocation = "Cert:\LocalMachine\My"
	KeyUsage = 'CertSign', 'CRLSign'
}

$rootCA = New-SelfSignedCertificate @rootCAParams

$params = @{
	DnsName = "localhost"
	Signer = $rootCA
	KeyLength = 2048
	KeyAlgorithm = "RSA"
	HashAlgorithm = "SHA256"
	KeyExportPolicy = "Exportable"
	NotAfter = (Get-Date).AddYears(5)
	CertStoreLocation = "Cert:\LocalMachine\My"
}

$cert = New-SelfSignedCertificate @params

Export-Certificate -Cert $rootCA -FilePath .\root.cer
Export-PfxCertificate -Cert $cert -FilePath .\cert.pfx -Password (ConvertTo-SecureString -AsPlainText 'secret' -Force)