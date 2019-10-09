[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string]$EngineConnectIncludeDir,
    [Parameter(Mandatory = $true)]
    [string]$CommerceServicesHost,
    [string]$CommerceServicesPort,
	[Parameter(Mandatory = $true)]
	[string]$CommerceServicesEnvironment,
	[Parameter(Mandatory = $true)]
	[string]$CommerceServicesShopName,
	[Parameter(Mandatory = $true)]
	[string]$CommerceServicesShopCurrency,
	[Parameter(Mandatory = $true)]
	[string]$CommerceServicesCertificateId,
	[Parameter(Mandatory = $true)]
	[string]$CommerceServicesCertificateStorePath
)   

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

$cert = GetCertificate -Id $CommerceServicesCertificateId -CertStorePath $CommerceServicesCertificateStorePath

$pathToConfig = $(Join-Path -Path $EngineConnectIncludeDir -ChildPath "\Sitecore.Commerce.Engine.Connect.config") 
$xml = [xml](Get-Content $pathToConfig)

$node = $xml.configuration.sitecore.commerceEngineConfiguration
$node.shopsServiceUrl = $node.shopsServiceUrl -replace "localhost", "$CommerceServicesHost"
$node.commerceOpsServiceUrl = $node.commerceOpsServiceUrl -replace "localhost", "$CommerceServicesHost"
$xml.Save($pathToConfig)  

if(!$CommerceServicesPort){
	$CommerceServicesPort=""
}

$xml = [xml](Get-Content $pathToConfig)
$node = $xml.configuration.sitecore.commerceEngineConfiguration
$node.shopsServiceUrl = $node.shopsServiceUrl -replace ":5000", $CommerceServicesPort
$node.commerceOpsServiceUrl = $node.commerceOpsServiceUrl -replace ":5000", $CommerceServicesPort
$xml.Save($pathToConfig)  
 
$xml = [xml](Get-Content $pathToConfig)
$node = $xml.configuration.sitecore.commerceEngineConfiguration
$node.defaultEnvironment = $CommerceServicesEnvironment
$xml.Save($pathToConfig)  

$xml = [xml](Get-Content $pathToConfig)
$node = $xml.configuration.sitecore.commerceEngineConfiguration
$node.defaultShopName = $CommerceServicesShopName
$xml.Save($pathToConfig) 

$xml = [xml](Get-Content $pathToConfig)
$node = $xml.configuration.sitecore.commerceEngineConfiguration
$node.defaultShopCurrency = $CommerceServicesShopCurrency
$xml.Save($pathToConfig) 

$xml = [xml](Get-Content $pathToConfig)
$node = $xml.configuration.sitecore.commerceEngineConfiguration
$node.certificateThumbprint = $($cert.Thumbprint)
$xml.Save($pathToConfig) 