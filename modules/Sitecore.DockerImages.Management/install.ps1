#
# This script will install module in Powershell modules localization.
# Install means copy files from repo to $env:ProgramFiles\WindowsPowerShell\Modules\$moduleName"
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
	if ($psPath -like 'C:\Program Files\*PowerShell\Modules')
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

		md "$targetPath\Functions" -Force
		md "$targetPath\Private" -Force
		#md "$targetPath\PublicClasses" -Force
		$filesToExclude = @( "install.ps1", "*.tests.ps1" )

		Copy-Item -Path $modulePath\* -Destination "$targetPath" -Include *.psd1, *.psm1, *.ps1, *.md -Exclude $filesToExclude   -Force -Verbose -Recurse
		Copy-Item -Recurse -Path $modulePath\Functions\* -Destination "$targetPath\Functions" -Include *.psd1, *.psm1, *.ps1 -Exclude $filesToExclude -Force -Verbose
		Copy-Item -Recurse -Path $modulePath\Private\* -Destination "$targetPath\Private" -Include *.psd1, *.psm1, *.ps1 -Exclude $filesToExclude -Force -Verbose
		#Copy-Item -Recurse -Path $modulePath\PublicClasses\* -Destination "$targetPath\PublicClasses" -Include *.psd1, *.psm1, *.ps1 -Exclude $filesToExclude -Force -Verbose
		Break
	}
}
#endregion
