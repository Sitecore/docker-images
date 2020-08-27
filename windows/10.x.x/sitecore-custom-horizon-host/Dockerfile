# escape=`
ARG BASE_IMAGE
ARG BUILD_IMAGE
ARG ASSETS_IMAGE

FROM $ASSETS_IMAGE as assets
FROM ${BUILD_IMAGE} as build

ARG ASSETS_USE_WDP

SHELL ["powershell", "-NoProfile", "-Command", "$ErrorActionPreference = 'Stop';"]

# Copy files
COPY --from=assets ["${ASSETS_USE_WDP}", "/packages/"]

# expand selected wdp into installation directory
RUN Expand-Archive -Path $env:ASSETS_USE_WDP -DestinationPath "/output"; `
    Copy-Item /output/content/website/* /inetpub/wwwroot/ -Recurse;

FROM ${BASE_IMAGE} as final

COPY --from=build /inetpub/wwwroot/ /app

#Configure web servers to bind to port 80 when present
ENV ASPNETCORE_URLS=http://+:80 `
    # Enable detection of running in a container
    DOTNET_RUNNING_IN_CONTAINER=true `
    # Deprecated, use `DOTNET_RUNNING_IN_CONTAINER` instead - https://github.com/dotnet/dotnet-docker/issues/677
    DOTNET_RUNNING_IN_CONTAINERS=true

EXPOSE 80

CMD ["dotnet", "/app/Sitecore.AuthoringHost.dll"]
