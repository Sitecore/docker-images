# escape=`
ARG BUILD_IMAGE
ARG BASE_IMAGE

FROM $BUILD_IMAGE as build

ADD https://dist.nuget.org/win-x86-commandline/v5.2.0/nuget.exe C:\\install\\nuget.exe

FROM $BASE_IMAGE

COPY --from=build ["/install/nuget.exe", "/tools/"]

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

RUN Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters' -Name ServerPriorityTimeLimit -Value 0 -Type DWord;