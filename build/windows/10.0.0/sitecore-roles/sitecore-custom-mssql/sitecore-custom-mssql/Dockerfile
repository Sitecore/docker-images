# escape=`

ARG BASE_IMAGE
ARG MODULE_ASSETS

FROM ${MODULE_ASSETS} AS module

FROM ${BASE_IMAGE}

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

COPY --from=module C:\module\db C:\module_data

RUN C:\DeployDatabases.ps1 -ResourcesDirectory C:\module_data; `
    Remove-Item -Path C:\module_data -Recurse -Force;