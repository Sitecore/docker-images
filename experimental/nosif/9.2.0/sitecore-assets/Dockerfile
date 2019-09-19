# escape=`
ARG BASE_IMAGE

FROM $BASE_IMAGE

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ADD https://dist.nuget.org/win-x86-commandline/v5.2.0/nuget.exe C:\\install\\tools\\bin\\nuget.exe
ADD https://download.microsoft.com/download/1/2/8/128E2E22-C1B9-44A4-BE2A-5859ED1D4592/rewrite_amd64_en-US.msi C:\\install\\setup\\urlrewrite.msi
ADD https://aka.ms/vs/15/release/VC_redist.x64.exe C:\\install\\setup\\vc_redist.exe

COPY license.xml C:\\install\\license\\
COPY *.ps1 C:\\install\\tools\\scripts\\

RUN & 'C:\\install\\tools\\bin\\nuget.exe' install 'Microsoft.Web.Xdt' -Version '3.0.0' -OutputDirectory 'C:\\install'; `
    Copy-Item -Path 'C:\\install\\Microsoft.Web.Xdt*\\lib\\netstandard2.0\\*.dll' -Destination 'C:\\install\\tools\\bin'; `
    Remove-Item -Path (Get-Item -Path 'C:\\install\\Microsoft.Web.Xdt*\\').FullName -Recurse -Force; 

# TODO: Consider to download from dev.sitecore.net, pass in secrets with build args...

COPY *.zip C:\\install\\

RUN $zips = Get-ChildItem -Path 'C:\\install\\*.zip'; `
    $zips | ForEach-Object { Expand-Archive -Path $_.FullName -DestinationPath ('C:\\install\\packages\\{0}' -f ($_.BaseName)) -Force; }; `
    $zips | ForEach-Object { Remove-Item -Path $_.FullName -Force; }; `
    Get-ChildItem -Path 'C:\\install\\' -File -Recurse | ForEach-Object { $_.FullName };