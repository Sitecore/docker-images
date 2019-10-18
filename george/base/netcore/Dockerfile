ARG WINVERSION
FROM mcr.microsoft.com/windows/nanoserver:sac2016 as tool
FROM mcr.microsoft.com/powershell:nanoserver-${WINVERSION} as powershell
FROM mcr.microsoft.com/dotnet/core/runtime:2.2-nanoserver-${WINVERSION}
COPY --from=powershell ["/Program Files/PowerShell", "/Program Files/PowerShell"]
COPY --from=tool /Windows/System32/certoc.exe /configuration/certoc.exe
COPY /base/common/utilities /utilities
USER ContainerAdministrator
RUN setx /m PATH "%PATH%;C:\Program Files\PowerShell"
ENTRYPOINT ["pwsh"]