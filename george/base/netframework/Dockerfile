ARG WINVERSION
FROM mcr.microsoft.com/dotnet/framework/runtime:4.8-windowsservercore-${WINVERSION}
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]
RUN Enable-LocalUser Administrator; \
    SecEdit.exe /export /cfg secpol.cfg; \
    (Get-Content secpol.cfg).Replace('PasswordComplexity = 1', 'PasswordComplexity = 0') | \
    Out-File secpol.cfg; \
    SecEdit.exe /configure /db C:\Windows\Security\Local.sdb /cfg secpol.cfg /areas SECURITYPOLICY; \
    Remove-Item secpol.cfg; \
    Set-LocalUser Administrator -Password (New-Object SecureString)
COPY /base/common/utilities /utilities
ENTRYPOINT ["powershell"]