# escape=`
FROM mcr.microsoft.com/windows/servercore:ltsc2019

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

# # Runtime
FROM sitecore-xp-pse-5.0-sqldev:9.1.1-windowsservercore-ltsc2019 as final

HEALTHCHECK CMD [ "sqlcmd", "-Q", "select 1" ]

# # ABOVE HERE SHOULD BE REMOVE WHEN A ltsc2019 VERSION IS RELEASED
ENV ACCEPT_EULA=Y
ENV sa_password='HASH-epsom-sunset-cost7!'
ENV DB_PREFIX='sc'
ENV INSTALL_PATH='c:/install/'
ENV DATA_PATH='c:/data/'
ENV SQL_HOSTNAME='sql'

ADD https://dist.nuget.org/win-x86-commandline/v4.1.0/nuget.exe C:\\Windows\\nuget.exe

RUN New-Item -Path 'C:/tools' -ItemType Directory | Out-Null; `
    & nuget install Microsoft.Data.Tools.Msbuild -Version 10.0.61710.120 -OutputDirectory c:/tools

COPY . ${INSTALL_PATH}

RUN & (Join-Path $env:INSTALL_PATH "\\Extract-Databases.ps1") -Path $env:INSTALL_PATH; `
    & (Join-Path $env:INSTALL_PATH "\\Install-Databases.ps1") -InstallPath $env:INSTALL_PATH -DataPath $env:DATA_PATH -DatabasePrefix $env:DB_PREFIX; ` 
    Move-Item -Path (Join-Path $env:INSTALL_PATH "\\Boot.ps1") -Destination 'C:\\Boot.ps1' -Force; `
    Get-ChildItem -Path $env:INSTALL_PATH -Exclude '*.mdf', '*.ldf' -Recurse -Force | Remove-Item -Recurse -Force; ` 
    Remove-Item -Path 'C:\\tools' -Recurse -Force; 

CMD C:/Boot.ps1 -InstallPath $env:INSTALL_PATH -DataPath $env:DATA_PATH -SqlHostname $env:SQL_HOSTNAME -DatabasePrefix $env:DB_PREFIX;