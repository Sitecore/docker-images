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
	[string]$CommerceServicesCertificateThumbprint
)      

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
$node.certificateThumbprint = $CommerceServicesCertificateThumbprint
$xml.Save($pathToConfig) 