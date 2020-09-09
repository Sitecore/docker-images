# escape=`
ARG BASE_IMAGE
ARG MODULE_ASSETS

FROM ${MODULE_ASSETS} as module_assets

FROM $BASE_IMAGE as final

ARG MODULE_NAME

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

COPY --from=module_assets C:\module\solr\cores-$MODULE_NAME.json C:\data\cores-$MODULE_NAME.json