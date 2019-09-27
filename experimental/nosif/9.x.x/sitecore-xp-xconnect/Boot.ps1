$licenseFilePath = "C:\inetpub\wwwroot\App_Data\license\license.xml"

if (!(Test-Path $licenseFilePath -PathType "Leaf"))
{
    throw ("License not found at '{0}'." -f $licenseFilePath)
}

Copy-Item $licenseFilePath -Destination "C:\inetpub\wwwroot\App_Data"

& C:\ServiceMonitor.exe "w3svc"