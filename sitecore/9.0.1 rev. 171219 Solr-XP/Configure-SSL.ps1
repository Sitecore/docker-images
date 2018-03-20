Param(
    $solrVersion = "6.6.2",
	$installFolder = "c:\solr",
	$solrHost = "",
	$certPath = ""
)

$solrName = "solr-$solrVersion"
$solrRoot = "$installFolder\$solrName"

# Ensure the solr host name is in your hosts file
if($solrHost -ne "localhost")
{
    $hostFileName = "c:\\windows\system32\drivers\etc\hosts"
    $hostFile = [System.Io.File]::ReadAllText($hostFileName)
    if(!($hostFile -like "*$solrHost*"))
    {
        Write-Host "Updating host file"
        "`r`n127.0.0.1`t$solrHost" | Add-Content $hostFileName
    }
}

# Generate SSL cert
$existingCert = Get-ChildItem Cert:\LocalMachine\Root | where FriendlyName -eq "$solrName"
if(!($existingCert))
{
	Write-Host "Trusting SSL Cert for $solrHost"

	$cert = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2
	$cert.Import($certPath,'secret','DefaultKeySet')

	# Trust the cert
	# https://stackoverflow.com/questions/8815145/how-to-trust-a-certificate-in-windows-powershell
	$store = New-Object System.Security.Cryptography.X509Certificates.X509Store "Root","LocalMachine"
	$store.Open("ReadWrite")
	$store.Add($cert)
	$store.Close()
}

# export the cert to pfx using solr's default password
if(!(Test-Path -Path "$solrRoot\server\etc\solr-ssl.keystore.pfx"))
{
	Write-Host "Exporting cert for Solr to use"

	$certStore = "$solrRoot\server\etc\solr-ssl.keystore.pfx"

	Copy-Item -Path $certPath -Destination $certStore
}

# Update solr cfg to use keystore & right host name
if(!(Test-Path -Path "$solrRoot\bin\solr.in.cmd.old"))
{
	Write-Host "Rewriting solr config"

	$cfg = Get-Content "$solrRoot\bin\solr.in.cmd"
	Rename-Item "$solrRoot\bin\solr.in.cmd" "$solrRoot\bin\solr.in.cmd.old"
	$newCfg = $cfg | % { $_ -replace "REM set SOLR_SSL_KEY_STORE=etc/solr-ssl.keystore.jks", "set SOLR_SSL_KEY_STORE=$certStore" }
	$newCfg = $newCfg | % { $_ -replace "REM set SOLR_SSL_KEY_STORE_PASSWORD=secret", "set SOLR_SSL_KEY_STORE_PASSWORD=secret" }
	$newCfg = $newCfg | % { $_ -replace "REM set SOLR_SSL_TRUST_STORE=etc/solr-ssl.keystore.jks", "set SOLR_SSL_TRUST_STORE=$certStore" }
	$newCfg = $newCfg | % { $_ -replace "REM set SOLR_SSL_TRUST_STORE_PASSWORD=secret", "set SOLR_SSL_TRUST_STORE_PASSWORD=secret" }
	$newCfg = $newCfg | % { $_ -replace "REM set SOLR_HOST=192.168.1.1", "set SOLR_HOST=$solrHost" }
	$newCfg | Set-Content "$solrRoot\bin\solr.in.cmd"
}