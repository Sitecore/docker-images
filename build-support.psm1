
# borrowed from https://github.com/RamblingCookieMonster/PSDepend/blob/master/PSDepend/Private/Get-ClonedObject.ps1
Function Get-ClonedObject {
    param($DeepCopyObject)
    $memStream = new-object IO.MemoryStream
    $formatter = new-object Runtime.Serialization.Formatters.Binary.BinaryFormatter
    $formatter.Serialize($memStream, $DeepCopyObject)
    $memStream.Position = 0
    $formatter.Deserialize($memStream)
}

#--------------------------------------------------------------------------------------------------
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
#--------------------------------------------------------------------------------------------------
# borrowed from https://github.com/RamblingCookieMonster/PSDepend/blob/master/PSDepend/Private/Sort-PSDependency.ps1
function Sort-Images {
    [cmdletbinding()]
    param(
        [object[]]$Images
    )

    $Order = @{}
    Foreach ($Image in $Images) {
        if ($Image.BaseImages) {
            if (-not $Order.ContainsKey($Image.FullName)) {
                $Order.add($Image.FullName, $Image.BaseImages)
            }
        }
    }

    if ($Order.Keys.Count -gt 0) {
        $ImageOrder = Get-TopologicalSort $Order
        Sort-ObjectWithCustomList -InputObject $Images -Property FullName -CustomList $ImageOrder
    }
    else {
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
            if ($data.args) {
                $args = $data.args
                $args.PSobject.Properties | ForEach-Object {
                    if ($_.value -is [string]) {
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
                    Tag        = $data.tag;
                    Args       = $args;
                    FullName   = $imageName;
                    Memory     = $data.memory;
                    Path       = $imageFolder.FullName;
                    BaseImages = $baseImages;
                    Sources    = $sources;
                })
        }
        else {
            throw ("Invalid version folder '{0}', file not found: '{1}'." -f $imageFolder.Name, $buildFilePath)
        }
    }
}
