# escape=`
ARG BASE_IMAGE

FROM $BASE_IMAGE as builder

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ENV sa_password='_' `
    sa_password_path='C:\ProgramData\Docker\secrets\sa-password' `
    attach_dbs='[]' `
    ACCEPT_EULA='_'

COPY . /

RUN [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; `
    Invoke-WebRequest -Uri 'https://go.microsoft.com/fwlink/?linkid=840945' -UseBasicParsing -OutFile 'C:\\SQL.exe'; `
    Invoke-WebRequest -Uri 'https://go.microsoft.com/fwlink/?linkid=840944' -UseBasicParsing -OutFile 'C:\\SQL.box'; `    
    Start-Process -Wait -FilePath .\SQL.exe -ArgumentList /qs, /x:setup; `
    .\setup\setup.exe /q /ACTION=Install /INSTANCENAME=MSSQLSERVER /FEATURES=SQLEngine /UPDATEENABLED=0 /SQLSVCACCOUNT='NT AUTHORITY\System' /SQLSYSADMINACCOUNTS='BUILTIN\ADMINISTRATORS' /TCPENABLED=1 /NPENABLED=0 /IACCEPTSQLSERVERLICENSETERMS; `
    Stop-Service MSSQLSERVER; `
    Set-ItemProperty -Path 'HKLM:\software\microsoft\microsoft sql server\mssql14.MSSQLSERVER\mssqlserver\supersocketnetlib\tcp\ipall' -Name tcpdynamicports -Value ''; `
    Set-ItemProperty -Path 'HKLM:\software\microsoft\microsoft sql server\mssql14.MSSQLSERVER\mssqlserver\supersocketnetlib\tcp\ipall' -Name tcpport -Value 1433; `
    Set-ItemProperty -Path 'HKLM:\software\microsoft\microsoft sql server\mssql14.MSSQLSERVER\mssqlserver' -Name LoginMode -Value 2; `
    Remove-Item -Recurse -Force SQL.exe, SQL.box, setup; `
    Invoke-WebRequest -Uri 'https://dist.nuget.org/win-x86-commandline/v4.1.0/nuget.exe' -UseBasicParsing -OutFile 'C:\\nuget.exe'; `
    New-Item -Path 'C:\\tools' -ItemType Directory | Out-Null; `
    & 'C:\\nuget.exe' install Microsoft.Data.Tools.Msbuild -Version 10.0.61804.210 -OutputDirectory 'C:\\tools'; `
    Remove-Item -Path 'C:\\nuget.exe';

HEALTHCHECK CMD [ "sqlcmd", "-Q", "select 1" ]

CMD .\Start.ps1 -sa_password $env:sa_password -ACCEPT_EULA $env:ACCEPT_EULA -attach_dbs \"$env:attach_dbs\" -Verbose