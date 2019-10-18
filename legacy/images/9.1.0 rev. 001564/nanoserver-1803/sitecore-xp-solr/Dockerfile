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

# Install Sitecore Solr cores using SIF
ARG INSTALL_TEMP='c:\\install'
COPY . ${INSTALL_TEMP}
RUN & 'c:/solr/bin/solr.cmd' start -p 8983; `
    $env:SOLR_PREFIX = 'sc'; `
    Expand-Archive -Path (Join-Path $env:INSTALL_TEMP '*.zip') -DestinationPath $env:INSTALL_TEMP; `
    Expand-Archive -Path (Join-Path $env:INSTALL_TEMP '*Configuration files*.zip') -DestinationPath $env:INSTALL_TEMP; `
    Install-SitecoreConfiguration -Path (Join-Path $env:INSTALL_TEMP 'sitecore-solr.json') `
    -SolrUrl "http://localhost:8983/solr" `
    -SolrRoot "c:/solr" `
    -SolrService "void" `
    -CorePrefix $env:SOLR_PREFIX `
    -Skip "StopSolr", "StartSolr"; `
    Install-SitecoreConfiguration -Path (Join-Path $env:INSTALL_TEMP 'xconnect-solr.json') `
    -SolrUrl "http://localhost:8983/solr" `
    -SolrRoot "c:/solr" `
    -SolrService "void" `
    -CorePrefix $env:SOLR_PREFIX `
    -Skip "StopSolr", "StartSolr"; `
    Get-Process -Name "java" | Stop-Process -Force;

# Copy the clean cores for later use
RUN New-Item -Path 'c:/clean' -ItemType Directory | Out-Null; `
    Get-ChildItem -Path 'c:/solr/server/solr' | Foreach-Object { Copy-Item -Path $_.FullName -Destination 'c:/clean' -Recurse }

# Runtime image
FROM $BASE_IMAGE

COPY --from=builder /solr /solr
COPY --from=builder /clean /clean
COPY --from=builder /windows/system32/find.exe /windows/system32/
COPY MapDrive.cmd MapDrive.cmd

RUN MKDIR c:\data

# Workaround for java issues with Windows container symlinks: https://github.com/moby/moby/issues/27537#issuecomment-271546031
USER ContainerAdministrator
RUN MapDrive.cmd G:

# Set solr home dir to above mapped drive
ENV SOLR_HOME=G:/

# Expose default port
EXPOSE 8983

# Boot
COPY Boot.cmd .

CMD Boot.cmd c:\\solr 8983 c:\\clean c:\\data
