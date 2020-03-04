# escape=`
ARG BUILD_IMAGE
ARG BASE_IMAGE

FROM $BUILD_IMAGE as builder

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ARG SOLR_VERSION
ARG CORE_NAMES
ARG MANAGED_SCHEMA_DEFAULT_NAME

RUN New-Item -Path 'C:\\downloads' -ItemType 'Directory' -Force | Out-Null; `
    curl.exe -sS -L -o C:\\downloads\\solr.zip $('https://archive.apache.org/dist/lucene/solr/{0}/solr-{0}.zip' -f $env:SOLR_VERSION); `
    Expand-Archive -Path 'C:\\downloads\\solr.zip' -DestinationPath 'C:\\temp'; `
    Move-Item -Path 'C:\\temp\\solr-*' -Destination 'C:\\solr';

COPY ${MANAGED_SCHEMA_DEFAULT_NAME} C:\\temp\\

RUN New-Item -Path 'C:\\clean' -ItemType Directory | Out-Null; `
    Copy-Item -Path 'C:\\solr\\server\\solr\\*' -Destination 'C:\\clean' -Force -Recurse; `
    $env:CORE_NAMES -split ',' | ForEach-Object { `
        $name = $_.Trim(); `
        Copy-Item -Path 'C:\\clean\\configsets\\_default\\conf' -Destination ('C:\\clean\\{0}\\conf' -f $name) -Recurse -Force; `
        Copy-Item -Path ('C:\\temp\\{0}' -f $env:MANAGED_SCHEMA_DEFAULT_NAME) -Destination ('C:\\clean\\{0}\\conf\\managed-schema' -f $name); `
        Set-Content -Path ('C:\\clean\\{0}\\core.properties' -f $name) -Value ('name={0}{1}config=solrconfig.xml{1}update.autoCreateFields=false{1}dataDir=data' -f $name, [Environment]::NewLine); `
        New-Item -Path ('C:\\clean\\{0}\\data' -f $name) -ItemType Directory | Out-Null; `
    }; `
    Remove-Item -Path 'C:\\clean\\README.txt'; `
    Remove-Item -Path 'C:\\clean\\configsets' -Recurse;

FROM $BASE_IMAGE

USER ContainerAdministrator

COPY --from=builder ["C:\\solr", "C:\\solr"]
COPY --from=builder ["C:\\clean", "C:\\clean"]
COPY --from=builder ["C:\\windows\\system32\\find.exe", "C:\\windows\\system32\\"]

RUN MKDIR c:\\data

ENV SOLR_HOME=c:/data

EXPOSE 8983

COPY Boot.cmd .

CMD Boot.cmd c:\\solr 8983 c:\\clean c:\\data