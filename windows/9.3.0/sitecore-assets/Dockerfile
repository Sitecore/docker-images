# escape=`
ARG BUILD_IMAGE
ARG BASE_IMAGE

FROM $BUILD_IMAGE as build

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

# download remote assets
RUN New-Item -Path 'C:\\downloads' -ItemType 'Directory' -Force | Out-Null; `
    & curl.exe -sS -L -o c:\\downloads\\nuget.exe https://dist.nuget.org/win-x86-commandline/v5.2.0/nuget.exe; `
    & curl.exe -sS -L -o C:\\downloads\\urlrewrite.msi https://download.microsoft.com/download/1/2/8/128E2E22-C1B9-44A4-BE2A-5859ED1D4592/rewrite_amd64_en-US.msi; `
    & curl.exe -sS -L -o C:\\downloads\\vc_redist.exe https://aka.ms/vs/15/release/VC_redist.x64.exe; `
    & curl.exe -sS -L -o C:\\downloads\\7z-installer.exe https://www.7-zip.org/a/7z1900-x64.exe; `
    & curl.exe -sS -L -o C:\\downloads\\filebeat.zip https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-7.4.1-windows-x86_64.zip; `
    & curl.exe -sS -L -o C:\\downloads\\dotnet-hosting.exe https://download.visualstudio.microsoft.com/download/pr/34f4b2a6-c3b8-495c-a11f-6db955f27757/8c340c1a8c25966e39e0c0a4b308dff4/dotnet-hosting-2.2.5-win.exe;

# copy local assets
COPY *.zip C:\\downloads\\

# install 7zip
RUN New-Item -Path 'C:\\install\\tools\\bin\\7zip' -ItemType 'Directory' -Force | Out-Null; `
    & 'C:\\downloads\\7z-installer.exe' /S /D='C:\\install\\tools\\bin\\7zip\\';

# verify assets
RUN Get-ChildItem -Path 'C:\\downloads\\*.zip' | ForEach-Object { & 'C:\\install\\tools\\bin\\7zip\\7z.exe' t $_.FullName -r }

# install nuget
RUN Move-Item -Path 'C:\\downloads\\nuget.exe' -Destination 'C:\\install\\tools\\bin' -Force;

# install microsoft xdt assembly
RUN & 'C:\\install\\tools\\bin\\nuget.exe' install 'Microsoft.Web.Xdt' -Version '3.0.0' -OutputDirectory 'C:\\install'; `
    Copy-Item -Path 'C:\\install\\Microsoft.Web.Xdt*\\lib\\netstandard2.0\\*.dll' -Destination 'C:\\install\\tools\\bin'; `
    Remove-Item -Path (Get-Item -Path 'C:\\install\\Microsoft.Web.Xdt*\\').FullName -Recurse -Force;

# extract filebeat
RUN Expand-Archive -Path 'C:\\downloads\\filebeat.zip' -DestinationPath 'C:\\install\\tools\\bin' -Force; `
    Rename-Item -Path (Get-Item -Path 'C:\\install\\tools\\bin\\filebeat*windows*').FullName -NewName "filebeat"; `
    Remove-Item -Path 'C:\\downloads\\filebeat.zip' -Force;

# extract assets, skip wdps, move already extracted wdps
RUN $zips = Get-ChildItem -Path 'C:\\downloads\\*.zip' -Exclude @('*.scwdp.zip', '*win-x64*'); `
    $zips | ForEach-Object { Expand-Archive -Path $_.FullName -DestinationPath 'C:\\packages' -Force; }; `
    $zips | ForEach-Object { Remove-Item -Path $_.FullName -Force; }; `
    $zips = Get-ChildItem -Path 'C:\\downloads\\*.zip' -Exclude '*Configuration files*.zip'; `
    $zips | ForEach-Object { Move-Item -Path $_.FullName -Destination 'C:\\packages'; }; `
    $zips = Get-ChildItem -Path 'C:\\packages\\*.scwdp.zip' | Rename-Item -NewName {$_.Name -replace '.rev\..(\d*)|(r[0-9]+.[0-9]+)'};

# move installers
RUN New-Item -Path 'C:\\install\\setup' -ItemType 'Directory' -Force | Out-Null; `
    Get-ChildItem 'C:\\downloads\\*.*' -Include '*.exe', '*.msi' | Move-Item -Destination 'C:\\install\\setup';

# add tools folder
COPY tools\\ C:\\install\\tools\\

FROM $BASE_IMAGE

COPY --from=build ["C:\\install\\", "C:\\install\\"]
COPY --from=build ["C:\\packages\\", "C:\\packages\\"]