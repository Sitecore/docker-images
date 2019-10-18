ARG WINVERSION
ARG SCVERSION
FROM scbase-netcore:${WINVERSION}
COPY ./application/identity/configuration /configuration
COPY ./resources/identity/Website /app
COPY ./resources/license.xml /app/sitecoreruntime/license.xml
WORKDIR /utilities
ENTRYPOINT ["pwsh", "Bootstrapper.ps1", "-Path", "/configuration/configuration.json", "-AppPath", "/app", "-Expression", "dotnet /app/Sitecore.IdentityServer.Host.dll"]