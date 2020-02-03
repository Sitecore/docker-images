# escape=`
ARG BASE_IMAGE
FROM $BASE_IMAGE

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

COPY .\\config\\production C:\\inetpub\\wwwroot\\Config\\production\\
