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

# copy tools, certificates and transforms
COPY --from=assets ["C:\\install\\tools\\", "C:\\inetpub\\wwwroot\\temp\\install\\tools\\"]
COPY --from=certificates ["C:\\certificates\\", "C:\\inetpub\\wwwroot\\temp\\install\\certificates\\"]
COPY .\\config\\production C:\\inetpub\\wwwroot\\Config\\production\\

# find transform files, replace variables and do transformation
RUN $env:IDENTITY_CLIENT_CERT_THUMBPRINT = (Get-Content -Path 'C:\\inetpub\\wwwroot\\temp\\install\\certificates\\identity-client.thumbprint' | Out-String).Trim(); `
    $xdts = [System.Collections.ArrayList]@(); `
    $xdts.AddRange(@(Get-ChildItem -Path 'C:\\inetpub\\wwwroot\\Config\\production\\*.xml.xdt' -Recurse)); `
    $xdts | ForEach-Object { (Get-Content -Path $_.FullName).Replace('${identity_client_certificate_thumbprint}', $env:IDENTITY_CLIENT_CERT_THUMBPRINT) | Out-File -FilePath $_.FullName -Encoding utf8; }; `
    $xdts | ForEach-Object { & 'C:\\inetpub\\wwwroot\\temp\\install\\tools\\scripts\\Invoke-XdtTransform.ps1' -Path $_.FullName.Replace('.xdt', '') -XdtPath $_.FullName -XdtDllPath 'C:\\inetpub\\wwwroot\\temp\\install\\tools\\bin\\Microsoft.Web.XmlTransform.dll'; }; `
    $xdts | ForEach-Object { Remove-Item -Path $_.FullName; };

# Use custom config that contains custom license file path
COPY .\sitecorehost.xml C:\\inetpub\\wwwroot\\

# add installers
COPY --from=assets ["C:\\install\\setup\\", "C:\\inetpub\\wwwroot\\temp\\install\\setup\\"]

FROM $BASE_IMAGE

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

COPY --from=build ["C:\\inetpub\\wwwroot\\", "C:\\inetpub\\wwwroot\\"]

RUN $env:INSTALL_TEMP = 'C:\\inetpub\\wwwroot\\temp\\install'; `
    $env:IIS_SITE_PATH = 'IIS:\Sites\Default Web Site'; `
    $env:IIS_SITE_HOMEDIR_PATH = 'C:\\inetpub\\wwwroot'; `
    $env:IIS_APPPOOL_IDENTITY = 'IIS AppPool\DefaultAppPool'; `
    # install dependencies
    Start-Process msiexec.exe -ArgumentList '/i', (Join-Path $env:INSTALL_TEMP '\\setup\\urlrewrite.msi'), '/quiet', '/norestart' -NoNewWindow -Wait; `
    Start-Process (Join-Path $env:INSTALL_TEMP '\\setup\\vc_redist.exe') -ArgumentList '/install', '/passive', '/norestart' -NoNewWindow -Wait; `
    Start-Process (Join-Path $env:INSTALL_TEMP '\\setup\\dotnet-hosting.exe') -ArgumentList '/install', '/quiet' -NoNewWindow -Wait; `
    # install tools
    Copy-Item -Path (Join-Path $env:INSTALL_TEMP '\\tools') -Force -Recurse -Destination 'C:\\tools' ; `
    setx /M PATH $($env:PATH + ';C:\tools\scripts;C:\tools\bin;C:\Program Files\dotnet') | Out-Null; `
    # install certificates
    $password = ConvertTo-SecureString -String (Get-Content -Path (Join-Path $env:INSTALL_TEMP '\\certificates\\password')) -Force -AsPlainText; `
    Import-PfxCertificate -FilePath (Join-Path $env:INSTALL_TEMP '\\certificates\\sitecore-root.pfx') -CertStoreLocation 'cert:\localmachine\root' -Password $password | Out-Null; `
    Import-PfxCertificate -FilePath (Join-Path $env:INSTALL_TEMP '\\certificates\\sitecore-root.pfx') -CertStoreLocation 'cert:\localmachine\my' -Password $password | Out-Null; `
    Import-PfxCertificate -FilePath (Join-Path $env:INSTALL_TEMP '\\certificates\\identity-client.pfx') -CertStoreLocation 'cert:\localmachine\my' -Password $password | Out-Null; `
    # configure Windows to disable DNS caching
    Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters' -Name 'ServerPriorityTimeLimit' -Value 0 -Type DWord; `
    # configure app pool group memberships
    Add-LocalGroupMember -Group 'Performance Monitor Users' -Member $env:IIS_APPPOOL_IDENTITY; `
    # configure app pool filesystem permissions
    $rule = New-Object System.Security.AccessControl.FileSystemAccessRule($env:IIS_APPPOOL_IDENTITY, 'FullControl', @('ContainerInherit', 'ObjectInherit'), 'None', 'Allow'); `
    $acl = Get-Acl -Path $env:IIS_SITE_HOMEDIR_PATH; `
    $acl.SetAccessRule($rule); `
    $acl | Set-Acl -Path $env:IIS_SITE_HOMEDIR_PATH; `
    # configure app pool certificate permissions
    $rule = New-Object System.Security.AccessControl.FileSystemAccessRule($env:IIS_APPPOOL_IDENTITY, 'Read', 'None', 'None', 'Allow'); `
    Get-ChildItem -Path 'cert:\localmachine' -Recurse | Where-Object { $_.Issuer -eq 'CN=sitecore-root' -and $_.HasPrivateKey } | ForEach-Object { `
        $path = [IO.Path]::Combine($env:ProgramData, 'Microsoft\Crypto\RSA\MachineKeys', $_.PrivateKey.CspKeyContainerInfo.UniqueKeyContainerName); `
        $acl = Get-Acl -Path $path; `
        $acl.SetAccessRule($rule); `
        $acl | Set-Acl -Path $path; `
    }; `
    # configure SSL binding because Identity Server requires HTTPS (see Sitecore ticket #543325)
    $env:IIS_SITE_NAME = 'Default Web Site'; `
    Import-Module WebAdministration; `
    $identityCert = Import-PfxCertificate -FilePath (Join-Path $env:INSTALL_TEMP '\\certificates\\identity.pfx') -CertStoreLocation 'cert:\localmachine\my' -Password $password; `
    New-WebBinding -Name $env:IIS_SITE_NAME -IPAddress '*' -Port '443' -Protocol "https" -HostHeader '*'; `
    $binding = Get-WebBinding -Name $env:IIS_SITE_NAME -Protocol "https"; `
    $binding.AddSslCertificate($identityCert.GetCertHashString(), 'my'); `
    # configure SSL flags
    Set-WebConfigurationProperty -PSPath 'machine/webroot/apphost' -Filter 'system.webServer/security/access' -Name 'sslFlags' -Value 'SslNegotiateCert'; `
    # delete temporary files
    Remove-Item -Path $env:INSTALL_TEMP -Force -Recurse;