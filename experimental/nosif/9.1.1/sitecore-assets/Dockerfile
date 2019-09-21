# escape=`
ARG BUILD_IMAGE
ARG BASE_IMAGE

FROM $BUILD_IMAGE as build

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ARG DEV_SITECORE_NET_USERNAME
ARG DEV_SITECORE_NET_PASSWORD

# download assets
COPY Start-Download.ps1 .
COPY assets.json .
RUN & 'C:\\Start-Download.ps1' -Path 'C:\\assets.json' -Destination 'C:\\install' -SitecoreUsername $env:DEV_SITECORE_NET_USERNAME -SitecorePassword $env:DEV_SITECORE_NET_PASSWORD;

# install 7zip
RUN New-Item -Path 'C:\\install\\tools\\bin\\7zip' -ItemType 'Directory' -Force | Out-Null; `
    & 'C:\\install\\7z-installer.exe' /S /D='C:\\install\\tools\\bin\\7zip\\';

# verify assets
RUN Get-ChildItem -Path 'C:\\install\\*.zip' | ForEach-Object { & 'C:\\install\\tools\\bin\\7zip\\7z.exe' t $_.FullName -r }

# install nuget
RUN Move-Item -Path 'C:\\install\\nuget.exe' -Destination 'C:\\install\\tools\\bin' -Force;

# install microsoft xdt assembly
RUN & 'C:\\install\\tools\\bin\\nuget.exe' install 'Microsoft.Web.Xdt' -Version '3.0.0' -OutputDirectory 'C:\\install'; `
    Copy-Item -Path 'C:\\install\\Microsoft.Web.Xdt*\\lib\\netstandard2.0\\*.dll' -Destination 'C:\\install\\tools\\bin'; `
    Remove-Item -Path (Get-Item -Path 'C:\\install\\Microsoft.Web.Xdt*\\').FullName -Recurse -Force;

# extract assets, skip wdps, move already extracted wdps
RUN $zips = Get-ChildItem -Path 'C:\\install\\*.zip' -Exclude '*.scwdp.zip'; `
    $zips | ForEach-Object { Expand-Archive -Path $_.FullName -DestinationPath 'C:\\install\\packages' -Force; }; `
    $zips | ForEach-Object { Remove-Item -Path $_.FullName -Force; }; `
    $zips = Get-ChildItem -Path 'C:\\install\\*.zip'; `
    $zips | ForEach-Object { Move-Item -Path $_.FullName -Destination 'C:\\install\\packages'; }; `
    Remove-Item -Path 'C:\\install\\packages\\*Configuration files*.zip';

# move installers
RUN New-Item -Path 'C:\\install\\setup' -ItemType 'Directory' -Force | Out-Null; `
    Get-ChildItem 'C:\\install\\*.*' -Include '*.exe', '*.msi' | Move-Item -Destination 'C:\\install\\setup';

# add tools folder
COPY tools C:\\install\\tools

FROM $BASE_IMAGE

COPY --from=build ["C:\\install\\", "C:\\install\\"]