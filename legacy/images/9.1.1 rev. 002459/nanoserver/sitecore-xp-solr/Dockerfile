# escape=`
ARG BUILD_IMAGE
ARG BASE_IMAGE

FROM $BUILD_IMAGE as builder

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

# Install JAVA
ENV JAVA_HOME C:\\ojdkbuild
ENV JAVA_VERSION 8u161
ENV JAVA_OJDKBUILD_VERSION 1.8.0.161-1
ENV JAVA_OJDKBUILD_ZIP java-1.8.0-openjdk-1.8.0.161-1.b14.ojdkbuild.windows.x86_64.zip

RUN setx /M PATH ('{0}\bin;{1}' -f $env:JAVA_HOME, $env:PATH); `
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; `
    $url = ('https://github.com/ojdkbuild/ojdkbuild/releases/download/{0}/{1}' -f $env:JAVA_OJDKBUILD_VERSION, $env:JAVA_OJDKBUILD_ZIP); `
    Invoke-WebRequest -Uri $url -OutFile 'ojdkbuild.zip'; `
    Expand-Archive ojdkbuild.zip -DestinationPath C:\; `
    Move-Item -Path ('C:\{0}' -f ($env:JAVA_OJDKBUILD_ZIP -Replace '.zip$', '')) -Destination $env:JAVA_HOME; `
    Remove-Item ojdkbuild.zip -Force;

# Install Solr
ARG SOLR_VERSION=7.2.1
RUN Invoke-WebRequest -Uri ('http://archive.apache.org/dist/lucene/solr/{0}/solr-{0}.zip' -f $env:SOLR_VERSION) -OutFile /solr.zip; `
    Expand-Archive -Path /solr.zip -DestinationPath /temp; `
    Move-Item -Path "C:/temp/solr-*" -Destination c:\solr;

# Extract artifacts
ARG INSTALL_TEMP='c:\\install'
COPY . ${INSTALL_TEMP}
RUN Expand-Archive -Path (Join-Path $env:INSTALL_TEMP '*.zip') -DestinationPath $env:INSTALL_TEMP; `
    Expand-Archive -Path (Join-Path $env:INSTALL_TEMP '*Configuration files*.zip') -DestinationPath $env:INSTALL_TEMP; `
    $zip = [IO.Compression.ZipFile]::OpenRead((Get-Item -Path (Join-Path $env:INSTALL_TEMP '*xconnect.scwdp.zip')).FullName); `
    $zip.Entries | Where-Object { $_.Name -like 'schema.json' } | Foreach-Object { [IO.Compression.ZipFileExtensions]::ExtractToFile($_, (Join-Path $env:INSTALL_TEMP 'schema.json'), $true) }; `
    $zip.Dispose();

# Install Sitecore Solr cores using SIF
RUN & 'c:/solr/bin/solr.cmd' start -p 8983; `
    $env:SOLR_PREFIX = 'sc'; `  
    $env:SOLR_URL = 'http://localhost:8983/solr'; `
    $env:SOLR_ROOT_PATH = 'c:/solr'; `
    $env:SOLR_SERVICE_NAME = 'void'; `
    Install-SitecoreConfiguration -Path (Join-Path $env:INSTALL_TEMP 'sitecore-solr.json') `
    -SolrUrl $env:SOLR_URL `
    -SolrRoot $env:SOLR_ROOT_PATH `
    -SolrService $env:SOLR_SERVICE_NAME `
    -CorePrefix $env:SOLR_PREFIX `
    -Skip 'StopSolr', 'StartSolr'; `
    Install-SitecoreConfiguration -Path (Join-Path $env:INSTALL_TEMP 'xconnect-solr.json') `
    -SolrUrl $env:SOLR_URL `
    -SolrRoot $env:SOLR_ROOT_PATH `
    -SolrService $env:SOLR_SERVICE_NAME `
    -CorePrefix $env:SOLR_PREFIX `
    -Skip 'StopSolr', 'StartSolr'; `
    Install-SitecoreConfiguration -Path (Join-Path $env:INSTALL_TEMP 'apply-solr-commands.json') `
    -SolrUrl $env:SOLR_URL `
    -CorePrefix $env:SOLR_PREFIX `
    -ArgumentsFile (Join-Path $env:INSTALL_TEMP 'schema.json'); `
    Get-Process -Name "java" | Stop-Process -Force;

# Copy the clean cores for later use
RUN New-Item -Path 'c:/clean' -ItemType Directory | Out-Null; `
    Get-ChildItem -Path 'c:/solr/server/solr' | Foreach-Object { Copy-Item -Path $_.FullName -Destination 'c:/clean' -Recurse }

FROM $BASE_IMAGE

USER ContainerAdministrator

COPY --from=builder /solr /solr
COPY --from=builder /clean /clean
COPY --from=builder /windows/system32/find.exe /windows/system32/

RUN MKDIR c:\\data

ENV SOLR_HOME=c:/data

EXPOSE 8983

COPY Boot.cmd .

CMD Boot.cmd c:\\solr 8983 c:\\clean c:\\data