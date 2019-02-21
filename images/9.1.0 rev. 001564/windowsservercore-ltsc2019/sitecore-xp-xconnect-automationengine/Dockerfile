# escape=`
FROM sitecore-xp-xconnect:9.1.001564-windowsservercore-ltsc2019 as builder

FROM sitecore-xp-base:9.1.001564-windowsservercore-ltsc2019 as final

COPY --from=builder ["/inetpub/xconnect/App_Data/jobs/continuous/AutomationEngine", "/AutomationEngine"]

RUN Remove-Item -Path 'C:\\AutomationEngine\\App_Data\\logs' -Force -Recurse; `
    Stop-Service -Name 'W3SVC' -Force; `
    Remove-Item -Path 'C:\\ServiceMonitor.exe' -Force;

ENTRYPOINT [ "C:\\AutomationEngine\\maengine.exe" ]