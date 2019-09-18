# escape=`
ARG BUILD_IMAGE
ARG BASE_IMAGE

FROM $BUILD_IMAGE as build

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ADD https://dist.nuget.org/win-x86-commandline/v5.2.0/nuget.exe C:\\install\\tools\\bin\\nuget.exe
ADD https://download.microsoft.com/download/1/2/8/128E2E22-C1B9-44A4-BE2A-5859ED1D4592/rewrite_amd64_en-US.msi C:\\install\\urlrewrite.msi
ADD https://aka.ms/vs/15/release/VC_redist.x64.exe C:\\install\\vc_redist.exe

COPY *.ps1 C:\\install\\tools\\scripts\\

RUN & 'C:\\install\\tools\\bin\\nuget.exe' install 'Microsoft.Web.Xdt' -Version '3.0.0' -OutputDirectory 'C:\\install'; `
    Copy-Item -Path 'C:\\install\\Microsoft.Web.Xdt*\\lib\\netstandard2.0\\*.dll' -Destination 'C:\\install\\tools\\bin';

FROM $BASE_IMAGE

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

COPY --from=build ["/install/", "/install/"]

RUN $env:INSTALL_TEMP = 'C:\\install'; `
    $env:TOOLS_PATH = 'C:\\tools'; `
    Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters' -Name 'ServerPriorityTimeLimit' -Value 0 -Type DWord; `
    Start-Process msiexec.exe -ArgumentList '/i', (Join-Path $env:INSTALL_TEMP '\\urlrewrite.msi'), '/quiet', '/norestart' -NoNewWindow -Wait; `
    Start-Process (Join-Path $env:INSTALL_TEMP '\\vc_redist.exe') -ArgumentList '/install', '/passive', '/norestart' -NoNewWindow -Wait; `
    New-Item -Path $env:TOOLS_PATH -ItemType 'Directory' | Out-Null; `
    Copy-Item -Path (Join-Path $env:INSTALL_TEMP '\\tools\\*') -Destination $env:TOOLS_PATH -Recurse; `
    setx /M PATH $($env:PATH + ';C:\tools\scripts;C:\tools\bin'); `
    Remove-Item -Path $env:INSTALL_TEMP -Force -Recurse;
