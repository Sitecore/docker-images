# Install SIF
Install-PackageProvider -Name NuGet -Force; `
Register-PSRepository -Name SitecoreGallery -SourceLocation https://sitecore.myget.org/F/sc-powershell/api/v2; `
Install-Module SitecoreInstallFramework -RequiredVersion 1.1.0 -Force 
