#Requires -RunAsAdministrator
using module 'Bendev.Assets.Management';

function Find-ExternalBaseImages {
    [cmdletbinding()]
    param(
        [object[]]$Images,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()] 
        [string]$Registry
    )

    $externalImages = @{}
    Foreach ($image in $Images) {
        if ($image.BaseImages) {
            Foreach ($baseImage in $image.BaseImages) {
                if (-not $externalImages.ContainsKey($baseImage) -And -not $baseImage.StartsWith($Registry, "CurrentCultureIgnoreCase")) {
                    $externalImages.add($baseImage, $baseImage)
                }
            }
        }
    }

    $externalImages.Values
}

# borrowed from https://github.com/RamblingCookieMonster/PSDepend/blob/master/PSDepend/Private/Get-ClonedObject.ps1
Function Get-ClonedObject {
    param($DeepCopyObject)
    $memStream = new-object IO.MemoryStream
    $formatter = new-object Runtime.Serialization.Formatters.Binary.BinaryFormatter
    $formatter.Serialize($memStream, $DeepCopyObject)
    $memStream.Position = 0
    $formatter.Deserialize($memStream)
}


# borrowed from https://github.com/RamblingCookieMonster/PSDepend/blob/master/PSDepend/Private/Get-TopologicalSort.ps1
# Input is a hashtable of @{ID = @(Depended,On,IDs);...}
function Get-TopologicalSort {
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        [hashtable] $edgeList
    )

    # Make sure we can use HashSet
    Add-Type -AssemblyName System.Core

    # Clone it so as to not alter original
    $currentEdgeList = [hashtable] (Get-ClonedObject $edgeList)

    # algorithm from http://en.wikipedia.org/wiki/Topological_sorting#Algorithms
    $topologicallySortedElements = New-Object System.Collections.ArrayList
    $setOfAllNodesWithNoIncomingEdges = New-Object System.Collections.Queue

    $fasterEdgeList = @{}

    # Keep track of all nodes in case they put it in as an edge destination but not source
    $allNodes = New-Object -TypeName System.Collections.Generic.HashSet[object] -ArgumentList (, [object[]] $currentEdgeList.Keys)

    foreach ($currentNode in $currentEdgeList.Keys) {
        $currentDestinationNodes = [array] $currentEdgeList[$currentNode]
        if ($currentDestinationNodes.Length -eq 0) {
            $setOfAllNodesWithNoIncomingEdges.Enqueue($currentNode)
        }

        foreach ($currentDestinationNode in $currentDestinationNodes) {
            if (!$allNodes.Contains($currentDestinationNode)) {
                [void] $allNodes.Add($currentDestinationNode)
            }
        }

        # Take this time to convert them to a HashSet for faster operation
        $currentDestinationNodes = New-Object -TypeName System.Collections.Generic.HashSet[object] -ArgumentList (, [object[]] $currentDestinationNodes )
        [void] $fasterEdgeList.Add($currentNode, $currentDestinationNodes)        
    }

    # Now let's reconcile by adding empty dependencies for source nodes they didn't tell us about
    foreach ($currentNode in $allNodes) {
        if (!$currentEdgeList.ContainsKey($currentNode)) {
            [void] $currentEdgeList.Add($currentNode, (New-Object -TypeName System.Collections.Generic.HashSet[object]))
            $setOfAllNodesWithNoIncomingEdges.Enqueue($currentNode)
        }
    }

    $currentEdgeList = $fasterEdgeList

    while ($setOfAllNodesWithNoIncomingEdges.Count -gt 0) {        
        $currentNode = $setOfAllNodesWithNoIncomingEdges.Dequeue()
        [void] $currentEdgeList.Remove($currentNode)
        [void] $topologicallySortedElements.Add($currentNode)

        foreach ($currentEdgeSourceNode in $currentEdgeList.Keys) {
            $currentNodeDestinations = $currentEdgeList[$currentEdgeSourceNode]
            if ($currentNodeDestinations.Contains($currentNode)) {
                [void] $currentNodeDestinations.Remove($currentNode)

                if ($currentNodeDestinations.Count -eq 0) {
                    [void] $setOfAllNodesWithNoIncomingEdges.Enqueue($currentEdgeSourceNode)
                }                
            }
        }
    }

    if ($currentEdgeList.Count -gt 0) {
        throw "Graph has at least one cycle!"
    }

    return $topologicallySortedElements
}


function Invoke-EnsureDirectoryExists([string]$path){
    [String[]]$entries = $path.Split(@('\', '/'));
    [String]$partialPath = '';

    foreach($entry in $entries)
    {
        if ([String]::IsNullOrWhiteSpace($partialPath)){
            $partialPath = $entry
        }else{
            $partialPath = Join-Path $partialPath $entry
        }
        if(-not(Test-Path $partialPath)) {
            New-Item $partialPath -ItemType Directory | Out-Null
        }
    }
}

# borrowed from https://github.com/RamblingCookieMonster/PSDepend/blob/master/PSDepend/Private/Sort-PSDependency.ps1
function Sort-Images {
    [cmdletbinding()]
    param(
        [object[]]$Images
    )

    $order = @{}
    Foreach ($image in $Images) {
        if ($image.BaseImages) {
            if (-not $order.ContainsKey($image.MainTag)) {
                $order.add($image.MainTag, $image.BaseImages)
            }
        }
    }

    if ($order.Keys.Count -gt 0) {
        $imageOrder = Get-TopologicalSort $order
        Sort-ObjectWithCustomList -InputObject $Images -Property MainTag -CustomList $imageOrder
    }
    else {
        $Images
    }
}

# borrowed from https://github.com/RamblingCookieMonster/PSDepend/blob/master/PSDepend/Private/Sort-WithCustomList.ps1
Function Sort-ObjectWithCustomList {
    Param (
        [parameter(ValueFromPipeline = $true)]
        [PSObject]
        $InputObject,

        [parameter(Position = 1)]
        [String]
        $Property,

        [parameter()]
        [Object[]]
        $CustomList
    )
    Begin {
        # convert customList (array) to hash
        $hash = @{}
        $rank = 0
        $customList | Select-Object -Unique | ForEach-Object {
            $key = $_
            $hash.Add($key, $rank)
            $rank++
        }

        # create script block for sorting
        # items not in custom list will be last in sort order
        $sortOrder = {
            $key = if ($Property) { $_.$Property } else { $_ }
            $rank = $hash[$key]
            if ($rank -ne $null) {
                $rank
            }
            else {
                [System.Double]::PositiveInfinity
            }
        }

        # create a place to collect objects from pipeline
        # (I don't know how to match behavior of Sort's InputObject parameter)
        $objects = @()
    }
    Process {
        $objects += $InputObject
    }
    End {
        $objects | Sort-Object -Property $sortOrder
    }
}


#========================================================================================================================

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


