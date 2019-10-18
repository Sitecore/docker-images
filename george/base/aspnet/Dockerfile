ARG WINVERSION
FROM mcr.microsoft.com/dotnet/framework/aspnet:4.8-windowsservercore-${WINVERSION}
RUN Invoke-WebRequest https://aka.ms/vs/16/release/vc_redist.x64.exe -Outfile C:\vc_redist.x64.exe
RUN C:\vc_redist.x64.exe /install /passive /norestart
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]
RUN Enable-LocalUser Administrator; \
    SecEdit.exe /export /cfg secpol.cfg; \
    (Get-Content secpol.cfg).Replace('PasswordComplexity = 1', 'PasswordComplexity = 0') | \
    Out-File secpol.cfg; \
    SecEdit.exe /configure /db C:\Windows\Security\Local.sdb /cfg secpol.cfg /areas SECURITYPOLICY; \
    Remove-Item secpol.cfg; \
    Set-LocalUser Administrator -Password (New-Object SecureString)
RUN Add-LocalGroupMember -Group 'Performance Monitor Users' -Member 'User Manager\ContainerAdministrator', 'IIS APPPOOL\DefaultAppPool' -ErrorAction SilentlyContinue
RUN Add-LocalGroupMember -Group 'Performance Log Users' -Member 'User Manager\ContainerAdministrator', 'IIS APPPOOL\DefaultAppPool' -ErrorAction SilentlyContinue
USER ContainerAdministrator
RUN icacls 'C:\inetpub\wwwroot' /grant 'IIS_IUSRS:(OI)(CI)F' /T
COPY /base/common/utilities /utilities
RUN Set-Service -Name w3svc -StartupType 'Manual'
ENTRYPOINT ["powershell"]