# escape=`
ARG BUILD_IMAGE
ARG BASE_IMAGE

FROM $BUILD_IMAGE as build

ADD https://dist.nuget.org/win-x86-commandline/v5.2.0/nuget.exe C:\\install\\nuget.exe
ADD https://download.microsoft.com/download/1/2/8/128E2E22-C1B9-44A4-BE2A-5859ED1D4592/rewrite_amd64_en-US.msi C:\\install\\urlrewrite.msi
ADD https://aka.ms/vs/15/release/VC_redist.x64.exe C:\\install\\vc_redist.exe

FROM $BASE_IMAGE

COPY --from=build ["/install/", "/install/"]

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

RUN $env:INSTALL_TEMP = 'C:\\install'; `
    Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters' -Name ServerPriorityTimeLimit -Value 0 -Type DWord; `
    Start-Process msiexec.exe -ArgumentList '/i', (Join-Path $env:INSTALL_TEMP '\\urlrewrite.msi'), '/quiet', '/norestart' -NoNewWindow -Wait; `
    Start-Process (Join-Path $env:INSTALL_TEMP '\\vc_redist.exe') -ArgumentList '/install', '/passive', '/norestart' -NoNewWindow -Wait; `
    Copy-Item -Path (Join-Path $env:INSTALL_TEMP '\\nuget.exe') -Destination "C:\\tools" -Force; `
    Remove-Item -Path $env:INSTALL_TEMP -Force -Recurse;