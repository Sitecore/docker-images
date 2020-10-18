# Set Host
$publishingHost = (-join($PSScriptRoot, "\Sitecore.Framework.Publishing.Host.exe"))

Write-Host $publishingHost

# Set Conn strings
$coreArgs   = "configuration setconnectionstring core" , """$env:CONN_STRING_CORE"""
$masterArgs = "configuration setconnectionstring master", """$env:CONN_STRING_MASTER"""
$webArgs    = "configuration setconnectionstring web", """$env:CONN_STRING_WEB"""

# apply connectionstring
Start-Process $publishingHost -ArgumentList $coreArgs -NoNewWindow -Wait; 
Start-Process $publishingHost -ArgumentList $masterArgs -NoNewWindow -Wait;  
Start-Process $publishingHost -ArgumentList $webArgs -NoNewWindow -Wait; 
	
# Upgrade schema
Start-Process $publishingHost 'schema upgrade --force' -NoNewWindow -Wait; 

# Start process
Start-Process $publishingHost -ArgumentList '--environment development' -NoNewWindow -Wait; 
