# escape=`
ARG BASE_IMAGE
ARG ASSETS_IMAGE

FROM $ASSETS_IMAGE as assets
FROM ${BASE_IMAGE} as build

ARG ASSETS_USE_PS_WDP

ARG CONN_STRING_CORE
ARG CONN_STRING_MASTER
ARG CONN_STRING_WEB

SHELL ["powershell", "-NoProfile", "-Command", "$ErrorActionPreference = 'Stop';"]

WORKDIR /app/

# Copy Publishing Service files
COPY --from=assets ["${ASSETS_USE_PS_WDP}", "/packages/"]

# Copy PS scripts
COPY scripts/ .

# expand selected wdp into installation directory
RUN Expand-Archive -Path $env:ASSETS_USE_PS_WDP -DestinationPath "/app"

FROM ${BASE_IMAGE} as final

WORKDIR /app/

COPY --from=build /app .

#Configure web servers to bind to port 80 when present
ENV ASPNETCORE_URLS=http://+:80 `
    # Enable detection of running in a container
    DOTNET_RUNNING_IN_CONTAINER=true `
    # Deprecated, use `DOTNET_RUNNING_IN_CONTAINER` instead - https://github.com/dotnet/dotnet-docker/issues/677
    DOTNET_RUNNING_IN_CONTAINERS=true

EXPOSE 80

ENTRYPOINT [ "powershell", "/app/start.ps1" ]

