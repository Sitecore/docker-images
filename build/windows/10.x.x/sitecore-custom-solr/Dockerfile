# escape=`
ARG BASE_IMAGE
ARG MODULE_ASSETS

FROM ${MODULE_ASSETS} as module_assets

FROM $BASE_IMAGE as final

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

COPY --from=module_assets c:\module\solr c:\solr_data\

RUN C:\Add-SolrCores.ps1 -SolrPath C:\solr -SolrSchemaPath C:\solr_data\managed-schema -SolrCoreNames 'sitecore_sxa_master_index,sitecore_sxa_web_index'; `
    Remove-Item -Path C:\solr_data -Recurse -Force;
