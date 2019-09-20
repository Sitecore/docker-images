# escape=`
ARG BASE_IMAGE

FROM $BASE_IMAGE as build

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ARG DEV_SITECORE_NET_USERNAME
ARG DEV_SITECORE_NET_PASSWORD

# download installers
ADD https://dist.nuget.org/win-x86-commandline/v5.2.0/nuget.exe C:\\install\\tools\\bin\\nuget.exe
ADD https://download.microsoft.com/download/1/2/8/128E2E22-C1B9-44A4-BE2A-5859ED1D4592/rewrite_amd64_en-US.msi C:\\install\\setup\\urlrewrite.msi
ADD https://aka.ms/vs/15/release/VC_redist.x64.exe C:\\install\\setup\\vc_redist.exe
ADD https://www.7-zip.org/a/7z1900-x64.exe C:\\temp\\7z-installer.exe

# download packages from dev.sitecore.net
COPY Download-Packages.ps1 .
COPY sitecore-packages.json .
RUN & 'C:\\Download-Packages.ps1' -Path 'C:\\sitecore-packages.json' -Destination 'C:\\install' -SitecoreUsername $env:DEV_SITECORE_NET_USERNAME -SitecorePassword $env:DEV_SITECORE_NET_PASSWORD;

# install tools
RUN & 'C:\\install\\tools\\bin\\nuget.exe' install 'Microsoft.Web.Xdt' -Version '3.0.0' -OutputDirectory 'C:\\install'; `
    Copy-Item -Path 'C:\\install\\Microsoft.Web.Xdt*\\lib\\netstandard2.0\\*.dll' -Destination 'C:\\install\\tools\\bin'; `
    Remove-Item -Path (Get-Item -Path 'C:\\install\\Microsoft.Web.Xdt*\\').FullName -Recurse -Force; `
    & 'C:\\temp\\7z-installer.exe' /S /D='C:\\temp\\7zip\\';

# verify packages
RUN Get-ChildItem -Path 'C:\\install\*.zip' | ForEach-Object { & 'C:\\temp\\7zip\\7z.exe' t $_.FullName -r }

# extract packages
RUN $zips = Get-ChildItem -Path 'C:\\install\\*.zip'; `
    $zips | ForEach-Object { Expand-Archive -Path $_.FullName -DestinationPath ('C:\\install\\packages\\{0}' -f ($_.BaseName)) -Force; }; `
    $zips | ForEach-Object { Remove-Item -Path $_.FullName -Force; };
    
# add license and scripts
COPY license.xml C:\\install\\license\\
COPY scripts\*.ps1 C:\\install\\tools\\scripts\\

FROM $BASE_IMAGE

COPY --from=build ["C:\\install\\", "C:\\install\\"]