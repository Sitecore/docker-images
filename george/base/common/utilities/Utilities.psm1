function Sync-Configuration {
	param(
		[string]$Path,
		[string]$AppPath
	)

	$json = Get-Content $Path | ConvertFrom-Json
	foreach ($config in $json.configuration) {
		$path = Join-Path $AppPath -ChildPath $config.path | Resolve-Path
		$config.mappings | % { Update-ConfigurationFile -Path $path -XPath $_.xpath -Property $_.property -Value $ExecutionContext.InvokeCommand.ExpandString($_.value) }
	}

	foreach ($certificate in $json.certificates) {
		$path = Resolve-Path $certificate.path
		if ([System.IO.Path]::GetExtension($path) -eq ".pfx") {
			$secret = ConvertTo-SecureString -String $certificate.secret -AsPlainText -Force
			$cert = Import-PfxCertificate -FilePath $path -CertStoreLocation $certificate.store -Password $secret
			Add-CertificatePermission -Certificate $cert -User (New-Object System.Security.Principal.NTAccount($certificate.user))
		}
		else {
			Import-Certificate -FilePath $path -CertStoreLocation $certificate.store | Out-Null
		}
	}
}
function Update-ConfigurationFile {
	param(
		[string]$Path,
		[string]$XPath,
		[string]$Property,
		[string]$Value
	)

	[xml]$XmlDocument = Get-Content -Path $Path
	$Target = $XmlDocument.SelectSingleNode($XPath)
	$Target.($Property) = $Value
	$XmlDocument.Save($Path)
}

function Add-CertificatePermission {
	param(
		[System.Security.Cryptography.X509Certificates.X509Certificate2]$Certificate,
		[System.Security.Principal.NTAccount]$User
	)

	$rsa = [System.Security.Cryptography.X509Certificates.RSACertificateExtensions]::GetRSAPrivateKey($Certificate)
	$keyPath = "$($env:ALLUSERSPROFILE)\Microsoft\Crypto\Keys\$($rsa.key.UniqueName)"
	$acl = Get-Acl $keyPath

	$acr = New-Object System.Security.AccessControl.FileSystemAccessRule($User, 'Read', 'Allow')
	$acl.AddAccessRule($acr)
	Set-Acl -Path $keyPath -AclObject $acl
}