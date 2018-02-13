# escape=`
FROM microsoft/aspnet:4.7.1-windowsservercore-1709 as builder

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

# Install JAVA
ENV JAVA_HOME C:\\ojdkbuild
ENV JAVA_VERSION 8u161
ENV JAVA_OJDKBUILD_VERSION 1.8.0.161-1
ENV JAVA_OJDKBUILD_ZIP java-1.8.0-openjdk-1.8.0.161-1.b14.ojdkbuild.windows.x86_64.zip

RUN setx /M PATH ('{0}\bin;{1}' -f $env:JAVA_HOME, $env:PATH); `
    $url = ('https://github.com/ojdkbuild/ojdkbuild/releases/download/{0}/{1}' -f $env:JAVA_OJDKBUILD_VERSION, $env:JAVA_OJDKBUILD_ZIP); `
    Invoke-WebRequest -Uri $url -OutFile 'ojdkbuild.zip'; `
    Expand-Archive ojdkbuild.zip -DestinationPath C:\; `
    Move-Item -Path ('C:\{0}' -f ($env:JAVA_OJDKBUILD_ZIP -Replace '.zip$', '')) -Destination $env:JAVA_HOME; `
    Remove-Item ojdkbuild.zip -Force;
    
# Install Solr
ARG SOLR_VERSION=6.6.2
RUN Invoke-WebRequest -Uri ('http://archive.apache.org/dist/lucene/solr/{0}/solr-{0}.zip' -f $env:SOLR_VERSION) -OutFile /solr.zip; `
    Expand-Archive -Path /solr.zip -DestinationPath /temp; `
    Move-Item -Path "C:/temp/solr-*" -Destination c:\solr;

# Install SIF
RUN Install-PackageProvider -Name NuGet -Force | Out-Null; `
    Register-PSRepository -Name SitecoreGallery -SourceLocation https://sitecore.myget.org/F/sc-powershell/api/v2; `
    Install-Module SitecoreInstallFramework -RequiredVersion 1.1.0 -Force;

# Install Sitecore Solr cores using SIF
ARG INSTALL_TEMP='c:\\install'
ARG SIF_CONFIG=${INSTALL_TEMP}\\sitecore-solr.json
ENV SOLR_PREFIX='sc'
ADD . ${INSTALL_TEMP}
RUN & 'c:/solr/bin/solr.cmd' start -p 8983; `
    Expand-Archive -Path (Join-Path $env:INSTALL_TEMP '*.zip') -DestinationPath $env:INSTALL_TEMP; `
    Expand-Archive -Path (Join-Path $env:INSTALL_TEMP '*Configuration files*.zip') -DestinationPath $env:INSTALL_TEMP; `
    Install-SitecoreConfiguration -Path $env:SIF_CONFIG `
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
FROM openjdk:8u151-jdk-nanoserver as final

COPY --from=builder /solr /solr
COPY --from=builder /clean /clean

VOLUME c:/data

# Workaround for java issues with Windows container symlinks: https://github.com/moby/moby/issues/27537#issuecomment-271546031
RUN REG ADD 'HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\DOS Devices' /v 'G:' /d '\??\C:\data' /reg:64

# Set solr home dir to above mapped drive
ENV SOLR_HOME=g:/

# Expose default port
EXPOSE 8983

# Boot
ADD Boot.ps1 .
#TODO: add c:/solr parameter and port
CMD C:/Boot.ps1 -InstallPath 'c:/clean' -DataPath 'c:/data'