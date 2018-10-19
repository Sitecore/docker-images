function Get-ImageBuildFolders {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [ValidateScript( {Test-Path $_ -PathType 'Container'})] 
        [string]$BuildRootPath,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()] 
        [string]$VersionsFilter,
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
    if ([String]::IsNullOrWhiteSpace($AssetsTransformPath)){
        $AssetsTransformPath = $AssetsSourcePath;
    }
    $versionFolderPaths = Get-ChildItem -Path $BuildRootPath -Filter 'build.json' -Recurse | Select-Object -ExpandProperty Directory | Select-Object -ExpandProperty FullName -Unique | Select-String -Pattern $VersionsFilter
    if ($versionFolderPaths){

        Get-Item -LiteralPath $versionFolderPaths | Foreach-Object {
            $imageFolder = $_
            $buildFilePath = Join-Path $imageFolder.FullName "\build.json"

            if (Test-Path $buildFilePath -PathType Leaf) {
                $data = Get-Content -Path $buildFilePath | ConvertFrom-Json
                $assets = [Asset]::ParseArray(@($data.assets))

                # Build up tag to use
				$repository = $data.repository
				$tags = $data.tags
                $mainTag = "{0}/{1}:{2}" -f $Registry, $repository, $tags[0]
                $baseImage = '<None>'
                if ($data.args) {
                    $args = $data.args
                    $args.PSobject.Properties | ForEach-Object {
                        if ($_.value -is [string]) {
                            $_.value = $_.value.Replace('${Registry}', $Registry)
                        }
                    }
                    $baseImage = $args.PSobject.Properties | ForEach-Object { if ($_.name -match "BASE_IMAGE") {Write-Output $_.value}}
                }

                $baseImages = Get-ChildItem -Path $imageFolder.FullName -Filter "Dockerfile" | Foreach-Object {
					$dockerfilePath = $_.FullName
                    $fromClauses = Get-Content -Path $dockerfilePath | Where-Object { $_.StartsWith("FROM ") }
                
                    $fromClauses | ForEach-Object {
                        $image = $_

                        if ($image -like "* as *") {
                            $image = $image.Substring(0, $image.IndexOf(" as "))
                        }

                        if ([string]::IsNullOrEmpty($image)) {
                            throw ("Invalid dockerfile '{0}', FROM image could not be read." -f $dockerfilePath)
                        }

                        #$image = $image.Replace('${BASE_IMAGE}', $baseImage)

                        Write-Output $image
                    }
                }
                $baseImages = $baseImages | Select-Object -Unique | ForEach-Object { Write-Output $_.Replace("FROM ", "").Trim() } | ForEach-Object { Write-Output $_.Replace('${BASE_IMAGE}', $baseImage) }

                Write-Output (New-Object PSObject -Property @{
                        Repository = $repository;
                        Tags       = $tags;
                        Args       = $args;
                        MainTag    = $mainTag;
                        Memory     = $data.memory;
                        Path       = $imageFolder.FullName;
                        BaseImages = $baseImages;
                        Assets     = $assets;
                    })
            }
            else {
                throw ("Invalid version folder '{0}', file not found: '{1}'." -f $imageFolder.Name, $buildFilePath)
            }
        }
    }

}
