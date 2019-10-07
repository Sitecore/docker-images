[CmdletBinding(SupportsShouldProcess = $true)]
param
(
    [Parameter(Mandatory)]
    [string]$RootCertDnsName,
	[Parameter(Mandatory)]
	[string]$RootCertStore,
    [ValidateScript( { $_.StartsWith("Cert:\", "CurrentCultureIgnoreCase")})]
    [ValidateScript( { Test-Path $_ -Type Container })]
    [string]$CertStoreLocation = 'Cert:\LocalMachine\My',
    [ValidateNotNullOrEmpty()]
    [string[]]$DnsName = '127.0.0.1',
    [ValidateNotNullOrEmpty()]
    [string]$FriendlyName = $DnsName[0],
    [ValidateScript( { Test-Path $_ -Type Container })]
    [string]$Path,
    [string]$Name = 'localhost',
    [string]$IncludePrivateKeyString,
    [securestring]$Password
)

function NewCertificate {
    param(
        [string]$FriendlyName = "Sitecore Install Framework",
        [string[]]$DNSNames = "127.0.0.1",
        [ValidateSet("LocalMachine","CurrentUser")]
        [string]$CertStoreLocation = "LocalMachine",
        [ValidateScript({$_.HasPrivateKey})]
        [System.Security.Cryptography.X509Certificates.X509Certificate2]$Signer
    )

    # DCOM errors in System Logs are by design.
    # https://support.microsoft.com/en-gb/help/4022522/dcom-event-id-10016-is-logged-in-windows-10-and-windows-server-2016

    $date = Get-Date
    $certificateLocation = "Cert:\\$CertStoreLocation\My"
    $rootCertificateLocation = "Cert:\\$CertStoreLocation\Root"

    # Certificate Creation Location.
    $location = @{}
    if ($CertStoreLocation -eq "LocalMachine"){
        $location.MachineContext = $true
        $location.Value = 2 # Machine Context
    } else {
        $location.MachineContext = $false
        $location.Value = 1 # User Context
    }

    # RSA Object
    $rsa = New-Object -ComObject X509Enrollment.CObjectId
    $rsa.InitializeFromValue(([Security.Cryptography.Oid]"RSA").Value)

    # SHA256 Object
    $sha256 = New-Object -ComObject X509Enrollment.CObjectId
    $sha256.InitializeFromValue(([Security.Cryptography.Oid]"SHA256").Value)

    # Subject
    $subject = "CN=$($DNSNames[0]), O=DO_NOT_TRUST, OU=Created by https://www.sitecore.com"
    $subjectDN = New-Object -ComObject X509Enrollment.CX500DistinguishedName
    $subjectDN.Encode($Subject, 0x0)

    # Subject Alternative Names
    $san = New-Object -ComObject X509Enrollment.CX509ExtensionAlternativeNames
    $names = New-Object -ComObject X509Enrollment.CAlternativeNames
    foreach ($sanName in $DNSNames) {
        $name = New-Object -ComObject X509Enrollment.CAlternativeName
        $name.InitializeFromString(3,$sanName)
        $names.Add($name)
    }
    $san.InitializeEncode($names)

    # Private Key
    $privateKey = New-Object -ComObject X509Enrollment.CX509PrivateKey
    $privateKey.ProviderName = "Microsoft Enhanced RSA and AES Cryptographic Provider"
    $privateKey.Length = 2048
    $privateKey.ExportPolicy = 1 # Allow Export
    $privateKey.KeySpec = 1
    $privateKey.Algorithm = $rsa
    $privateKey.MachineContext = $location.MachineContext
    $privateKey.Create()

    # Certificate Object
    $certificate = New-Object -ComObject X509Enrollment.CX509CertificateRequestCertificate
    $certificate.InitializeFromPrivateKey($location.Value,$privateKey,"")
    $certificate.Subject = $subjectDN
    $certificate.NotBefore = ($date).AddDays(-1)

    if ($Signer){
        # WebServer Certificate
        # WebServer Extensions
        $usage = New-Object -ComObject X509Enrollment.CObjectIds
        $keys = '1.3.6.1.5.5.7.3.2','1.3.6.1.5.5.7.3.1' #Client Authentication, Server Authentication
        foreach($key in $keys) {
            $keyObj = New-Object -ComObject X509Enrollment.CObjectId
            $keyObj.InitializeFromValue($key)
            $usage.Add($keyObj)
        }

        $webserverEnhancedKeyUsage = New-Object -ComObject X509Enrollment.CX509ExtensionEnhancedKeyUsage
        $webserverEnhancedKeyUsage.InitializeEncode($usage)

        $webserverBasicKeyUsage = New-Object -ComObject X509Enrollment.CX509ExtensionKeyUsage
        $webserverBasicKeyUsage.InitializeEncode([Security.Cryptography.X509Certificates.X509KeyUsageFlags]"DataEncipherment")
        $webserverBasicKeyUsage.Critical = $true

        # Signing CA cert needs to be in MY Store to be read as we need the private key.
        Move-Item -Path $Signer.PsPath -Destination $certificateLocation -Confirm:$false

        $signerCertificate = New-Object -ComObject X509Enrollment.CSignerCertificate
        $signerCertificate.Initialize($location.MachineContext,0,0xc, $Signer.Thumbprint)

        # Return the signing CA cert to the original location.
        Move-Item -Path "$certificateLocation\$($Signer.PsChildName)" -Destination $Signer.PSParentPath -Confirm:$false

        # Set issuer to root CA.
        $issuer = New-Object -ComObject X509Enrollment.CX500DistinguishedName
        $issuer.Encode($signer.Issuer, 0)

        $certificate.Issuer = $issuer
        $certificate.SignerCertificate = $signerCertificate
        $certificate.NotAfter = ($date).AddDays(730)
        $certificate.X509Extensions.Add($webserverEnhancedKeyUsage)
        $certificate.X509Extensions.Add($webserverBasicKeyUsage)

    } else {
        # Root CA
        # CA Extensions
        $rootEnhancedKeyUsage = New-Object -ComObject X509Enrollment.CX509ExtensionKeyUsage
        $rootEnhancedKeyUsage.InitializeEncode([Security.Cryptography.X509Certificates.X509KeyUsageFlags]"DigitalSignature,KeyEncipherment,KeyCertSign")
        $rootEnhancedKeyUsage.Critical = $true

        $basicConstraints = New-Object -ComObject X509Enrollment.CX509ExtensionBasicConstraints
        $basicConstraints.InitializeEncode($true,-1)
        $basicConstraints.Critical = $true

        $certificate.Issuer = $subjectDN #Same as subject for root CA
        $certificate.NotAfter = ($date).AddDays(3650)
        $certificate.X509Extensions.Add($rootEnhancedKeyUsage)
        $certificate.X509Extensions.Add($basicConstraints)

    }

    $certificate.X509Extensions.Add($san) # Add SANs to Certificate
    $certificate.SignatureInformation.HashAlgorithm = $sha256
    $certificate.AlternateSignatureAlgorithm = $false
    $certificate.Encode()

    # Insert Certificate into Store
    $enroll = New-Object -ComObject X509Enrollment.CX509enrollment
    $enroll.CertificateFriendlyName = $FriendlyName
    $enroll.InitializeFromRequest($certificate)
    $certificateData = $enroll.CreateRequest(1)
    $enroll.InstallResponse(2, $certificateData, 1, "")

    # Retrieve thumbprint from $certificateData
    $certificateByteData = [System.Convert]::FromBase64String($certificateData)
    $createdCertificate = New-Object -TypeName System.Security.Cryptography.X509Certificates.X509Certificate2
    $createdCertificate.Import($certificateByteData)

    # Locate newly created certificate.
    $newCertificate = Get-ChildItem -Path $certificateLocation | Where-Object {$_.Thumbprint -Like $createdCertificate.Thumbprint}

    # Move CA to root store.
    if (!$Signer){
        Move-Item -Path $newCertificate.PSPath -Destination $rootCertificateLocation
        $newCertificate = Get-ChildItem -Path $rootCertificateLocation | Where-Object {$_.Thumbprint -Like $createdCertificate.Thumbprint}
    }

    return $newCertificate
}

function ExportCert {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidUsingConvertToSecureStringWithPlainText", "")]
    param (
        [System.Security.Cryptography.X509Certificates.X509Certificate2]$Cert,
        [Parameter(Mandatory)]
        [string]$Path,
        [string]$Name = 'certificate',
        [switch]$IncludePrivateKey,
        [securestring]$Password
    )

    $params = @{
        Cert = $Cert
    }

    if ($IncludePrivateKey) {
        if (!$Password){
            $pass = Invoke-RandomStringConfigFunction -Length 20 -EnforceComplexity
            Write-Information -MessageData "Password used for encryption: $pass" -InformationAction "Continue"
            $params.Password = ConvertTo-SecureString -String $pass -AsPlainText -Force
        } else {
            $params.Password = $Password
        }

        $params.FilePath = "$Path\$Name.pfx"

        Export-PfxCertificate @params

    } else {

        $params.FilePath = "$Path\$Name.crt"

        Export-Certificate @params
    }

    Write-Information -MessageData "Exported certificate file $($params.FilePath)" -InformationAction 'Continue'
}

Function GetCertificate {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Id,
        [ValidateScript( { $_ -like 'cert:\*' })]
        [ValidateScript( { Test-Path $_ })]
        [string]$CertStorePath = 'Cert:\LocalMachine\My'
    )

    Write-Verbose -Message $PSCmdlet.MyInvocation.MyCommand
    Write-Verbose -Message "Id: $Id"
    Write-Verbose -Message "CertStorePath: $CertStorePath"

    $date = Get-Date

    # Find all children under the path
    $found = @(Get-ChildItem -Path $CertStorePath -Recurse |
        # That are certificates
        Where-Object { $_.GetType() -eq [System.Security.Cryptography.X509Certificates.X509Certificate2] } |
        # That match thumbprint or dns name
        Where-Object {
            # Test as thumbprint
            $match = $_.Thumbprint -eq $Id
            if (!$match) {
                # Test as name
                $match = $Id -eq $_.GetNameInfo([System.Security.Cryptography.X509Certificates.X509NameType]::SimpleName, $false)
            }

            return $match
        } |
        # That are in date
        Where-Object {
            $date -ge $_.NotBefore -and $date -le $_.NotAfter
        } |
        # Get Latest
        Sort-Object -Property NotAfter -Descending)    

    if($found.Count -gt 0) {
        Write-Verbose -Message "Found Cert(s) with thumbprint: $($found.Thumbprint)"
    } else {
        Write-Warning "Could not find Cert: $Id in $CertStorePath"
        return $null
    }

    if($found.Count -gt 1) {
        Write-Warning "Found multiple certificates, selecting certificate with longest expiry."
    }

    return $found | Select-Object -First 1 
}

if ($pscmdlet.ShouldProcess($Path, "New signed certificate for $DnsName")) {

	$IncludePrivateKey = $false
	if($IncludePrivateKeyString -eq 'true'){
		$IncludePrivateKey = $true
	}

	[System.Security.Cryptography.X509Certificates.X509Certificate2]$Signer = GetCertificate -Id $RootCertDnsName -CertStorePath $RootCertStore

    $certLocation = $CertStoreLocation.Split('\')[1]

    $params = @{
        CertStorePath = $CertStoreLocation
        ID = $DnsName[0]
    }

    $signedCertificate = GetCertificate @params

    if ($signedCertificate -and (ValidateCertificate -Cert $signedCertificate)) {
        Write-Verbose "Found existing certificate for '$DnsName' in $CertStoreLocation, skipping"
    } else {
        Write-Verbose "Creating a signed certificate for '$DnsName'"

        $params = @{
            CertStoreLocation = $certLocation
            DnsNames = $DnsName
            FriendlyName = $FriendlyName
            Signer = $Signer
        }

        # Create the certificate
        $signedCertificate = NewCertificate @params

        if ($null -eq $signedCertificate) {
            throw "Failed to create signed certificate for '$DnsName' in $CertStoreLocation"
        }
    }

    if ($path){
        Write-Verbose -Message "Exporting certificate $DnsName"

        $params = @{
            Cert = $signedCertificate
            Name = $Name
            Path = $Path
            IncludePrivateKey = $IncludePrivateKey
            Password = $Password
        }
        ExportCert @params

    }

    return $signedCertificate
}