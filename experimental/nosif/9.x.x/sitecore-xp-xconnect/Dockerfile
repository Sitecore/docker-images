# escape=`
ARG BASE_IMAGE
ARG ASSETS_IMAGE
ARG CERTIFICATES_IMAGE

FROM $ASSETS_IMAGE as assets
FROM $CERTIFICATES_IMAGE as certificates
FROM $BASE_IMAGE as build

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ARG ASSETS_USE_WDP

COPY --from=assets ["${ASSETS_USE_WDP}", "C:\\temp\\packages\\"]

# expand selected wdp into installation directory
RUN Expand-Archive -Path 'C:\\temp\\packages\\*.zip' -DestinationPath 'C:\\temp'; `
    Copy-Item -Path 'C:\\temp\\Content\\Website\\*' -Destination 'C:\\inetpub\\wwwroot' -Recurse -Force;

# configure wwwroot
RUN Remove-Item -Path 'C:\\inetpub\\wwwroot\\App_Data\\jobs' -Force -Recurse; `
    Remove-Item -Path 'C:\\inetpub\\wwwroot\\App_Data\\logs' -Force -Recurse;

# copy tools, certificates and transforms
COPY --from=assets ["C:\\install\\tools\\", "C:\\inetpub\\wwwroot\\temp\\install\\tools\\"]
COPY --from=certificates ["C:\\certificates\\", "C:\\inetpub\\wwwroot\\temp\\install\\certificates\\"]
COPY .\\config\\ C:\\inetpub\\wwwroot\\

# find transform files, replace variables and do transformation
RUN $env:XCONNECT_CLIENT_CERT_THUMBPRINT = (Get-Content -Path 'C:\\inetpub\\wwwroot\\temp\\install\\certificates\\xconnect-client.thumbprint' | Out-String).Trim(); `
    $xdts = [System.Collections.ArrayList]@(); `
    $xdts.AddRange(@(Get-ChildItem -Path 'C:\\inetpub\\wwwroot\\*.xdt')); `
    $xdts.AddRange(@(Get-ChildItem -Path 'C:\\inetpub\\wwwroot\\App_Config\\*.xdt' -Recurse)); `
    $xdts.AddRange(@(Get-ChildItem -Path 'C:\\inetpub\\wwwroot\\App_Data\\*.xdt' -Recurse)); `
    $xdts | ForEach-Object { (Get-Content -Path $_.FullName).Replace('${xconnect_client_certificate_thumbprint}', $env:XCONNECT_CLIENT_CERT_THUMBPRINT) | Out-File -FilePath $_.FullName -Encoding utf8; }; `
    $xdts | ForEach-Object { & 'C:\\inetpub\\wwwroot\\temp\\install\\tools\\scripts\\Invoke-XdtTransform.ps1' -Path $_.FullName.Replace('.xdt', '') -XdtPath $_.FullName -XdtDllPath 'C:\\inetpub\\wwwroot\\temp\\install\\tools\\bin\\Microsoft.Web.XmlTransform.dll'; }; `
    $xdts | ForEach-Object { Remove-Item -Path $_.FullName; };

FROM $BASE_IMAGE

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

COPY --from=build ["C:\\inetpub\\wwwroot\\", "C:\\inetpub\\wwwroot\\"]

RUN $env:INSTALL_TEMP = 'C:\\inetpub\\wwwroot\\temp\\install'; `
    $env:IIS_SITE_NAME = 'Default Web Site'; `
    $env:IIS_APPPOOL_PATH = 'IIS:\AppPools\DefaultAppPool'; `
    $env:XCONNECT_SSL_CERT_NAME = 'xconnect'; `
    Copy-Item -Path (Join-Path $env:INSTALL_TEMP '\\tools') -Destination 'C:\\tools' -Force; `
    setx /M PATH $($env:PATH + ';C:\tools\scripts;C:\tools\bin') | Out-Null; `
    Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters' -Name 'ServerPriorityTimeLimit' -Value 0 -Type DWord; `
    Add-LocalGroupMember -Group 'Performance Monitor Users' -Member 'IIS AppPool\DefaultAppPool'; `
    Import-Module WebAdministration; `
    Set-ItemProperty -Path $env:IIS_APPPOOL_PATH -Name 'processModel.identityType' -Value 'LocalSystem'; `
    $password = ConvertTo-SecureString -String (Get-Content -Path (Join-Path $env:INSTALL_TEMP '\\certificates\\password')) -Force -AsPlainText; `
    Import-PfxCertificate -FilePath (Join-Path $env:INSTALL_TEMP '\\certificates\\sitecore-root.pfx') -CertStoreLocation 'cert:\localmachine\root' -Password $password | Out-Null; `
    Import-PfxCertificate -FilePath (Join-Path $env:INSTALL_TEMP '\\certificates\\sitecore-root.pfx') -CertStoreLocation 'cert:\localmachine\my' -Password $password | Out-Null; `
    Import-PfxCertificate -FilePath (Join-Path $env:INSTALL_TEMP '\\certificates\\xconnect-client.pfx') -CertStoreLocation 'cert:\localmachine\my' -Password $password | Out-Null; `
    $xconnectCert = Import-PfxCertificate -FilePath (Join-Path $env:INSTALL_TEMP '\\certificates\\xconnect.pfx') -CertStoreLocation 'cert:\localmachine\my' -Password $password; `
    New-WebBinding -Name $env:IIS_SITE_NAME -IPAddress '*' -Port '443' -Protocol "https" -HostHeader '*'; `
    $binding = Get-WebBinding -Name $env:IIS_SITE_NAME -Protocol "https"; `
    $binding.AddSslCertificate($xconnectCert.GetCertHashString(), 'my'); `
    Remove-Item -Path $env:INSTALL_TEMP -Force -Recurse;

EXPOSE 443

COPY Boot.ps1  .

ENTRYPOINT ["powershell", "C:\\Boot.ps1", "-LicenseFileTargetPath", "C:\\inetpub\\wwwroot\\App_Data\\license.xml"]