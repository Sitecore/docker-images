# escape=`
ARG BASE_IMAGE
ARG ASSETS_IMAGE

FROM $ASSETS_IMAGE as assets
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

# copy tools and config
COPY --from=assets ["C:\\install\\tools\\", "C:\\inetpub\\wwwroot\\temp\\install\\tools\\"]
COPY .\\config\\ C:\\inetpub\\wwwroot\\

# find transform files and do transformation
RUN $xdts = [System.Collections.ArrayList]@(); `
    $xdts.AddRange(@(Get-ChildItem -Path 'C:\\inetpub\\wwwroot\\*.xdt')); `
    $xdts.AddRange(@(Get-ChildItem -Path 'C:\\inetpub\\wwwroot\\App_Config\\*.xdt' -Recurse)); `
    $xdts.AddRange(@(Get-ChildItem -Path 'C:\\inetpub\\wwwroot\\App_Data\\*.xdt' -Recurse)); `
    $xdts | ForEach-Object { & 'C:\\inetpub\\wwwroot\\temp\\install\\tools\\scripts\\Invoke-XdtTransform.ps1' -Path $_.FullName.Replace('.xdt', '') -XdtPath $_.FullName -XdtDllPath 'C:\\inetpub\\wwwroot\\temp\\install\\tools\\bin\\Microsoft.Web.XmlTransform.dll'; }; `
    $xdts | ForEach-Object { Remove-Item -Path $_.FullName; };

# disable ssl
RUN Remove-Item -Path 'C:\\inetpub\\wwwroot\\App_Data\\Config\\Sitecore\\CoreServices\\sc.XConnect.Security.EnforceSSL.xml'; `
    Remove-Item -Path 'C:\\inetpub\\wwwroot\\App_Data\\Config\\Sitecore\\CoreServices\\sc.XConnect.Security.EnforceSSLWithCertificateValidation.xml';

FROM $BASE_IMAGE

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

# copy from build stage
COPY --from=build ["C:\\inetpub\\wwwroot\\", "C:\\inetpub\\wwwroot\\"]

# copy serilog assemblies
COPY --from=assets ["C:\\install\\bin\\serilog", "C:\\inetpub\\wwwroot\\bin"]

RUN Import-Module WebAdministration; `
    $env:INSTALL_TEMP = 'C:\\inetpub\\wwwroot\\temp\\install'; `
    $env:IIS_SITE_HOMEDIR_PATH = 'C:\\inetpub\\wwwroot'; `
    $env:IIS_APPPOOL_IDENTITY = 'IIS AppPool\DefaultAppPool'; `
    # install tools
    Copy-Item -Path (Join-Path $env:INSTALL_TEMP '\\tools') -Destination 'C:\\' -Recurse -Force; `
    setx /M PATH $($env:PATH + ';C:\tools\scripts;C:\tools\bin') | Out-Null; `
    # configure Windows to disable DNS caching
    Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters' -Name 'ServerPriorityTimeLimit' -Value 0 -Type DWord; `
    # configure app pool group memberships
    Add-LocalGroupMember -Group 'Performance Monitor Users' -Member $env:IIS_APPPOOL_IDENTITY; `
    # configure app pool filesystem permissions
    $rule = New-Object System.Security.AccessControl.FileSystemAccessRule($env:IIS_APPPOOL_IDENTITY, 'FullControl', @('ContainerInherit', 'ObjectInherit'), 'None', 'Allow'); `
    $acl = Get-Acl -Path $env:IIS_SITE_HOMEDIR_PATH; `
    $acl.SetAccessRule($rule); `
    $acl | Set-Acl -Path $env:IIS_SITE_HOMEDIR_PATH; `
    # fix IIS config schema so it understands ASP.NET Configuration Builders correctly, else "WebAdministration" module will break
    '<configSchema><sectionSchema name=\"appSettings\"><attribute name=\"configBuilders\" type=\"string\" /></sectionSchema></configSchema>' | Out-File -FilePath 'C:\\Windows\\System32\\inetsrv\\config\\schema\\FX_schema.patch.xml' -Encoding 'utf8'; `
    # delete temporary files
    Remove-Item -Path $env:INSTALL_TEMP -Force -Recurse;
