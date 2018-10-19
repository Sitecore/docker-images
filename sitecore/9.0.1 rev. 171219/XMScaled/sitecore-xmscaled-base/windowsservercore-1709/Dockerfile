# escape=`
FROM microsoft/aspnet:4.7.1-windowsservercore-1709

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

#ENV SITENAME='sc'
#ENV SITEPATH=C:\inetpub\${SITENAME}\Website
#ENV DATAPATH=C:\inetpub\${SITENAME}\Data
#ARG SQLADMIN_PASSWORD='HASH-epsom-sunset-cost7!'
ARG INSTALL_TEMP='c:\\install'
#ARG SIF_CONFIG=${INSTALL_TEMP}\\sitecore-XM1-cd.json
#ARG SIF_PACKAGE=${INSTALL_TEMP}\\'Sitecore*_cd.scwdp.zip'
ARG WEBDEPLOY_MSI=${INSTALL_TEMP}\\webdeploy.msi
ARG URLREWRITE_MSI=${INSTALL_TEMP}\\urlrewrite.msi
ARG VCREDISTX64_EXE=${INSTALL_TEMP}\\VC_redist.x64.exe

#COPY . ${INSTALL_TEMP}
ADD http://download.microsoft.com/download/0/1/D/01DC28EA-638C-4A22-A57B-4CEF97755C6C/WebDeploy_amd64_en-US.msi ${WEBDEPLOY_MSI}
ADD http://download.microsoft.com/download/D/D/E/DDE57C26-C62C-4C59-A1BB-31D58B36ADA2/rewrite_amd64_en-US.msi ${URLREWRITE_MSI}
ADD https://aka.ms/vs/15/release/VC_redist.x64.exe ${VCREDISTX64_EXE}

# Install SIF and dependecies
RUN Start-Process msiexec.exe -ArgumentList '/i', $env:WEBDEPLOY_MSI, '/quiet', '/norestart' -NoNewWindow -Wait; `
    Start-Process msiexec.exe -ArgumentList '/i', $env:URLREWRITE_MSI, '/quiet', '/norestart' -NoNewWindow -Wait; `
    Start-Process $env:VCREDISTX64_EXE -ArgumentList '/install', '/passive', '/norestart' -NoNewWindow -Wait; `
    Install-PackageProvider -Name NuGet -Force | Out-Null; `
    Register-PSRepository -Name SitecoreGallery -SourceLocation https://sitecore.myget.org/F/sc-powershell/api/v2; `
    Install-Module SitecoreInstallFramework -RequiredVersion 1.1.0 -Force;
