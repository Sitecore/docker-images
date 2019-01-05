#
# This script will install module in Powershell modules localization.
# Install means copy files from repo to $env:ProgramFiles\*PowerShell\Modules\$moduleName
# PowerShell 6 changes the default paths for identifying installed modules. The wildcard
# in the pattern resolves the discrepancy.
#
$moduleName = "Sitecore.DockerImages.Management"
$projectFolder = Split-Path -Parent $MyInvocation.MyCommand.Path
$solutionFolder = Split-Path -Parent $projectFolder
#$modulePath = Join-Path $projectFolder -ChildPath $moduleName
#$modulePath = "$moduleName"
$modulePath = "$projectFolder"


#region Install module"

Foreach ($psPath in $env:PSModulePath.Split(";"))
{
	$pattern = ($env:ProgramFiles -replace '\\', '\\')+"\\\w*PowerShell\\Modules\\?";
	if ($psPath -match $pattern)
	{
		$targetPath = Join-Path $psPath -ChildPath "$moduleName"

		if( -not (Test-Path -Path $targetPath))
		{
			md $targetPath
		}

		Write-Output "SolutionFolder:" $solutionFolder
		Write-Output "ProjectFolder:" $projectFolder
		Write-Output "Source: $modulePath"
		Write-Output "Path: $targetPath"

		Remove-Item "$targetPath\*" -Verbose -Recurse -Force

		$filesToExclude = @( "install.ps1", "*.tests.ps1" )

		Copy-Item -Path $modulePath\* -Destination "$targetPath" -Include *.psd1, *.psm1, *.ps1, *.md -Exclude $filesToExclude   -Force -Verbose -Recurse

		Break
	}
}
#endregion
