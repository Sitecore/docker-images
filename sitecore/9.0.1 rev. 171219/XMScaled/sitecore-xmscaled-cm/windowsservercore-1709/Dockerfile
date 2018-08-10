# escape=`
ARG BASE_IMAGE
FROM ${BASE_IMAGE}

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ENV SITENAME='sc'
ENV SITEPATH=C:\inetpub\${SITENAME}\Website
ENV DATAPATH=C:\inetpub\${SITENAME}\Data
ARG SQLADMIN_PASSWORD='HASH-epsom-sunset-cost7!'
ARG INSTALL_TEMP='c:\\install'
ARG SIF_CONFIG=${INSTALL_TEMP}\\sitecore-XM1-cm-docker.json
ARG SIF_PACKAGE=${INSTALL_TEMP}\\'Sitecore*_cm.scwdp.zip'
ARG WEBDEPLOY_MSI=${INSTALL_TEMP}\\webdeploy.msi

COPY ./Assets ${INSTALL_TEMP}

# Install Sitecore
RUN Remove-Website -Name 'Default Web Site'; `
    Install-SitecoreConfiguration -Path $env:SIF_CONFIG `
    -Package $env:SIF_PACKAGE `
    -LicenseFile (Join-Path $env:INSTALL_TEMP 'license.xml') `
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
    -SolrUrl "http://solr:8983/solr" `
    -SolrCorePrefix $env:SITENAME `
    -SitePhysicalPath $env:SITEPATH `
    -SiteDataFolder $env:DATAPATH `
    -Skip "RemoveDefaultBinding", "CreateBindingsWithThumprint", "CreateHostHeader", "CreateBindingsWithDevelopmentThumprint", "StartAppPool", "StartWebsite", "UpdateSolrSchema"; `
    Remove-Item -Path 'C:\\*.log'; `
    $iisPath = ('IIS:\Sites\{0}' -f $env:SITENAME); `
    Clear-WebConfiguration -PSPath $iisPath -Filter '/system.webserver/rewrite/rules/rule'; `
    Set-WebConfiguration -PSPath $iisPath -Filter '/system.web/customErrors/@mode' -Value 'Off'; `
    Add-WebConfigurationProperty -PSPath $iisPath -Filter '/system.webServer/rewrite/outboundRules' -Name '.' -Value @{name = 'MakeLocationHeaderRelative' ; preCondition = 'IsSitecoreAbsoluteRedirect'; match = @{serverVariable = 'RESPONSE_LOCATION'; pattern = '(https?://[^:/]+):?([0-9]+)?(.*)'}; action = @{type = 'Rewrite'; value = '{R:3}'}}; `
    Add-WebConfigurationProperty -PSPath $iisPath -Filter '/system.webServer/rewrite/outboundRules/preConditions' -Name '.' -Value @{name = 'IsSitecoreAbsoluteRedirect'}; `
    Add-WebConfigurationProperty -PSPath $iisPath -Filter 'system.webServer/rewrite/outboundRules/preConditions/preCondition[@name=''IsSitecoreAbsoluteRedirect'']' -Name '.' -Value @{input = '{RESPONSE_LOCATION}'; pattern = '(https?://[^:/]+):?([0-9]+)?/sitecore/(.*)'}; `
    Add-WebConfigurationProperty -PSPath $iisPath -Filter 'system.webServer/rewrite/outboundRules/preConditions/preCondition[@name=''IsSitecoreAbsoluteRedirect'']' -Name '.' -Value @{input = '{RESPONSE_STATUS}'; pattern = '3[0-9][0-9]'}; `
    $xml = New-Object XML; `
    $xml.Load(('{0}\app_config\include\examples\DataFolder.config.example' -f $env:SITEPATH)); `
    $nsm = New-Object Xml.XmlNamespaceManager($xml.NameTable); `
    $nsm.AddNamespace('patch', 'http://www.sitecore.net/xmlconfig/'); `
    $element = $xml.SelectSingleNode('//sc.variable[@name=''dataFolder'']/patch:attribute[@name=''value'']', $nsm); `
    $element.InnerText=$env:DATAPATH; `
    $xml.Save(('{0}\app_config\include\DataFolder.config' -f $env:SITEPATH));


# Cleanup, post installation tweaks and start site
RUN Start-Process msiexec.exe -ArgumentList '/x', $env:WEBDEPLOY_MSI, '/quiet', '/norestart' -NoNewWindow -Wait; `
    Uninstall-Module SitecoreInstallFramework -Force; `
    Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters' -Name ServerPriorityTimeLimit -Value 0 -Type DWord; `
    setx /M PATH $($env:PATH + ';C:\Sitecore\Scripts'); `    
    Start-WebAppPool -Name $env:SITENAME; `
    Start-Website -Name $env:SITENAME; `
    Remove-Item -Path $env:INSTALL_TEMP -Force -Recurse; `
    Remove-Item -Path $env:DATAPATH -Force -Recurse; 

VOLUME ${DATAPATH}
