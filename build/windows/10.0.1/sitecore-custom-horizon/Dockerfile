# escape=`
ARG BASE_IMAGE
ARG ASSETS_IMAGE

FROM $ASSETS_IMAGE as assets
FROM ${BASE_IMAGE} as final

WORKDIR /horizon

COPY --from=assets /module/cm/content ./
USER ContainerAdministrator
RUN setx /m ASPNETCORE_URLS "http://+:80"
RUN setx /m DOTNET_RUNNING_IN_CONTAINER 1

EXPOSE 80

ENTRYPOINT [ "dotnet.exe", ".\\Sitecore.AuthoringHost.dll" ]

