# escape=`
ARG BASE_IMAGE

FROM $BASE_IMAGE

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ENV sa_password='_' `
    sa_password_path='C:\ProgramData\Docker\secrets\sa-password' `
    attach_dbs='[]' `
    ACCEPT_EULA='_'

RUN [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; `
    New-Item -Path 'C:\\install' -ItemType 'Directory' | Out-Null; `
    Invoke-WebRequest -Uri 'https://go.microsoft.com/fwlink/?linkid=840945' -UseBasicParsing -OutFile 'C:\\install\\SQL.exe'; `
    Invoke-WebRequest -Uri 'https://go.microsoft.com/fwlink/?linkid=840944' -UseBasicParsing -OutFile 'C:\\install\\SQL.box'; `
    Start-Process -FilePath 'C:\\install\\SQL.exe' -ArgumentList '/qs', '/x:C:\install\setup' -NoNewWindow -Wait; `
    Start-Process -FilePath 'C:\\install\\setup\\setup.exe' -ArgumentList '/q', '/ACTION=Install', '/INSTANCENAME=MSSQLSERVER', '/FEATURES=SQLEngine', '/UPDATEENABLED=0', '/SQLSVCACCOUNT=\"NT AUTHORITY\System\"', '/SQLSYSADMINACCOUNTS=\"BUILTIN\ADMINISTRATORS\"', '/TCPENABLED=1', '/NPENABLED=0', '/IACCEPTSQLSERVERLICENSETERMS' -NoNewWindow -Wait; `
    Stop-Service MSSQLSERVER; `
    Set-ItemProperty -Path 'HKLM:\software\microsoft\microsoft sql server\mssql14.MSSQLSERVER\mssqlserver\supersocketnetlib\tcp\ipall' -Name 'tcpdynamicports' -Value ''; `
    Set-ItemProperty -Path 'HKLM:\software\microsoft\microsoft sql server\mssql14.MSSQLSERVER\mssqlserver\supersocketnetlib\tcp\ipall' -Name 'tcpport' -Value 1433; `
    Set-ItemProperty -Path 'HKLM:\software\microsoft\microsoft sql server\mssql14.MSSQLSERVER\mssqlserver' -Name 'LoginMode' -Value 2; `
    Invoke-WebRequest -Uri 'https://download.microsoft.com/download/9/2/2/9228AAC2-90D1-4F48-B423-AF345296C7DD/EN/x64/DacFramework.msi' -UseBasicParsing -OutFile 'C:\\install\\DacFramework.msi'; `
    Start-Process -FilePath 'msiexec.exe' -ArgumentList '/i', 'C:\\install\\DacFramework.msi', '/quiet', '/norestart' -NoNewWindow -Wait; `
    Remove-Item -Path 'C:\\install' -Recurse -Force;

COPY Start.ps1 .

HEALTHCHECK CMD [ "sqlcmd", "-Q", "select 1" ]

CMD .\Start.ps1 -sa_password $env:sa_password -ACCEPT_EULA $env:ACCEPT_EULA -attach_dbs \"$env:attach_dbs\" -Verbose