[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [ValidateScript( {Test-Path $_ -PathType  'Leaf'})] 
    [string]$SourcePath,
    [Parameter(Mandatory = $true)]
    [ValidateScript( {Test-Path $_ -IsValid})] 
    [string]$TargetPath
    <#
        The following are example of additional parameters that can be passed by the PowerShellScriptTransform

    [Parameter(Mandatory = $false)]
    [string]$Param1,
    [Parameter(Mandatory = $false)]
    [string]$Param2

	Next is an example of hot to define them in the JSON file:
	"AdditionalParameters": {"Param1":"aaa", "Param2":"bbb"}
    #>
)

$config = Get-Content $SourcePath | Where-Object { $_ -notmatch '^\s*\/\/'} | Out-String | ConvertFrom-Json;

$config.Parameters | Add-Member -Name 'SitePhysicalPath' -Value @{'Type' = 'string'; 'Description' = 'DockerImageBuild: Build process to specify value.'} -MemberType NoteProperty;
$config.Parameters | Add-Member -Name 'SiteDataFolder' -Value @{'Type' = 'string'; 'Description' = 'DockerImageBuild: Build process to specify value.'} -MemberType NoteProperty;

$config.Variables.'Site.PhysicalPath' = "[parameter('SitePhysicalPath')]";
$config.Variables.'Site.DataFolder' = "[parameter('SiteDataFolder')]";

$config.Tasks.CreatePaths.Params.Exists += '[variable(''Site.DataFolder'')]';
$config.Tasks.InstallWDP.Params.Arguments | Add-Member -Name 'Skip' -Value @(@{'ObjectName' = 'dbDacFx'}, @{'ObjectName' = 'dbFullSql'}) -MemberType NoteProperty;

ConvertTo-Json $config -Depth 50 | Set-Content -Path $TargetPath;
    