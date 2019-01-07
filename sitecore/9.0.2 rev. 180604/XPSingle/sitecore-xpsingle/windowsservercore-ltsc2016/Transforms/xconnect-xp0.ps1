param(
    [Parameter(Mandatory = $true)]
    [ValidateScript( {Test-Path $_ -PathType  'Leaf'})] 
    [string]$SourcePath,
    [Parameter(Mandatory = $true)]
    [ValidateScript( {Test-Path $_ -IsValid})] 
    [string]$TargetPath
)

$config = Get-Content $SourcePath | Where-Object { $_ -notmatch '^\s*\/\/'} | Out-String | ConvertFrom-Json;

$config.Parameters | Add-Member -Name 'WebRoot' -Value @{'Type' = 'string'; 'DefaultValue' = 'c:\inetpub\wwwroot'; 'Description' = 'The physical path of the configured Web Root for the environment'} -MemberType NoteProperty;

$config.Variables.'Site.PhysicalPath' = '[concat(parameter(''WebRoot''),''\'', parameter(''SiteName''))]';


#$config.Parameters | Add-Member -Name 'SitePhysicalPath' -Value @{'Type' = 'string'; 'Description' = 'DockerImageBuild: Build process to specify value.'} -MemberType NoteProperty;
#$config.Parameters | Add-Member -Name 'SiteDataFolder' -Value @{'Type' = 'string'; 'Description' = 'DockerImageBuild: Build process to specify value.'} -MemberType NoteProperty;
#$config.Parameters | Add-Member -Name 'InstallDataFolder' -Value @{'Type' = 'string'; 'Description' = 'DockerImageBuild: Build process to specify value.'} -MemberType NoteProperty;

#$config.Variables.'Site.PhysicalPath' = '[parameter(''SitePhysicalPath'')]';
#$config.Variables.'Site.DataFolder' = '[parameter(''SiteDataFolder'')]';
#$config.Variables.'Services.IndexWorker.InstallPath' = '[joinpath(parameter(''InstallDataFolder''), ''jobs'',''continuous'',''IndexWorker'')]';
#$config.Variables.'Services.MarketingAutomationEngine.InstallPath' = '[joinpath(parameter(''InstallDataFolder''), ''jobs'',''continuous'',''AutomationEngine'')]';
#$config.Variables.'Sharding.Root.Path' = '[joinpath(parameter(''InstallDataFolder''), ''collectiondeployment'')]';
#$config.Variables.'Solr.Config.Path' = '[joinpath(parameter(''InstallDataFolder''), ''solrcommands'', ''schema.json'')]';


#$config.Tasks.CreatePaths.Params.Exists += '[variable(''Site.DataFolder'')]';

ConvertTo-Json $config -Depth 50 | Set-Content -Path $TargetPath ;
