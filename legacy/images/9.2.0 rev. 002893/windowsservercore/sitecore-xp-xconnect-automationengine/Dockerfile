# escape=`
ARG BUILD_IMAGE
ARG BASE_IMAGE

FROM $BUILD_IMAGE as builder

FROM $BASE_IMAGE

COPY --from=builder ["/inetpub/xconnect/App_Data/jobs/continuous/AutomationEngine", "/AutomationEngine"]

RUN Remove-Item -Path 'C:\\AutomationEngine\\App_Data\\logs' -Force -Recurse; `
    Stop-Service -Name 'W3SVC' -Force; `
    Remove-Item -Path 'C:\\ServiceMonitor.exe' -Force;

ENTRYPOINT [ "C:\\AutomationEngine\\maengine.exe" ]