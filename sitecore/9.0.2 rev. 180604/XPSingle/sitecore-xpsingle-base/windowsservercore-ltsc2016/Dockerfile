# escape=`
FROM microsoft/mssql-server-windows-express:2016-sp1-windowsservercore-10.0.14393.1715

#BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB
#
#	Global Definitions
#
#--------------------------------------------------------------------------------------------------------------------------

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

# RELEASE: Use next line for image release (reduce number of layers). See "DEBUG" comments below
ENV `
	INSTALL_PATH="c:\Install" `
	ACCEPT_EULA="Y" `
	sa_password="HASH-epsom-sunset-cost7!" `
	JAVA_HOME="c:\Java\jre" `
	SOLR_URL="https://solr:8983/solr" `
	SOLR_SERVICE_NAME="Solr-6.6.2" `
	SOLR_ROOT="c:\Solr\solr-6.6.2" 

# RELEASE: Use next line for image release (reduce number of layers). See "DEBUG" comments below
COPY /InternalAssets/ ${INSTALL_PATH}/

## DEBUG: Use next line for image debug (use additional layers to speed up debugging process by using docker cache). See "RELEASE" comments above
#ENV `
#	INSTALL_PATH="c:\Install" `
#
	
# RELEASE: Use next line for image release (reduce number of layers). See "DEBUG" comments below
RUN	`
`
<####################################################################################################################### `
`
	SQL Server `
`
------------------------------------------------------------------------------------------------------------------------#> `
`
<## DEBUG: Use next line for image debug (use additional layers to speed up debugging process by using docker cache). See "RELEASE" comments above `
ENV ACCEPT_EULA="Y" `
	sa_password="HASH-epsom-sunset-cost7!" `
#> `
`
<# SQL Server Configuration: ............................................................................ #> `
	`
	Write-Host 'Changing SA login credentials' ; `
	$sql = 'ALTER LOGIN sa with password=N'''+ $env:sa_password +'''; ALTER LOGIN sa ENABLE;' ; `
	Invoke-Sqlcmd -Query $sql ; `
`
`
`	
<####################################################################################################################### `
`
	IIS, IIS Modules and Other Dependencies `
`
------------------------------------------------------------------------------------------------------------------------#> `
`
<#RUN #> `
`
<# Install IIS Modules and Other Dependencies: ............................................................................ #> `
	`
	<# Add IIS and .NET 4.5 features https://github.com/pbering/Socker/blob/master/images/sitecore-iis/Dockerfile #> `
	Add-WindowsFeature Web-Server; `
    Add-WindowsFeature NET-Framework-45-ASPNET; `
    Add-WindowsFeature Web-Asp-Net45; `
    Set-Itemproperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters' -Name ServerPriorityTimeLimit -Value 0 -Type DWord; `
	`
	<# WebDeploy #> `
	$url = 'http://download.microsoft.com/download/0/1/D/01DC28EA-638C-4A22-A57B-4CEF97755C6C/WebDeploy_amd64_en-US.msi' ; `
	Invoke-WebRequest -Uri $url -OutFile webdeploy.msi ; `
    Start-Process msiexec.exe -ArgumentList '/i', webdeploy.msi, '/quiet', '/norestart' -NoNewWindow -Wait ; `
	Remove-Item -Recurse -Force webdeploy.msi ; `
	`
	<# IIS URL Rewrite #> `
	$url = 'http://download.microsoft.com/download/D/D/E/DDE57C26-C62C-4C59-A1BB-31D58B36ADA2/rewrite_amd64_en-US.msi' ; `
	Invoke-WebRequest -Uri $url -OutFile urlrewrite.msi ; `
    Start-Process msiexec.exe -ArgumentList '/i', urlrewrite.msi, '/quiet', '/norestart' -NoNewWindow -Wait ; `
	Remove-Item -Recurse -Force urlrewrite.msi ; `
    `
    <# Microsoft Visual C++ 2015 Redistributable #> `
	$url = 'https://aka.ms/vs/15/release/VC_redist.x64.exe' ; `
	Invoke-WebRequest -Uri $url -OutFile vcredist.exe ; `
    Start-Process vcredist.exe -ArgumentList '/install', '/passive', '/norestart' -NoNewWindow -Wait ; `
	Remove-Item -Recurse -Force vcredist.exe ; `
	`
    <# Sitecore Install Framework dependencies #> `
    Import-Module IISAdministration ; `
    Import-Module WebAdministration ; `
	`
    <# Sitecore Installation Framework (SIF) #> `
    Install-PackageProvider -Name NuGet -Force | Out-Null ; `
    Register-PSRepository -Name SitecoreGallery -SourceLocation https://sitecore.myget.org/F/sc-powershell/api/v2 ; `
    Install-Module SitecoreInstallFramework -RequiredVersion 1.2.1 -Force ; `
	`
    <# Service Monitor #> `
	$url = 'https://dotnetbinaries.blob.core.windows.net/servicemonitor/2.0.1.3/ServiceMonitor.exe' ; `
	Invoke-WebRequest -Uri $url -OutFile C:\ServiceMonitor.exe ; `
	`
    <# Clean up #> `
	Remove-Website -Name 'Default Web Site' ; `
	`
    Write-Host 'Install IIS Modules and Other Dependencies ended...................................................................' ; `
`
`
<## DEBUG: Use next line for image debug (use additional layers to speed up debugging process by using docker cache). See "RELEASE" comments above `
ENTRYPOINT ["C:\\ServiceMonitor.exe", "w3svc"] `
#> `
`
<####################################################################################################################### `
`
	Java and Solr `
`
------------------------------------------------------------------------------------------------------------------------#> `
`
<## DEBUG: Use next line for image debug (use additional layers to speed up debugging process by using docker cache). See "RELEASE" comments above `
ENV `
	JAVA_HOME="c:\Java\jre" `
	SOLR_URL="https://solr:8983/solr" `
	SOLR_SERVICE_NAME="Solr-6.6.2" `
	SOLR_ROOT="c:\Solr\solr-6.6.2" `
`
COPY ./InternalAssets/solr ${INSTALL_PATH}/solr/ `
#> `
`
<#RUN #> `
	`
	<# Java #> `
	Write-Host 'Start: Downloading Java' ; `
	Invoke-WebRequest -Method Get -Uri http://javadl.oracle.com/webapps/download/AutoDL?BundleId=210185 -OutFile /jreinstaller.exe ; `
	Write-Host 'End: Downloading Java' ; `
	Write-Host 'Start: Installing Java' ; `
    Start-Process -FilePath C:\jreinstaller.exe -PassThru -wait -ArgumentList "/s,INSTALLDIR=c:\Java\jre"; `
	Write-Host 'Deleting Java setup file.' ; `
 	Remove-Item -Recurse -Force C:\jreinstaller.exe ; `
	Write-Host 'End: Installing Java' ; `
	Write-Host 'Start: Updating PATH environment variable' ; `
	$newPath = Join-Path $env:JAVA_HOME 'bin' ; `
	$newPath = '{0};{1}' -f $env:JAVA_HOME, $newPath ; `
	$env:PATH = '{0};{1}' -f $newPath, $env:PATH ; `
	[Environment]::SetEnvironmentVariable('PATH', $env:PATH, 'Machine') ; `
	Write-Host 'End: Updating PATH environment variable' ; `
	`
	<# Solr #> `
	Set-Location -Path (Join-Path $env:INSTALL_PATH 'solr') ; `
	Write-Host 'Start: Installing Solr' ; `
	./install-solr.ps1 -downloadFolder $env:INSTALL_PATH; `
	Write-Host 'End: Installing Solr' ; `
	`
	<# Clean-up #> `
	Set-Location -Path 'C:\' ; `
	Remove-Item (Join-Path $env:INSTALL_PATH 'solr') -Force -Recurse; `
;

#<####################################################################################################################### `
#`
#	.NET Core And .NET Core Windows Hosting `
#`
#------------------------------------------------------------------------------------------------------------------------#> `

RUN `
`
<# Install .NET Core And .NET Core Windows Hosting: ............................................................................ #> `
	`
	<# .NET Core #> `
	[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 ; `
	$url = 'https://dot.net/v1/dotnet-install.ps1' ; `
	Invoke-WebRequest -Uri $url -OutFile dotnet-install.ps1 ; `
	$netCorePath = Join-Path $env:ProgramFiles dotnet ; `
	./dotnet-install.ps1 -Channel 2.0 -InstallDir $netCorePath -Architecture x64; `
 	Remove-Item -Recurse -Force dotnet-install.ps1 ; `
 	[Environment]::SetEnvironmentVariable('PATH', ('{0};{1}' -f $netCorePath, $env:PATH), 'Machine') ; `
	`
	<# .NET Core Windows Hosting #> `
	$url = 'https://download.microsoft.com/download/A/9/F/A9F8872C-48B2-41DB-8AAD-D5908D988592/DotNetCore.2.0.7-WindowsHosting.exe' ; `
	Invoke-WebRequest -Uri $url -OutFile WindowsHosting.exe ; `
    Start-Process WindowsHosting.exe -ArgumentList '/quiet', '/install', '//log', log.txt -NoNewWindow -Wait ; `
 	Remove-Item -Recurse -Force WindowsHosting.exe ; `
    Start-Sleep -Seconds 10; `
	net stop was /y; `
    net start w3svc; `
	`
    Write-Host 'Install .NET Core And .NET Core Windows Hosting ended...................................................................' ; `
;

#BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB
#
#	Docker Image Metadata
#
#--------------------------------------------------------------------------------------------------------------------------

# TODO: Implement HEALTHCHECK
# SQL
#HEALTHCHECK CMD [ "sqlcmd", "-Q", "select 1" ]
# Solr
#HEALTHCHECK CMD powershell -command `
#    try { `
#        $response = Invoke-WebRequest $env:SOLR_URL -UseBasicParsing ; `
#        if ($response.StatusCode -eq 200) { return 0} else {return 1} ; `
#    } catch { return 1 }


# RELEASE: Use next line for image release (reduce number of layers). See "DEBUG" comments below
ENTRYPOINT ["C:\\ServiceMonitor.exe", "w3svc"]

# IIS: 80, 443
# Solr: 8983
# SQL: 1433
EXPOSE 80 443 8983 1433

