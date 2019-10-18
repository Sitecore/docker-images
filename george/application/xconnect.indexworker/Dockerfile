ARG WINVERSION
ARG SCVERSION
FROM scbase-netframework:${WINVERSION}
COPY ./application/xconnect.indexworker/configuration /configuration
COPY ./resources/xconnect/Website/App_Data/jobs/continuous/IndexWorker /app
WORKDIR /utilities
ENTRYPOINT ["powershell", "./Bootstrapper.ps1", "-Path", "/configuration/configuration.json", "-AppPath", "/app", "-LicensePath", "/app/App_Data", "-Expression", "/app/XConnectSearchIndexer.exe"]