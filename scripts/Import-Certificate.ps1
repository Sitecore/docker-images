Param(
    $certificateFile = "",
    $secret = "",
    $storeName = "Root",
    $storeLocation = "LocalMachine"
)

$pwd = ConvertTo-SecureString -String $secret -Force -AsPlainText; `
Import-PfxCertificate -FilePath $certificateFile -CertStoreLocation Cert:\$storeLocation\$storeName -Password $pwd
