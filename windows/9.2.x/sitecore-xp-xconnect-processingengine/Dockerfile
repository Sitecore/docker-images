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
    New-Item -Path 'C:\\ProcessingEngine' -ItemType Directory | Out-Null; `
    Copy-Item -Path 'C:\\temp\\Content\\Website\\App_Data\\jobs\\continuous\\ProcessingEngine\\*' -Destination 'C:\\ProcessingEngine' -Recurse -Force;

# copy tools, certificates and transforms
COPY --from=assets ["C:\\install\\tools\\", "C:\\ProcessingEngine\\temp\\install\\tools\\"]
COPY --from=certificates ["C:\\certificates\\", "C:\\ProcessingEngine\\temp\\install\\certificates\\"]
COPY .\\config\\ C:\\ProcessingEngine\\

# find transform files, replace variables and do transformation
RUN $env:XCONNECT_CLIENT_CERT_THUMBPRINT = (Get-Content -Path 'C:\\ProcessingEngine\\temp\\install\\certificates\\xconnect-client.thumbprint' | Out-String).Trim(); `
    $xdts = [System.Collections.ArrayList]@(); `
    $xdts.AddRange(@(Get-ChildItem -Path 'C:\\ProcessingEngine\\App_Config\\*.xdt' -Recurse)); `
    $xdts.AddRange(@(Get-ChildItem -Path 'C:\\ProcessingEngine\\App_Data\\Config\\*.xdt' -Recurse)); `
    $xdts | ForEach-Object { (Get-Content -Path $_.FullName).Replace('${xconnect_client_certificate_thumbprint}', $env:XCONNECT_CLIENT_CERT_THUMBPRINT) | Out-File -FilePath $_.FullName -Encoding utf8; }; `
    $xdts | ForEach-Object { & 'C:\\ProcessingEngine\\temp\\install\\tools\\scripts\\Invoke-XdtTransform.ps1' -Path $_.FullName.Replace('.xdt', '') -XdtPath $_.FullName -XdtDllPath 'C:\\ProcessingEngine\\temp\\install\\tools\\bin\\Microsoft.Web.XmlTransform.dll'; }; `
    $xdts | ForEach-Object { Remove-Item -Path $_.FullName; };

FROM $BASE_IMAGE

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

COPY --from=build ["C:\\ProcessingEngine\\", "C:\\ProcessingEngine\\"]

RUN $env:INSTALL_TEMP = 'C:\\ProcessingEngine\\temp\\install'; `
    # install tools
    Copy-Item -Path (Join-Path $env:INSTALL_TEMP '\\tools') -Destination 'C:\\tools' -Recurse -Force; `
    setx /M PATH $($env:PATH + ';C:\tools\scripts;C:\tools\bin') | Out-Null; `
    # install certificates
    $password = ConvertTo-SecureString -String (Get-Content -Path (Join-Path $env:INSTALL_TEMP '\\certificates\\password')) -Force -AsPlainText; `
    Import-PfxCertificate -FilePath (Join-Path $env:INSTALL_TEMP '\\certificates\\sitecore-root.pfx') -CertStoreLocation 'cert:\localmachine\root' -Password $password | Out-Null; `
    Import-PfxCertificate -FilePath (Join-Path $env:INSTALL_TEMP '\\certificates\\sitecore-root.pfx') -CertStoreLocation 'cert:\localmachine\my' -Password $password | Out-Null; `
    Import-PfxCertificate -FilePath (Join-Path $env:INSTALL_TEMP '\\certificates\\xconnect-client.pfx') -CertStoreLocation 'cert:\localmachine\my' -Password $password | Out-Null; `
    # configure Windows to disable DNS caching
    Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters' -Name 'ServerPriorityTimeLimit' -Value 0 -Type DWord; `
    # delete temporary files
    Remove-Item -Path $env:INSTALL_TEMP -Force -Recurse;

COPY Boot.ps1  .

ENTRYPOINT ["powershell", "C:\\Boot.ps1", "-LicenseFileTargetPath", "C:\\ProcessingEngine\\App_Data\\license.xml"]