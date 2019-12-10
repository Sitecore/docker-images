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
COPY .\\assets C:\\inetpub\\wwwroot\\assets\\

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
    # install tools
    Copy-Item -Path (Join-Path $env:INSTALL_TEMP '\\tools') -Destination 'C:\\tools' -Recurse -Force; `
    setx /M PATH $($env:PATH + ';C:\tools\scripts;C:\tools\bin') | Out-Null; `
    # install certificates
    $password = ConvertTo-SecureString -String (Get-Content -Path (Join-Path $env:INSTALL_TEMP '\\certificates\\password')) -Force -AsPlainText; `
    Import-PfxCertificate -FilePath (Join-Path $env:INSTALL_TEMP '\\certificates\\sitecore-root.pfx') -CertStoreLocation 'cert:\localmachine\root' -Password $password | Out-Null; `
    Import-PfxCertificate -FilePath (Join-Path $env:INSTALL_TEMP '\\certificates\\sitecore-root.pfx') -CertStoreLocation 'cert:\localmachine\my' -Password $password | Out-Null; `
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
    # delete temporary files
    Remove-Item -Path $env:INSTALL_TEMP -Force -Recurse;
