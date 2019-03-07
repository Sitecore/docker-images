# escape=`
FROM mcr.microsoft.com/windows/servercore:1709

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

# Download Links:
ENV exe "https://go.microsoft.com/fwlink/?linkid=840945"
ENV box "https://go.microsoft.com/fwlink/?linkid=840944"

ENV sa_password="_" `
    attach_dbs="[]" `
    ACCEPT_EULA="_" `
    sa_password_path="C:\ProgramData\Docker\secrets\sa-password"

# make install files accessible
COPY start.ps1 /
WORKDIR /

RUN Invoke-WebRequest -Uri $env:box -OutFile SQL.box; `
    Invoke-WebRequest -Uri $env:exe -OutFile SQL.exe; `
    Start-Process -Wait -FilePath .\SQL.exe -ArgumentList /qs, /x:setup; `
    .\setup\setup.exe /q /ACTION=Install /INSTANCENAME=MSSQLSERVER /FEATURES=SQLEngine /UPDATEENABLED=0 /SQLSVCACCOUNT='NT AUTHORITY\System' /SQLSYSADMINACCOUNTS='BUILTIN\ADMINISTRATORS' /TCPENABLED=1 /NPENABLED=0 /IACCEPTSQLSERVERLICENSETERMS; `
    Remove-Item -Recurse -Force SQL.exe, SQL.box, setup;

RUN Stop-Service MSSQLSERVER; `
    Set-ItemProperty -Path 'HKLM:\software\microsoft\microsoft sql server\mssql14.MSSQLSERVER\mssqlserver\supersocketnetlib\tcp\ipall' -Name tcpdynamicports -Value ''; `
    Set-ItemProperty -Path 'HKLM:\software\microsoft\microsoft sql server\mssql14.MSSQLSERVER\mssqlserver\supersocketnetlib\tcp\ipall' -Name tcpport -Value 1433; `
    Set-ItemProperty -Path 'HKLM:\software\microsoft\microsoft sql server\mssql14.MSSQLSERVER\mssqlserver' -Name LoginMode -Value 2;

HEALTHCHECK CMD [ "sqlcmd", "-Q", "select 1" ]

# ABOVE HERE SHOULD BE REMOVE WHEN A 1803 VERSION IS RELEASED
ENV ACCEPT_EULA=Y
ENV sa_password='HASH-epsom-sunset-cost7!'
ENV DB_PREFIX='sc'
ENV INSTALL_PATH='c:/install/'
ENV DATA_PATH='c:/data/'

VOLUME ${DATA_PATH}

COPY *.zip .

RUN Expand-Archive -Path 'C:\Sitecore*.zip' -DestinationPath 'C:'; `
    Remove-Item 'C:\Sitecore*.zip' -Force; `
    Move-Item -Path 'C:\Sitecore *\Databases' -Destination $env:INSTALL_PATH; `
    Remove-Item -Path 'C:\Sitecore *rev*' -Recurse -Force;

COPY Boot.ps1 .

CMD C:/Boot.ps1 -InstallPath $env:INSTALL_PATH -DataPath $env:DATA_PATH;