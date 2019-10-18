ARG WINVERSION
ARG SOLR_DOWNLOAD_SERVER
FROM mcr.microsoft.com/windows/servercore:1903

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ENV JAVA_HOME C:\\openjdk
RUN $newPath = ('{0}\bin;{1}' -f $env:JAVA_HOME, $env:PATH); \
	Write-Host ('Updating PATH: {0}' -f $newPath); \
	setx /M PATH $newPath

ENV JAVA_VERSION 8u232
ENV JAVA_BASE_URL https://github.com/AdoptOpenJDK/openjdk8-upstream-binaries/releases/download/jdk8u232-b09/OpenJDK8U-jre_
ENV JAVA_URL_VERSION 8u232b09

ENV SOLR_VERSION 7.5.0
ENV SOLR_BASE_URL ${SOLR_DOWNLOAD_SERVER:-https://archive.apache.org/dist/lucene/solr}

RUN Write-Host 'Preflight check...'; \
	Remove-Item /temp -ErrorAction SilentlyContinue; \
	Remove-Item openjdk.zip -Force -ErrorAction SilentlyContinue; \
	Remove-Item solr.zip -Force -ErrorAction SilentlyContinue; \
	New-Item -ItemType Directory -Path C:\temp | Out-Null;

RUN Write-Host ('Installing JRE {0}...' -f $env:JAVA_VERSION); \
	$url = ('{0}x64_windows_{1}.zip' -f $env:JAVA_BASE_URL, $env:JAVA_URL_VERSION); \
	Write-Host ('Downloading {0} ...' -f $url); \
	[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; \
	Invoke-WebRequest -Uri $url -OutFile 'openjdk.zip'; \
	\
	Write-Host 'Expanding ...'; \
	Expand-Archive openjdk.zip -DestinationPath C:\temp; \
	Move-Item -Path C:\temp\* -Destination $env:JAVA_HOME; \

	Write-Host 'Verifying install ...'; \
	Write-Host '  java -version'; java -version;

RUN Write-Host ('Installing Solr {0}...' -f $env:SOLR_VERSION); \
	$url = ('{0}/{1}/solr-{1}.zip' -f $env:SOLR_BASE_URL, $env:SOLR_VERSION); \
	Write-Host ('Downloading {0} ...' -f $url); \
	[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; \
	Invoke-WebRequest -Uri $url -OutFile 'solr.zip'; \
	\
	Write-Host 'Expanding ...'; \
	Expand-Archive solr.zip -DestinationPath C:\temp; \
	Move-Item -Path C:\temp\* -Destination C:\solr;

RUN Write-Host 'Cleaning up...'; \
	Remove-Item /temp -ErrorAction SilentlyContinue; \
	Remove-Item openjdk.zip -Force -ErrorAction SilentlyContinue; \
	Remove-Item solr.zip -Force -ErrorAction SilentlyContinue;

WORKDIR /solr/bin
EXPOSE 8983
ENTRYPOINT [ "solr.cmd", "start", "-f", "-t", "mydata", "-p", "8983" ]