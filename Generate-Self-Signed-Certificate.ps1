Param(
    $dnsName = "",
    $file = "",
    $secret = "secret"
)

$cert = New-SelfSignedCertificate -certstorelocation cert:\localmachine\my -dnsname $dnsName -KeyExportPolicy Exportable -Provider 'Microsoft Enhanced RSA and AES Cryptographic Provider'

$pwd = ConvertTo-SecureString -String $secret -Force -AsPlainText

Export-PfxCertificate -cert $cert -FilePath $file -Password $pwd