# escape=`
ARG BUILD_IMAGE
ARG BASE_IMAGE

FROM $BUILD_IMAGE as builder

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ENV JAVA_HOME C:\\ojdkbuild
ENV JAVA_OJDKBUILD_VERSION java-1.8.0-openjdk-1.8.0.252-2.b09
ENV JAVA_OJDKBUILD_ZIP java-1.8.0-openjdk-1.8.0.252-2.b09.ojdkbuild.windows.x86_64.zip

RUN New-Item -Path 'C:\\downloads' -ItemType 'Directory' -Force | Out-Null; `
    curl.exe -sS -L -o C:\\downloads\\ojdkbuild.zip  $('https://github.com/ojdkbuild/ojdkbuild/releases/download/{0}/{1}' -f $env:JAVA_OJDKBUILD_VERSION, $env:JAVA_OJDKBUILD_ZIP); `
    Expand-Archive 'C:\\downloads\\ojdkbuild.zip' -DestinationPath C:\; `
    Move-Item -Path ('C:\\{0}' -f ($env:JAVA_OJDKBUILD_ZIP -Replace '.zip', '')) -Destination $env:JAVA_HOME;

FROM $BASE_IMAGE

COPY --from=builder /ojdkbuild /ojdkbuild

ENV JAVA_HOME C:\\ojdkbuild
