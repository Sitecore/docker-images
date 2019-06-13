# escape=`
ARG BASE_IMAGE

FROM $BASE_IMAGE

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ENV SITENAME='sc'
ARG SQLADMIN_PASSWORD='HASH-epsom-sunset-cost7!'
ARG SIF_CONFIG=${INSTALL_TEMP}\\sitecore-XM1-cm.json
ARG SIF_PACKAGE=${INSTALL_TEMP}\\'Sitecore*_cm.scwdp.zip'

COPY . ${INSTALL_TEMP}

# Install Sitecore, cleanup and start site
RUN Expand-Archive -Path (Join-Path $env:INSTALL_TEMP '*.zip') -DestinationPath $env:INSTALL_TEMP; `
    Expand-Archive -Path (Join-Path $env:INSTALL_TEMP '*Configuration files*.zip') -DestinationPath $env:INSTALL_TEMP; `
    $config = Get-Content $env:SIF_CONFIG | Where-Object { $_ -notmatch '^\s*\/\/'} | Out-String | ConvertFrom-Json; `
    $config.Tasks.InstallWDP.Params.Arguments | Add-Member -Name 'Skip' -Value @(@{'ObjectName' = 'dbDacFx'}, @{'ObjectName' = 'dbFullSql'}) -MemberType NoteProperty; `
    $config.Variables.'Site.PhysicalPath' = 'C:\inetpub\{0}' -f $env:SITENAME; `
    ConvertTo-Json $config -Depth 50 | Set-Content -Path $env:SIF_CONFIG; `
    Install-SitecoreConfiguration -Path $env:SIF_CONFIG `
    -Package $env:SIF_PACKAGE `
    -LicenseFile (Join-Path $env:INSTALL_TEMP '\\license.xml') `
    -Sitename $env:SITENAME `
    -SqlServer "sql" `
    -SqlDbPrefix $env:SITENAME `  
    -SqlAdminPassword $env:SQLADMIN_PASSWORD `
    -SqlCoreUser "sa" `
    -SqlCorePassword $env:SQLADMIN_PASSWORD `
    -SqlMasterUser "sa" `
    -SqlMasterPassword $env:SQLADMIN_PASSWORD `
    -SqlWebUser "sa" `
    -SqlWebPassword $env:SQLADMIN_PASSWORD `
    -SqlFormsUser "sa" `
    -SqlFormsPassword $env:SQLADMIN_PASSWORD `
    -SolrCorePrefix $env:SITENAME `
    -Skip "RemoveDefaultBinding", "CreateBindingsWithThumprint", "CreateHostHeader", "CreateBindingsWithDevelopmentThumprint", "StartAppPool", "StartWebsite"; `
    Remove-Item -Path 'C:\\*.log'; `
    Remove-Item -Path ('C:\\inetpub\\{0}\\App_Data\\logs' -f $env:SITENAME) -Force -Recurse; `
    Copy-Item -Path (Join-Path $env:INSTALL_TEMP '\\Sitecore') -Destination 'C:/' -Recurse -Force; `
    $iisPath = ('IIS:\Sites\{0}' -f $env:SITENAME); `
    Clear-WebConfiguration -PSPath $iisPath -Filter '/system.webserver/rewrite/rules/rule'; `
    Set-WebConfiguration -PSPath $iisPath -Filter '/system.web/customErrors/@mode' -Value 'Off'; `
    Add-WebConfigurationProperty -PSPath $iisPath -Filter '/system.webServer/rewrite/outboundRules' -Name '.' -Value @{name = 'MakeLocationHeaderRelative' ; preCondition = 'IsSitecoreAbsoluteRedirect'; match = @{serverVariable = 'RESPONSE_LOCATION'; pattern = '(https?://[^:/]+):?([0-9]+)?(.*)'}; action = @{type = 'Rewrite'; value = '{R:3}'}}; `
    Add-WebConfigurationProperty -PSPath $iisPath -Filter '/system.webServer/rewrite/outboundRules/preConditions' -Name '.' -Value @{name = 'IsSitecoreAbsoluteRedirect'}; `
    Add-WebConfigurationProperty -PSPath $iisPath -Filter 'system.webServer/rewrite/outboundRules/preConditions/preCondition[@name=''IsSitecoreAbsoluteRedirect'']' -Name '.' -Value @{input = '{RESPONSE_LOCATION}'; pattern = '(https?://[^:/]+):?([0-9]+)?/sitecore/(.*)'}; `
    Add-WebConfigurationProperty -PSPath $iisPath -Filter 'system.webServer/rewrite/outboundRules/preConditions/preCondition[@name=''IsSitecoreAbsoluteRedirect'']' -Name '.' -Value @{input = '{RESPONSE_STATUS}'; pattern = '3[0-9][0-9]'}; `
    Remove-Item -Path $env:INSTALL_TEMP -Force -Recurse; `
    Start-WebAppPool -Name $env:SITENAME; `
    Start-Website -Name $env:SITENAME

