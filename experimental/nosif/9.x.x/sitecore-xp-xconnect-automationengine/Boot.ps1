$licenseFilePath = "C:\AutomationEngine\App_Data\license\license.xml"

if (!(Test-Path $licenseFilePath -PathType "Leaf"))
{
    throw ("License not found at '{0}'." -f $licenseFilePath)
}

Copy-Item $licenseFilePath -Destination "C:\AutomationEngine\App_Data"

& C:\AutomationEngine\maengine.exe