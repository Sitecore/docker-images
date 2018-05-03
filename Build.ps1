[CmdletBinding()]
param(
    [Parameter(Mandatory = $false)]
    [string]$VersionsFilter = "*",
    [Parameter(Mandatory = $true)]
    [ValidateScript( {Test-Path $_ -PathType 'Container'})] 
    [string]$InstallSourcePath,
    [Parameter(Mandatory = $false)]
    [string]$Organization,
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()] 
    [string]$Repository,
    [Parameter(Mandatory = $false)]
    [ValidateSet('Always', 'IfChanged', 'Never')]
    [string]$PushMode = 'Never',
    [Parameter(Mandatory = $false)]
    [switch]$RemoveInstallationSourceFiles
)

# borrowed from https://github.com/RamblingCookieMonster/PSDepend/blob/master/PSDepend/Private/Get-ClonedObject.ps1
function Get-ClonedObject {
    param($DeepCopyObject)
    $memStream = new-object IO.MemoryStream
    $formatter = new-object Runtime.Serialization.Formatters.Binary.BinaryFormatter
    $formatter.Serialize($memStream,$DeepCopyObject)
    $memStream.Position=0
    $formatter.Deserialize($memStream)
}

#--------------------------------------------------------------------------------------------------
# borrowed from https://github.com/RamblingCookieMonster/PSDepend/blob/master/PSDepend/Private/Sort-WithCustomList.ps1
Function Sort-ObjectWithCustomList {
    Param (
        [parameter(ValueFromPipeline=$true)]
        [PSObject]
        $InputObject,

        [parameter(Position=1)]
        [String]
        $Property,

        [parameter()]
        [Object[]]
        $CustomList
    )
    Begin
    {
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
            } else {
                [System.Double]::PositiveInfinity
            }
        }

        # create a place to collect objects from pipeline
        # (I don't know how to match behavior of Sort's InputObject parameter)
        $objects = @()
    }
    Process
    {
        $objects += $InputObject
    }
    End
    {
        $objects | Sort-Object -Property $sortOrder
    }
}
#--------------------------------------------------------------------------------------------------

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
  $allNodes = New-Object -TypeName System.Collections.Generic.HashSet[object] -ArgumentList (,[object[]] $currentEdgeList.Keys)

  foreach($currentNode in $currentEdgeList.Keys) {
      $currentDestinationNodes = [array] $currentEdgeList[$currentNode]
      if($currentDestinationNodes.Length -eq 0) {
          $setOfAllNodesWithNoIncomingEdges.Enqueue($currentNode)
      }

      foreach($currentDestinationNode in $currentDestinationNodes) {
          if(!$allNodes.Contains($currentDestinationNode)) {
              [void] $allNodes.Add($currentDestinationNode)
          }
      }

      # Take this time to convert them to a HashSet for faster operation
      $currentDestinationNodes = New-Object -TypeName System.Collections.Generic.HashSet[object] -ArgumentList (,[object[]] $currentDestinationNodes )
      [void] $fasterEdgeList.Add($currentNode, $currentDestinationNodes)        
  }

  # Now let's reconcile by adding empty dependencies for source nodes they didn't tell us about
  foreach($currentNode in $allNodes) {
      if(!$currentEdgeList.ContainsKey($currentNode)) {
          [void] $currentEdgeList.Add($currentNode, (New-Object -TypeName System.Collections.Generic.HashSet[object]))
          $setOfAllNodesWithNoIncomingEdges.Enqueue($currentNode)
      }
  }

  $currentEdgeList = $fasterEdgeList

  while($setOfAllNodesWithNoIncomingEdges.Count -gt 0) {        
      $currentNode = $setOfAllNodesWithNoIncomingEdges.Dequeue()
      [void] $currentEdgeList.Remove($currentNode)
      [void] $topologicallySortedElements.Add($currentNode)

      foreach($currentEdgeSourceNode in $currentEdgeList.Keys) {
          $currentNodeDestinations = $currentEdgeList[$currentEdgeSourceNode]
          if($currentNodeDestinations.Contains($currentNode)) {
              [void] $currentNodeDestinations.Remove($currentNode)

              if($currentNodeDestinations.Count -eq 0) {
                  [void] $setOfAllNodesWithNoIncomingEdges.Enqueue($currentEdgeSourceNode)
              }                
          }
      }
  }

  if($currentEdgeList.Count -gt 0) {
      throw "Graph has at least one cycle!"
  }

  return $topologicallySortedElements
}
#--------------------------------------------------------------------------------------------------
# borrowed from https://github.com/RamblingCookieMonster/PSDepend/blob/master/PSDepend/Private/Sort-PSDependency.ps1
function Sort-Images {
    [cmdletbinding()]
    param(
        [object[]]$Images
    )

    $Order = @{}
    Foreach($Image in $Images)
    {
        if($Image.BaseImages)
        {
            if(-not $Order.ContainsKey($Image.FullName))
            {
                $Order.add($Image.FullName, $Image.BaseImages)
            }
        }
    }

    if($Order.Keys.Count -gt 0)
    {
        $ImageOrder = Get-TopologicalSort $Order
        Sort-ObjectWithCustomList -InputObject $Images -Property FullName -CustomList $ImageOrder
    }
    else
    {
        $Images
    }
}
###################################################################################################################################################
function Scan-ImageBuildFolders {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [ValidateScript( {Test-Path $_ -PathType 'Container'})] 
        [string]$Path,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()] 
        [string]$Filter,
        [Parameter(Mandatory = $true)]
        [ValidateScript( {Test-Path $_ -PathType 'Container'})] 
        [string]$InstallSourcePath,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()] 
        [string]$Repository # Can include Organization if needed: <Organization>/<Repository>  | <Repository>
    )
  
    Get-ChildItem -Path $Path -Filter $Filter | Foreach-Object {
        $imageFolder = $_
        $buildFilePath = Join-Path $imageFolder.FullName "\build.json"

        if (Test-Path $buildFilePath -PathType Leaf) {
            $data = Get-Content -Path $buildFilePath | ConvertFrom-Json
            $sources = $data.sources | ForEach-Object {
                Write-Output (Join-Path $InstallSourcePath $_)
            }

            # Build up tag to use
            $imageName = "{0}:{1}" -f $Repository, $data.tag
            $baseImage = '<None>'
            if ($data.args){
                $args = $data.args
                $args.PSobject.Properties | ForEach-Object {
                        if ($_.value -is [string]){
                            $_.value = $_.value.Replace('${Repository}', $Repository)
                        }
                    }
                $baseImage = $args.PSobject.Properties | ForEach-Object { if ($_.name -match "BASE_IMAGE") {Write-Output $_.value}}
            }

            $baseImages = Get-ChildItem -Path $imageFolder.FullName -Filter "Dockerfile" | Foreach-Object {
                $fromClauses = Get-Content -Path $_.FullName | Where-Object { $_.StartsWith("FROM ") }
            
                $fromClauses | ForEach-Object {
                    $image = $_

                    if ($image -like "* as *") {
                        $image = $image.Substring(0, $image.IndexOf(" as "))
                    }

                    if ([string]::IsNullOrEmpty($image)) {
                        throw ("Invalid dockerfile '{0}', FROM image could not be read." -f $_.FullName)
                    }

                    #$image = $image.Replace('${BASE_IMAGE}', $baseImage)

                    Write-Output $image
                }
            }
            $baseImages = $baseImages | Select-Object -Unique | ForEach-Object { Write-Output $_.Replace("FROM ", "").Trim() } | ForEach-Object { Write-Output $_.Replace('${BASE_IMAGE}', $baseImage) }

            Write-Output (New-Object PSObject -Property @{
                    Tag         = $data.tag;
                    Args        = $args;
                    FullName    = $imageName;
                    Memory      = $data.memory;
                    Path        = $imageFolder.FullName;
                    BaseImages  = $baseImages;
                    Sources     = $sources;
                })
        }
        else {
            throw ("Invalid version folder '{0}', file not found: '{1}'." -f $imageFolder.Name, $buildFilePath)
        }
    }
}

function Find-ExternalBaseImages {
    [cmdletbinding()]
    param(
        [object[]]$Images,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()] 
        [string]$Repository # Can include Organization if needed: <Organization>/<Repository>  | <Repository>
    )

    $externalImages = @{}
    Foreach($image in $Images)
    {
        if($image.BaseImages)
        {
            Foreach($baseImage in $image.BaseImages)
            {
                if(-not $externalImages.ContainsKey($baseImage) -And -not $baseImage.StartsWith($Repository,"CurrentCultureIgnoreCase"))
                {
                    $externalImages.add($baseImage, $baseImage)
                }
            }
        }
    }

    $externalImages.Values
}

$ErrorActionPreference = "STOP"

$imagesPath = (Join-Path $PSScriptRoot "\sitecore")

if (![string]::IsNullOrEmpty($Organization) -and -not $Repository.Contains('/')) {
    $Repository = "{0}/{1}" -f $Organization, $Repository
}
 

$images = Scan-ImageBuildFolders -Path $imagesPath -InstallSourcePath $InstallSourcePath -Filter $VersionsFilter -Repository $Repository 

$images = Sort-Images -Images $images


# Pull latest bases images
Find-ExternalBaseImages -Images $images -Repository $Repository| ForEach-Object {
    $baseImage = $_
    Write-Host ("Pulling latest base image '{0}'..." -f $baseImage)
    docker pull $baseImage
    $LASTEXITCODE -ne 0 | Where-Object { $_ } | ForEach-Object { throw ("Pulling '{0}' failed" -f $baseImage) }
}

$images | ForEach-Object {
    $image = $_

    $imageName = $image.FullName

    # Save the digest of previous builds for later comparison
    $previousDigest = $null
    
    if ((docker image ls $imageName --quiet)) {
        $previousDigest = (docker image inspect $imageName) | ConvertFrom-Json | ForEach-Object { $_.Id }
    }

    Write-Host ("Building '{0}'..." -f $imageName)

    # Copy any missing source files into build context
    $image.Sources | ForEach-Object {
        $sourcePath = $_
        $sourceItem = Get-Item -Path $sourcePath
        $targetPath = Join-Path $image.Path $sourceItem.Name

        if (!(Test-Path -Path $targetPath)) {
            Copy-Item $sourceItem -Destination $targetPath -Verbose:$VerbosePreference
        }
    }
    
    if ((docker image ls $imageName --quiet)) {
        $previousDigest = (docker image inspect $imageName) | ConvertFrom-Json | ForEach-Object { $_.Id }
    }

    # Build image
    $exp = 'docker image build --isolation "hyperv"'
    if ($image.Memory){
        $exp = $exp+' --memory '+$image.Memory
    }
    if ($image.Args){
        $image.Args.PSobject.Properties | ForEach-Object{
            $exp = $exp+' --build-arg "'+$_.name+'='+$_.value+'"'
        }
    }
    $exp = $exp+' --tag '+$imageName
    $exp = $exp+' "'+$image.Path+'"'

    Write-Host $exp
    Invoke-Expression $exp

    $LASTEXITCODE -ne 0 | Where-Object { $_ } | ForEach-Object { throw ("Build of '{0}' failed" -f $tag) }

    if ($RemoveInstallationSourceFiles) {
        Write-Host ("Done with Installation Source - Removing  '{0}'" -f $targetPath) -ForegroundColor Green
        Remove-Item $targetPath -Force
    }

    if ($PushMode -eq 'Never') {
        Write-Warning "Done. PushMode is set to 'Never' therefore the image is not pushed to the remote repository."
        return
    }
    
    # Determine if we need to push
    $currentDigest = (docker image inspect $tag) | ConvertFrom-Json | ForEach-Object { $_.Id }
    
    if (($PushMode -eq 'IfChanged') -And ($currentDigest -eq $previousDigest)) {
        Write-Host "Done. PushMode is set to 'IfChanged' and the image has not changed since last build, therefore is not pushed to the remote repository." -ForegroundColor Green
        return
    }
    
    # Push image
    docker image push $tag

    $LASTEXITCODE -ne 0 | Where-Object { $_ } | ForEach-Object { throw ("Push of '{0}' failed" -f $tag) }

    Write-Host ("Image '{0}' pushed." -f $tag) -ForegroundColor Green
}
