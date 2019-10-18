ARG WINVERSION
ARG SCVERSION
FROM scbase-aspnet:${WINVERSION}
COPY ./application/xconnect/configuration /configuration
COPY ./resources/xconnect/Website /inetpub/wwwroot
RUN Rename-Item /inetpub/wwwroot/App_Data/Config/Sitecore/CoreServices/sc.XConnect.Security.EnforceSSL.xml -NewName sc.XConnect.Security.EnforceSSL.xml.disabled
RUN Rename-Item /inetpub/wwwroot/App_Data/Config/Sitecore/CoreServices/sc.XConnect.Security.EnforceSSLWithCertificateValidation.xml -NewName sc.XConnect.Security.EnforceSSLWithCertificateValidation.xml.disabled
WORKDIR /utilities
ENTRYPOINT ["powershell", "./Bootstrapper.ps1", "-Path", "/configuration/configuration.json", "-AppPath", "/inetpub/wwwroot", "-LicensePath", "/inetpub/wwwroot/App_Data", "-Expression", "\"C:\\ServiceMonitor.exe w3svc\""]
