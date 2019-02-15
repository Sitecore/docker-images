# escape=`
FROM sitecore-xp-xconnect:9.0.180604-windowsservercore-1803 as builder

FROM sitecore-xp-base:9.0.180604-windowsservercore-1803 as final

COPY --from=builder ["/inetpub/xconnect/App_Data/jobs/continuous/IndexWorker", "/IndexWorker"]

RUN Remove-Item -Path 'C:\\IndexWorker\\App_Data\\logs' -Force -Recurse; `
    Stop-Service -Name 'W3SVC' -Force; `
    Remove-Item -Path 'C:\\ServiceMonitor.exe' -Force;

ENTRYPOINT [ "C:\\IndexWorker\\XConnectSearchIndexer.exe" ]