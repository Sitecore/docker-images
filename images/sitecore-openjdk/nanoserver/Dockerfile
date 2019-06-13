# escape=`
ARG BUILD_IMAGE
ARG BASE_IMAGE

FROM $BUILD_IMAGE as builder

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

# Install JAVA
ENV JAVA_HOME C:\\ojdkbuild
ENV JAVA_OJDKBUILD_VERSION 1.8.0.191-1
ENV JAVA_OJDKBUILD_ZIP java-1.8.0-openjdk-1.8.0.191-1.b12.ojdkbuild.windows.x86_64.zip

RUN [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; `
    Invoke-WebRequest -Uri $('https://github.com/ojdkbuild/ojdkbuild/releases/download/{0}/{1}' -f $env:JAVA_OJDKBUILD_VERSION, $env:JAVA_OJDKBUILD_ZIP) -UseBasicParsing -OutFile 'ojdkbuild.zip'; `
    Expand-Archive ojdkbuild.zip -DestinationPath C:\; `
    Move-Item -Path ('C:\\{0}' -f ($env:JAVA_OJDKBUILD_ZIP -Replace '.zip', '')) -Destination $env:JAVA_HOME;

FROM $BASE_IMAGE

COPY --from=builder /ojdkbuild /ojdkbuild

ENV JAVA_HOME C:\\ojdkbuild