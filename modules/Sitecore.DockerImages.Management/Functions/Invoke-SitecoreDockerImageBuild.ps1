function Invoke-SitecoreDockerImageBuild {
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
		[string]$Registry,
		[Parameter(Mandatory = $false)]
		[ValidateSet('None', 'hyperv')]
		[string]$Isolation = 'hyperv',
		[Parameter(Mandatory = $false)]
		[ValidateSet('Always', 'IfChanged', 'Never')]
		[string]$PushMode = 'Never',
		[Parameter(Mandatory = $false)]
		[switch]$RemoveInstallationAssetFiles
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
					$assetPath = Join-Path $AssetsSourcePath $asset.SourcePath;
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

	# Pull latest bases images
	Find-ExternalBaseImages -Images $images -Registry $Registry| ForEach-Object {
		$baseImage = $_;
		Write-Host ("Pulling base image '{0}'..." -f $baseImage);
		$LASTEXITCODE = 0;
		docker pull $baseImage;
		$LASTEXITCODE -ne 0 | Where-Object { $_ } | ForEach-Object { throw ("Pulling '{0}' failed" -f $baseImage) }
	}

	$images | ForEach-Object {
		$image = $_

		$mainTag = $image.MainTag
		$repository = $image.Repository
		
		# Save the digest of previous builds for later comparison
		$previousDigest = $null
		
		if ((docker image ls $mainTag --quiet)) {
			$previousDigest = (docker image inspect $mainTag) | ConvertFrom-Json | ForEach-Object { $_.Id }
		}

		Write-Host ("Building '{0}'..." -f $mainTag)

		# Copy any missing asset into build context
		if ($image.Assets){
            Invoke-ProcessAssets `
                -Assets $image.Assets`
                -AssetsSourcePath $AssetsSourcePath `
                -TargetPath $image.Path `
                -AssetsTransformPath $AssetsTransformPath `
                -PSTransformationsSourcePath $image.Path;
		}
        #Debugging:
        #return
		if ((docker image ls $mainTag --quiet)) {
			$previousDigest = (docker image inspect $mainTag) | ConvertFrom-Json | ForEach-Object { $_.Id }
		}

		# Build image
		$exp = 'docker image build'
		switch ($Isolation) {
            'None' {<# Nothing to do #>}
            'hyperv' {
			    $exp = $exp + ' --isolation "hyperv"'
            }
            default {
                Write-Host 'Not supported Isolation' -ForegroundColor Red;
            }
		}
		if ($image.Memory) {
			$exp = $exp + ' --memory ' + $image.Memory
		}
		if ($image.Args) {
			$image.Args.PSobject.Properties | ForEach-Object {
				$exp = $exp + ' --build-arg "' + $_.name + '=' + $_.value + '"'
			}
		}
		$image.Tags | ForEach-Object {
			$tag = "{0}/{1}:{2}" -f $Registry, $repository, $_
			$exp = $exp + ' -t ' + $tag
		}
		$exp = $exp + ' "' + $image.Path + '"'

		Write-Host $exp;
		Invoke-Expression $exp;
		
		
		
		$LASTEXITCODE -ne 0 | Where-Object { $_ } | ForEach-Object { throw ("Build of '{0}' failed" -f $mainTag) }

		if ($RemoveInstallationAssetFiles) {
			Write-Host ("Done with Installation Asset - Removing  '{0}'" -f $targetPath) -ForegroundColor Green;
			Remove-Item $targetPath -Force;
		}

		if ($PushMode -eq 'Never') {
			Write-Warning "Done. PushMode is set to 'Never' therefore the image is not pushed to the remote repository.";
			return;
		}
		
		# Determine if we need to push
		$currentDigest = (docker image inspect $mainTag) | ConvertFrom-Json | ForEach-Object { $_.Id }
		
		if (($PushMode -eq 'IfChanged') -And ($currentDigest -eq $previousDigest)) {
			Write-Host "Done. PushMode is set to 'IfChanged' and the image has not changed since last build, therefore is not pushed to the remote repository." -ForegroundColor Green
			return
		}
		
		# Push image
		$image.Tags | ForEach-Object {
			$tag = "{0}/{1}:{2}" -f $Registry, $repository, $_
			docker image push $tag
		}

		$LASTEXITCODE -ne 0 | Where-Object { $_ } | ForEach-Object { throw ("Push of '{0}' failed" -f $mainTag) }

		Write-Host ("Image '{0}' pushed." -f $mainTag) -ForegroundColor Green
	}
}
