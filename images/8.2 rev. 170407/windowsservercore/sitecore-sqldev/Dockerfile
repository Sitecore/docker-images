# escape=`
ARG BASE_IMAGE

FROM $BASE_IMAGE

ENV ACCEPT_EULA='Y' `
    sa_password='HASH-epsom-sunset-cost7!' `
    INSTALL_PATH='c:/install/' `
    DATA_PATH='c:/data/'

COPY *.zip .

RUN New-Item -Path $env:DATA_PATH -ItemType Directory | Out-Null; `
    Expand-Archive -Path 'C:\Sitecore*.zip' -DestinationPath 'C:'; `
    Remove-Item 'C:\Sitecore*.zip' -Force; `
    Move-Item -Path 'C:\Sitecore *\Databases' -Destination $env:INSTALL_PATH; `
    Remove-Item -Path 'C:\Sitecore *rev*' -Recurse -Force;

COPY Boot.ps1 .

CMD C:/Boot.ps1 -InstallPath $env:INSTALL_PATH -DataPath $env:DATA_PATH
