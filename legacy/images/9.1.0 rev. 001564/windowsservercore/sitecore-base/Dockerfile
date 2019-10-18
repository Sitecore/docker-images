# escape=`
ARG BUILD_IMAGE
ARG BASE_IMAGE

FROM $BUILD_IMAGE as download

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ADD https://download.microsoft.com/download/0/1/D/01DC28EA-638C-4A22-A57B-4CEF97755C6C/WebDeploy_amd64_en-US.msi C:\\install\\webdeploy.msi
ADD https://download.microsoft.com/download/1/2/8/128E2E22-C1B9-44A4-BE2A-5859ED1D4592/rewrite_amd64_en-US.msi C:\\install\\urlrewrite.msi
ADD https://aka.ms/vs/15/release/VC_redist.x64.exe C:\\install\\VC_redist.x64.exe

# Runtime
FROM $BASE_IMAGE

COPY --from=download /install /install

# Install Sitecore dependencies, SIF, apply tweaks and remove default website
RUN $env:INSTALL_TEMP = 'C:\\install'; `
    Start-Process msiexec.exe -ArgumentList '/i', (Join-Path $env:INSTALL_TEMP '\\webdeploy.msi'), '/quiet', '/norestart' -NoNewWindow -Wait; `
    Start-Process msiexec.exe -ArgumentList '/i', (Join-Path $env:INSTALL_TEMP '\\urlrewrite.msi'), '/quiet', '/norestart' -NoNewWindow -Wait; `
    Start-Process (Join-Path $env:INSTALL_TEMP '\\VC_redist.x64.exe') -ArgumentList '/install', '/passive', '/norestart' -NoNewWindow -Wait; `
    Install-PackageProvider -Name NuGet -Force | Out-Null; `
    Register-PSRepository -Name SitecoreGallery -SourceLocation https://sitecore.myget.org/F/sc-powershell/api/v2; `
    Install-Module SitecoreInstallFramework -RequiredVersion 2.0.0 -Force; `
    Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters' -Name ServerPriorityTimeLimit -Value 0 -Type DWord; `
    setx /M PATH $($env:PATH + ';C:\Sitecore\Scripts'); `
    Remove-Website -Name 'Default Web Site'; `
    Remove-Item -Path $env:INSTALL_TEMP -Force -Recurse;
