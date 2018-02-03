# escape=`
FROM microsoft/aspnet:4.7.1-windowsservercore-1709

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ENV SITENAME='sc'
ARG INSTALL_TEMP='c:\\install'
ARG SIF_CONFIG=${INSTALL_TEMP}\\sitecore-XM1-cm.json
ARG WEBDEPLOY_MSI=${INSTALL_TEMP}\\webdeploy.msi
ARG URLREWRITE_MSI=${INSTALL_TEMP}\\urlrewrite.msi

ADD . ${INSTALL_TEMP}
ADD http://download.microsoft.com/download/0/1/D/01DC28EA-638C-4A22-A57B-4CEF97755C6C/WebDeploy_amd64_en-US.msi ${WEBDEPLOY_MSI}
ADD http://download.microsoft.com/download/D/D/E/DDE57C26-C62C-4C59-A1BB-31D58B36ADA2/rewrite_amd64_en-US.msi ${URLREWRITE_MSI}

# Install SIF
RUN Start-Process msiexec.exe -ArgumentList '/i', $env:WEBDEPLOY_MSI, '/quiet', '/norestart' -NoNewWindow -Wait; `
    Start-Process msiexec.exe -ArgumentList '/i', $env:URLREWRITE_MSI, '/quiet', '/norestart' -NoNewWindow -Wait; `
    Install-PackageProvider -Name NuGet -Force | Out-Null; `
    Register-PSRepository -Name SitecoreGallery -SourceLocation https://sitecore.myget.org/F/sc-powershell/api/v2; `
    Install-Module SitecoreInstallFramework -RequiredVersion 1.1.0 -Force;

# Install Sitecore
RUN Expand-Archive -Path (Join-Path $env:INSTALL_TEMP '*.zip') -DestinationPath $env:INSTALL_TEMP; `
    Expand-Archive -Path (Join-Path $env:INSTALL_TEMP '*Configuration files*.zip') -DestinationPath $env:INSTALL_TEMP; `
    $config = Get-Content $env:SIF_CONFIG | Where-Object { $_ -notmatch '^\s*\/\/'} | Out-String | ConvertFrom-Json; `
    $config.Tasks.InstallWDP.Params.Arguments | Add-Member -Name 'Skip' -Value @(@{'ObjectName' = 'dbDacFx'}, @{'ObjectName' = 'dbFullSql'}) -MemberType NoteProperty; `
    $config.Variables.'Site.PhysicalPath' = 'C:\inetpub\{0}' -f $env:SITENAME; `
    ConvertTo-Json $config -Depth 50 | Set-Content -Path $env:SIF_CONFIG; `
    Remove-Website -Name 'Default Web Site'; `
    Install-SitecoreConfiguration -Path $env:SIF_CONFIG `
    -Package (Join-Path $env:INSTALL_TEMP '\\Sitecore*_cm.scwdp.zip') `
    -LicenseFile (Join-Path $env:INSTALL_TEMP '\\license.xml') `
    -Sitename $env:SITENAME `
    -SqlDbPrefix $env:SITENAME `  
    -SolrCorePrefix $env:SITENAME `
    -Skip "RemoveDefaultBinding", "CreateBindingsWithThumprint", "CreateHostHeader", "CreateBindingsWithDevelopmentThumprint", "StartAppPool", "StartWebsite", "UpdateSolrSchema"; `
    Copy-Item -Path (Join-Path $env:INSTALL_TEMP '\\Sitecore') -Destination 'C:/' -Recurse -Force; `
    Clear-WebConfiguration -PSPath ('IIS:\Sites\{0}' -f $env:SITENAME) -Filter '/system.webserver/rewrite/rules/rule'; `
    Set-WebConfiguration -PSPath ('IIS:\Sites\{0}' -f $env:SITENAME) -Filter '/system.web/customErrors/@mode' -Value 'Off'

# Cleanup, post installation tweaks and start site
RUN Start-Process msiexec.exe -ArgumentList '/x', $env:WEBDEPLOY_MSI, '/quiet', '/norestart' -NoNewWindow -Wait; `
    Uninstall-Module SitecoreInstallFramework -Force; `
    Remove-Item -Path $env:INSTALL_TEMP -Force -Recurse; `
    Set-Itemproperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters' -Name ServerPriorityTimeLimit -Value 0 -Type DWord; `
    Start-WebAppPool -Name $env:SITENAME; `
    Start-Website -Name $env:SITENAME
