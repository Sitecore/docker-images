# escape=`
ARG BASE_IMAGE

FROM $BASE_IMAGE

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ENV INSTALL_TEMP='c:\\install'
ARG WEBDEPLOY_MSI=${INSTALL_TEMP}\\webdeploy.msi
ARG URLREWRITE_MSI=${INSTALL_TEMP}\\urlrewrite.msi
ARG VCREDISTX64_EXE=${INSTALL_TEMP}\\VC_redist.x64.exe

ADD https://download.microsoft.com/download/0/1/D/01DC28EA-638C-4A22-A57B-4CEF97755C6C/WebDeploy_amd64_en-US.msi ${WEBDEPLOY_MSI}
ADD https://download.microsoft.com/download/1/2/8/128E2E22-C1B9-44A4-BE2A-5859ED1D4592/rewrite_amd64_en-US.msi ${URLREWRITE_MSI}
ADD https://aka.ms/vs/15/release/VC_redist.x64.exe ${VCREDISTX64_EXE}

# Install Sitecore dependecies and SIF
RUN Start-Process msiexec.exe -ArgumentList '/i', $env:WEBDEPLOY_MSI, '/quiet', '/norestart' -NoNewWindow -Wait; `
    Start-Process msiexec.exe -ArgumentList '/i', $env:URLREWRITE_MSI, '/quiet', '/norestart' -NoNewWindow -Wait; `
    Start-Process $env:VCREDISTX64_EXE -ArgumentList '/install', '/passive', '/norestart' -NoNewWindow -Wait; `
    Install-PackageProvider -Name NuGet -Force | Out-Null; `
    Register-PSRepository -Name SitecoreGallery -SourceLocation https://sitecore.myget.org/F/sc-powershell/api/v2; `
    Install-Module SitecoreInstallFramework -RequiredVersion 1.2.1 -Force;

# Apply tweaks and remove default IIS site
RUN Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters' -Name ServerPriorityTimeLimit -Value 0 -Type DWord; `
    setx /M PATH $($env:PATH + ';C:\Sitecore\Scripts'); `
    Remove-Website -Name 'Default Web Site'; `
