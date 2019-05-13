# escape=`
FROM sitecore-xm1-sqldev:9.1.1-windowsservercore-ltsc2019 as final

COPY . ${INSTALL_PATH}

RUN & (Join-Path $env:INSTALL_PATH "\\Extract-Databases.ps1") -Path $env:INSTALL_PATH; `
    & (Join-Path $env:INSTALL_PATH "\\Install-Databases.ps1") -InstallPath $env:INSTALL_PATH -DataPath $env:DATA_PATH -DatabasePrefix $env:DB_PREFIX; ` 
    Get-ChildItem -Path $env:INSTALL_PATH -Exclude '*.mdf', '*.ldf' -Recurse -Force | Remove-Item -Recurse -Force;
