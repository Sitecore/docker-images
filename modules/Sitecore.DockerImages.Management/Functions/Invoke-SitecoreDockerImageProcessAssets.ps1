function Invoke-SitecoreDockerImageProcessAssets {
	[CmdletBinding(SupportsShouldProcess = $true)]
	param(
		[Parameter(Mandatory = $true)]
		[ValidateScript( {Test-Path $_ -PathType 'Container'})] 
		[string]$BuildRootPath,
		[Parameter(Mandatory = $false)]
		[string]$VersionsFilter = ".*",
		[Parameter(Mandatory = $true)]
		[ValidateScript( {Test-Path $_ -PathType 'Container'})] 
		[string]$AssetsSourcePath,
		[Parameter(Mandatory = $false)]
		[ValidateScript( {$_ -eq $null -Or (Test-Path $_ -PathType 'Container')})] 
		[string]$AssetsTransformPath,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()] 
		[string]$Registry
	)

	$ErrorActionPreference = "STOP"
    if([String]::IsNullOrWhiteSpace($AssetsTransformPath)){
        $AssetsTransformPath = $AssetsSourcePath
    }

	$images = Get-ImageBuildFolders -BuildRootPath $BuildRootPath -VersionsFilter $VersionsFilter -Registry $Registry -AssetsSourcePath $AssetsSourcePath 

	$images = Sort-Images -Images $images

    # if -WhatIf was used, simply check the image assets and cancel other actions
    if ($WhatIfPreference)
    {
		$images | ForEach-Object {
			$image = $_
			
			Write-Host ("--------------------------------------------------------------")
			$image # Print the details of the image

			if ($image.Assets -and $image.Assets.Length -gt 0 ){
				Write-Host ("Assets Check ...")
				$image.Assets | ForEach-Object {
					$asset = $_;
					$assetPath = $asset.SourcePath;
					if (!(Test-Path -Path $assetPath)) {
						Write-Host ("Missing asset: '{0}'..." -f $assetPath) -ForegroundColor Red
					}else{
						Write-Host ("Found asset: '{0}'..." -f $assetPath) -ForegroundColor Green
					}
				}
			} else{
				Write-Host ("No Assets to Check")
			}
			Write-Host ("--------------------------------------------------------------")
			
		}

		return
    }

    # Display images
    $images #| Select-Object -Property MainTag, Args, Memory, Path, Assets, Repository, Tags, BaseImages | Format-Table

	$images | ForEach-Object {
		$image = $_;

		$mainTag = $image.MainTag;

		Write-Host ("Copying assets from image: '{0}'..." -f $mainTag)

		# Copy any missing asset into build context
		if ($image.Assets){
            Invoke-ProcessAssets `
                -Assets $image.Assets`
                -AssetsSourcePath $AssetsSourcePath `
                -TargetPath $image.Path `
                -AssetsTransformPath $AssetsTransformPath `
                -PSTransformationsSourcePath $image.Path;
		}
		Write-Host ("Finished Copying Assets from Image: '{0}'" -f $mainTag) -ForegroundColor Green
	}
}
