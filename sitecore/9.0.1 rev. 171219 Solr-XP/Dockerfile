# escape=`
FROM microsoft/aspnet:4.7.1-windowsservercore-1709 as builder

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

# Download and install Java - Solr dependency
RUN Invoke-WebRequest -Method Get -Uri http://javadl.oracle.com/webapps/download/AutoDL?BundleId=210185 -OutFile /jreinstaller.exe ; `
    Start-Process -FilePath C:\jreinstaller.exe -PassThru -wait -ArgumentList "/s,INSTALLDIR=c:\Java\jre" ; `
    del C:\jreinstaller.exe

# Write variables to the master environment in the registry
RUN setx PATH '%PATH%;c:\\Java\\jre'

# Install Solr
ARG SOLR_VERSION=6.6.2
RUN Invoke-WebRequest -Uri ('http://archive.apache.org/dist/lucene/solr/{0}/solr-{0}.zip' -f $env:SOLR_VERSION) -OutFile /solr.zip; `
    Expand-Archive -Path /solr.zip -DestinationPath /solr ; `
    Remove-Item /solr.zip -Force


ARG HOST_NAME="SOLR"
ARG PORT=8983
ARG SERVICE_NAME="Solr-6"
ADD solr.pfx /Files/
ADD scripts /Scripts
ADD Configure-SSL.ps1 /Scripts/
ADD WaitForSolr.ps1 /Scripts/

RUN C:\Scripts\Configure-SSL.ps1 -solrHost "$Env:HOST_NAME" -certPath c:\Files\solr.pfx

RUN $hostFileName = 'c:\\windows\\system32\\drivers\\etc\\hosts'; '\"`r`n127.0.0.1`t$Env:HOST_NAME\"' | Add-Content $hostFileName


# Install SIF
RUN Install-PackageProvider -Name NuGet -Force | Out-Null; `
    Register-PSRepository -Name SitecoreGallery -SourceLocation https://sitecore.myget.org/F/sc-powershell/api/v2; `
    Install-Module SitecoreInstallFramework -RequiredVersion 1.1.0 -Force;

WORKDIR "/solr/solr-6.6.2"

RUN Invoke-WebRequest -Method Get -Uri "https://nssm.cc/release/nssm-2.24.zip" -OutFile /nssm.zip ; `
    Expand-Archive -Path /nssm.zip -DestinationPath /nssm ; `
    Remove-Item /nssm.zip -Force

RUN /nssm/nssm-2.24/win64/nssm.exe install $Env:SERVICE_NAME "/solr/solr-6.6.2/bin/solr.cmd" "start" "-f" "-p $Env:PORT"
RUN /nssm/nssm-2.24/win64/nssm.exe set $Env:SERVICE_NAME AppEnvironmentExtra JAVA_HOME=C:\java\jre

ARG INSTALL_TEMP='c:\\install'
ADD . ${INSTALL_TEMP}

RUN $solrUrl = 'https://{0}:{1}/solr' -f $Env:HOST_NAME, $Env:PORT; `
    /Scripts/WaitForSolr.ps1 $Env:HOST_NAME; `
    Expand-Archive -Path (Join-Path $env:INSTALL_TEMP '*.zip') -DestinationPath $env:INSTALL_TEMP; `
    Expand-Archive -Path (Join-Path $env:INSTALL_TEMP '*Configuration files*.zip') -DestinationPath $env:INSTALL_TEMP; 

# Install cores
ARG SIF_CONFIG=${INSTALL_TEMP}\\xconnect-solr.json

ARG XCONNECT_CORE_PREFIX="xp0"
ARG SITECORE_CORE_PREFIX="xp0"

RUN   Install-SitecoreConfiguration -Path $env:SIF_CONFIG `
    -SolrUrl $solrUrl `
    -SolrRoot "c:\\solr\\solr-{0}" -f $env:SOLR_VERSION `
    -SolrService $Env:SERVICE_NAME `
    -CorePrefix $Env:XCONNECT_CORE_PREFIX

ARG SIF_CONFIG=${INSTALL_TEMP}\\sitecore-solr.json
RUN   Install-SitecoreConfiguration -Path $env:SIF_CONFIG `
    -SolrUrl $solrUrl `
    -SolrRoot "c:\\solr\\solr-{0}" -f $env:SOLR_VERSION `
    -SolrService $Env:SERVICE_NAME `
    -CorePrefix $Env:SITECORE_CORE_PREFIX

RUN New-Item -Path 'c:/clean' -ItemType Directory | Out-Null; `
    Get-ChildItem -Path ('c:/solr/solr-{0}/server/solr' -f $env:SOLR_VERSION) | Foreach-Object { Copy-Item -Path $_.FullName -Destination 'c:/clean' -Recurse }


# Runtime image
FROM openjdk:8u151-jdk-nanoserver as final

COPY --from=builder /solr /solr
COPY --from=builder /clean /clean
COPY --from=builder /windows/system32/find.exe /windows/system32/

VOLUME c:/data

# Workaround for java issues with Windows container symlinks: https://github.com/moby/moby/issues/27537#issuecomment-271546031
RUN REG ADD 'HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\DOS Devices' /v 'G:' /d '\??\C:\data' /reg:64

# Set solr home dir to above mapped drive
ENV SOLR_HOME=g:/

# Expose default port
EXPOSE 8983

# Boot
ADD Boot.ps1 .

CMD C:/Boot.ps1 -SolrPath ('c:/solr/solr-{0}' -f $env:SOLR_VERSION) -SolrPort 8983 -InstallPath 'c:/clean' -DataPath 'c:/data'