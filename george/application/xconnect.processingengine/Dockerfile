ARG WINVERSION
ARG SCVERSION
FROM scbase-netframework:${WINVERSION}
COPY ./application/xconnect.processingengine/configuration /configuration
COPY ./resources/xconnect/Website/App_Data/jobs/continuous/ProcessingEngine /app
WORKDIR /utilities
ENTRYPOINT ["powershell", "./Bootstrapper.ps1", "-Path", "/configuration/configuration.json", "-AppPath", "/app", "-LicensePath", "/app/App_Data", "-Expression", "/app/Sitecore.ProcessingEngine.exe"]