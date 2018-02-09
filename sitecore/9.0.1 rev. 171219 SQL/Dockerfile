# escape=`
FROM microsoft/mssql-server-windows-developer:2016-sp1

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ENV ACCEPT_EULA=Y
ENV sa_password=HASH-epsom-sunset-cost7!
ENV SITENAME='sc'
ENV INSTALL_PATH='c:/install/'
ENV DATA_PATH='c:/data/'

ADD *.zip ${INSTALL_PATH}
ADD Extract-Databases.ps1 ${INSTALL_PATH}

RUN & (Join-Path $env:INSTALL_PATH "Extract-Databases.ps1") -Path $env:INSTALL_PATH; `
    Get-ChildItem -Path $env:INSTALL_PATH -Exclude "*.dacpac" | Remove-Item -Force;

VOLUME ${DATA_PATH}

ADD Boot.ps1 .

CMD C:/Boot.ps1 -InstallPath $env:INSTALL_PATH -DataPath $env:DATA_PATH -DatabasePrefix $env:SITENAME