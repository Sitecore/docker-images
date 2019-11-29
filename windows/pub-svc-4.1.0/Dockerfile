# escape=`
ARG BASE_IMAGE

FROM mcr.microsoft.com/dotnet/framework/aspnet:4.8

ARG PUBLISHING_SITE_NAME=sitecore.publishing
ENV INSTALL_PATH="c:\\install"
ARG PUBLISHING_PACKAGE="Sitecore Publishing Service 4.1.0-x64.zip"
ARG PUBLISHING_PACKAGE_PATH=${INSTALL_PATH}\\${PUBLISHING_PACKAGE}
ENV DOTNETCOREHOSTING_EXE=${INSTALL_PATH}\\DotNetCore.1.1.0-WindowsHosting.exe
ADD https://aka.ms/dotnetcore_windowshosting_1_1_0 ${DOTNETCOREHOSTING_EXE}

SHELL ["powershell", "-NoProfile", "-Command", "$ErrorActionPreference = 'Stop';"]

RUN Start-Process $env:DOTNETCOREHOSTING_EXE -ArgumentList '/install', '/passive', '/norestart' -NoNewWindow -Wait; 

RUN Import-Module ServerManager; `
	Add-WindowsFeature Web-Scripting-Tools; `
	Remove-Website -Name 'Default Web Site';

COPY . ${INSTALL_PATH}

WORKDIR "C:\\inetpub\\wwwroot\\publisher"

RUN	Expand-Archive -Path $env:PUBLISHING_PACKAGE_PATH -DestinationPath .; 

RUN $args = 'iis install --sitename ' + $env:PUBLISHING_SITE_NAME + ' --apppool ' + $env:PUBLISHING_SITE_NAME; `
	Start-Process "Sitecore.Framework.Publishing.Host.exe" -ArgumentList $args -NoNewWindow -Wait; 

EXPOSE 80
