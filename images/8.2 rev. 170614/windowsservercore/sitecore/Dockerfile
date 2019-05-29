# escape=`
ARG BASE_IMAGE

FROM $BASE_IMAGE

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

COPY *.zip .

RUN Expand-Archive -Path 'C:\Sitecore*.zip' -DestinationPath 'C:'; `
    Remove-Item 'C:\Sitecore*.zip' -Force; `
    New-Item -Path 'C:\Sitecore' -Type Directory | Out-Null; `
    Move-Item -Path 'C:\Sitecore *\Data' -Destination 'C:\Sitecore'; `
    Move-Item -Path 'C:\Sitecore *\Website' -Destination 'C:\Sitecore'; `
    Remove-Item -Path 'C:\Sitecore\Data\logs' -Recurse -Force; `
    Remove-Item -Path 'C:\Sitecore *rev*' -Recurse -Force;

COPY Sitecore /Sitecore
COPY license.xml /Sitecore/Data

RUN Import-Module WebAdministration; `
    Set-ItemProperty -Path 'IIS:\Sites\Default Web Site' -Name 'physicalPath' -Value 'C:\Sitecore\Website'; `
    Set-ItemProperty -Path 'IIS:\AppPools\DefaultAppPool' -Name 'enable32BitAppOnWin64' -Value 'True'; `
    Set-Itemproperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters' -Name ServerPriorityTimeLimit -Value 0 -Type DWord; `
    setx /M PATH $($env:PATH + ';C:\Sitecore\Scripts');

