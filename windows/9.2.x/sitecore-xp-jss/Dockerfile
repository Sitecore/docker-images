# escape=`
ARG BASE_IMAGE
ARG ASSETS_IMAGE

FROM $ASSETS_IMAGE as assets
FROM $BASE_IMAGE as build

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ARG ASSETS_USE_WDP

COPY --from=assets ["${ASSETS_USE_WDP}", "C:\\temp\\packages\\"]

# expand selected wdp, inlcuding .xdt transformation files from the SCCPL package (`Expand-Archive` command needs it to be renamed to .zip file), into installation directory
RUN Expand-Archive -Path 'C:\\temp\\packages\\*.zip' -DestinationPath 'C:\\temp'; `
    Rename-Item -Path 'C:\\temp\\Content\\Website\\App_Data\\Transforms\\JSSSCCPL.sccpl' -NewName 'JSSSCCPL.sccpl.zip';`
    Expand-Archive -Path 'C:\\temp\\Content\\Website\\App_Data\\Transforms\\JSSSCCPL.sccpl.zip' -DestinationPath 'C:\\temp\\Content\\Website\\App_Data\\JssXdt';`
    Copy-Item -Path 'C:\\temp\\Content\\Website\\*' -Destination 'C:\\inetpub\\wwwroot' -Recurse -Force;

# copy tools and transforms
COPY --from=assets ["C:\\install\\tools\\", "C:\\install\\tools\\"]

# find transform files and do transformation
RUN (Get-ChildItem -Path 'C:\\inetpub\\wwwroot\\*.xdt' -Recurse ) | ForEach-Object { & 'C:\\install\\tools\\scripts\\Invoke-XdtTransform.ps1' -Path 'C:\\inetpub\\wwwroot\\web.config' -XdtPath $_.FullName -XdtDllPath 'C:\\install\\tools\\bin\\Microsoft.Web.XmlTransform.dll'; }; 


FROM $BASE_IMAGE

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

COPY --from=build ["C:\\inetpub\\wwwroot\\", "C:\\inetpub\\wwwroot\\"]