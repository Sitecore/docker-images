[CmdletBinding()]
param (
    [Parameter(Mandatory=$true)]
    [string]$sourceFolder,
    [Parameter(Mandatory=$true)]
    [string]$DestinationFolder
)

New-Item -ItemType Directory -Path "$DestinationFolder\bin" -Force
Copy-Item "$sourceFolder/bin/Sitecore.Publishing.Service.dll" "$DestinationFolder\bin" -Recurse
Copy-Item "$sourceFolder/bin/Sitecore.Publishing.Service.Abstractions.dll" "$DestinationFolder\bin"
Copy-Item "$sourceFolder/bin/Sitecore.Publishing.Service.Delivery.dll" "$DestinationFolder\bin"
Copy-Item "$sourceFolder/bin/Sitecore.Framework.Conditions.dll" "$DestinationFolder\bin"

New-Item -ItemType Directory -Path (Join-Path $DestinationFolder "/App_Config/Modules/PublishingService/") -Force
Copy-Item "$sourceFolder/App_Config/Modules/PublishingService/Sitecore.Publishing.Service.Delivery.config" "$DestinationFolder/App_Config/Modules/PublishingService/Sitecore.Publishing.Service.Delivery.config"  -Recurse