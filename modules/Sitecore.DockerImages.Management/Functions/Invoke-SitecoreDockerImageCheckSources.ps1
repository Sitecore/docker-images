function Invoke-SitecoreDockerImageCheckSources
{
	[CmdletBinding()]
	param(
		[Parameter(Mandatory = $true)]
		[ValidateScript( {Test-Path $_ -PathType 'Container'})] 
		[string]$BuildRootPath,
		[Parameter(Mandatory = $false)]
		[string]$VersionsFilter = "*",
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()] 
		[string]$Registry,
		[Parameter(Mandatory = $true)]
		[ValidateScript( {Test-Path $_ -PathType 'Container'})] 
		[string]$AssetsSourcePath
	)

	$images = Get-ImageBuildFolders -BuildRootPath $BuildRootPath -VersionsFilter $VersionsFilter -Registry $Registry -AssetsSourcePath $AssetsSourcePath 

	# What to build...
	$images | ForEach-Object {
		$image = $_

		$mainTag = $image.MainTag

		Write-Host ("Checking '{0}'..." -f $mainTag)

		# Copy any missing source files into build context
		$image.Sources | ForEach-Object {
			$sourcePath = $_
			if (!(Test-Path -Path $sourcePath)) {
				Write-Host ("Missing source: '{0}'..." -f $sourcePath) -ForegroundColor Red
			}else{
				Write-Host ("Found Source: '{0}'..." -f $sourcePath) -ForegroundColor Green
			}
		}
		
	}
}