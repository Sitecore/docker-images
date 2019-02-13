FROM sitecore-xp-xconnect:9.0.180604-windowsservercore-1803 as builder

FROM mcr.microsoft.com/windows/servercore:1803 as final

COPY --from=builder ["/inetpub/xconnect/App_Data/jobs/continuous/IndexWorker", "/IndexWorker"]

ENTRYPOINT [ "C:\\IndexWorker\\XConnectSearchIndexer.exe" ]