#escape=`
ARG ASSETS_IMAGE
ARG CERTIFICATES_IMAGE
ARG BUILD_IMAGE
ARG BASE_IMAGE

FROM ${ASSETS_IMAGE} as assets
FROM ${CERTIFICATES_IMAGE} as certificates
FROM ${BUILD_IMAGE} as build

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ARG ASSETS_USE_WDP

COPY --from=assets ["${ASSETS_USE_WDP}", "c:\\temp\\packages\\"]

RUN Expand-Archive -Path 'c:\\temp\\packages\\*.zip' -DestinationPath 'c:\\temp'

FROM ${BASE_IMAGE}

WORKDIR /app

COPY --from=certificates ["/certificates/identity.pfx", "/certificates/password", "/certificates/"]
COPY --from=build ["/temp/Content/Website/", "/app/"]

# Since the certificates generated in 'sitecore-certificates' are meant to be the
# only ones used for TLS authentication, we make Identity Server use them here.
# It makes it a bit easier for consumers to configure their Identity Server, but
# at the same time allows for the variables to be overridden should the need arise.
#
# Unfortunately, setting machine-wide environment variables require administrator privs.
# Nano Server doesn't have a user-local environment variable store.
USER ContainerAdministrator

RUN setx /M SITECORE_Sitecore__IdentityServer__CertificateFilePassword /F c:\certificates\password /A 0,0
RUN setx /M SITECORE_Sitecore__IdentityServer__CertificateFilePath c:\certificates\identity.pfx

ENTRYPOINT ["dotnet", "Sitecore.IdentityServer.Host.dll"]
