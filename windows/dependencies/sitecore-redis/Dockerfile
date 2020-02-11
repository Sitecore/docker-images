# escape=`
ARG BASE_IMAGE
FROM $BASE_IMAGE

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

# Install Redis
ARG REDIS_VERSION

RUN New-Item -Path 'C:\\downloads' -ItemType 'Directory' -Force | Out-Null; `
    curl.exe -sS -L -o C:\\downloads\redis.zip ('https://github.com/microsoftarchive/redis/releases/download/win-{0}/Redis-x64-{0}.zip' -f $ENV:REDIS_VERSION); `
    Expand-Archive -Path C:\\downloads\redis.zip -DestinationPath c:\redis; `
    Remove-Item C:\\downloads\redis.zip -Force

ENTRYPOINT ["powershell", "C:/redis/redis-server.exe"]
