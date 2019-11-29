[CmdletBinding()]
 param(
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    $ConnectionString_Core,
    $ConnectionString_Master, 
    $ConnectionString_Web,
    $PublishingHost = 'Sitecore.Framework.Publishing.Host.exe'
)

$coreArgs = 'configuration setconnectionstring core "' + $ConnectionString_Core + '"'; 
$masterArgs = 'configuration setconnectionstring master "' + $ConnectionString_Master + '"'; 
$webArgs = 'configuration setconnectionstring web "' + $ConnectionString_Web + '"'; 

Start-Process $PublishingHost -ArgumentList $coreArgs -NoNewWindow -Wait;  
Start-Process $PublishingHost -ArgumentList $masterArgs -NoNewWindow -Wait;  
Start-Process $PublishingHost -ArgumentList $webArgs -NoNewWindow -Wait; 

Start-Process $PublishingHost -ArgumentList 'schema upgrade --force' -NoNewWindow -Wait; 

Write-Output "Starting ServiceMonitor.exe"

& C:\ServiceMonitor.exe "w3svc"
