[CmdletBinding()]
param (
    [Parameter(Mandatory=$true)]
    [string]$sourceFolder,
    [Parameter(Mandatory=$true)]
    [string]$DestinationFolder
)
Copy-Item "$sourceFolder/content/bin/Sitecore.Publishing.Service.dll" $DestinationFolder
Copy-Item "$sourceFolder/content/bin/Sitecore.Publishing.Service.Abstractions.dll" $DestinationFolder
Copy-Item "$sourceFolder/content/bin/Sitecore.Publishing.Service.Delivery.dll" $DestinationFolder
Copy-Item "$sourceFolder/content/bin/Sitecore.Framework.Conditions.dll" $DestinationFolder

Copy-Item "$sourceFolder/content/App_Config/Modules/PublishingService/Sitecore.Publishing.Service.Delivery.config" "$DestinationFolder/App_Config/Modules/PublishingService/"