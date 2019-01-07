# escape=`
FROM microsoft/mssql-server-windows-developer:2016-sp1

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ENV ACCEPT_EULA=Y
ENV sa_password=HASH-epsom-sunset-cost7!
ENV DB_PREFIX='sc'
ENV INSTALL_PATH='c:/install/'
ENV DATA_PATH='c:/data/'

VOLUME ${DATA_PATH}

COPY /InternalAssets /ExternalAssets ${INSTALL_PATH}/

RUN if (!(Test-Path -Path $env:DATA_PATH -PathType Container)){ ` 
		New-Item -ItemType Directory -Force -Path $env:DATA_PATH; `
	}; `
	& (Join-Path $env:INSTALL_PATH 'Install-Databases.ps1') -InstallPath $env:INSTALL_PATH -DataPath $env:DATA_PATH -DatabasePrefix $env:DB_PREFIX; `
	`
	Write-Host 'Changing SA login credentials' ; `
	$sql = 'ALTER LOGIN sa with password=N'''+ $env:sa_password +'''; ALTER LOGIN sa ENABLE;' ; `
	Invoke-Sqlcmd -Query $sql ; `
	`
	Copy-Item (Join-Path $env:INSTALL_PATH Boot.ps1) C:\\; `
	Remove-Item $env:INSTALL_PATH/*.dacpac; `
	Remove-Item $env:INSTALL_PATH/*.ps1;

CMD .\\Boot.ps1 -InstallPath $env:INSTALL_PATH -DataPath $env:DATA_PATH

