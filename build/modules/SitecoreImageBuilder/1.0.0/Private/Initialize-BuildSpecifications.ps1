function Initialize-BuildSpecifications
{
    param(
        [Parameter(Mandatory = $true)]
        [ValidateNotNull()]
        [PSCustomObject]$Specifications
        ,
        [Parameter(Mandatory = $true)]
        [ValidateScript( { Test-Path $_ -PathType "Container" })]
        [string]$InstallSourcePath
        ,
        [Parameter(Mandatory = $false)]
        [array]$Tags
        ,
        [Parameter(Mandatory = $false)]
        [ValidateSet("Include", "Skip")]
        [string]$ImplicitTagsBehavior = "Include"
        ,
        [Parameter(Mandatory = $false)]
        [ValidateSet("Include", "Skip")]
        [string]$DeprecatedTagsBehavior = "Skip"
        ,
        [Parameter(Mandatory = $false)]
        [ValidateSet("Include", "Skip")]
        [string]$ExperimentalTagBehavior = "Skip"
    )

    if ($Tags -eq $null)
    {
        $Tags = Get-LatestSupportedVersionTags -Specs $Specifications
    }

    # Update specs, resolve sources to full path
    $Specifications | ForEach-Object {
        $spec = $_
        $sources = @()

        $spec.Sources | ForEach-Object {
            $sources += (Join-Path $InstallSourcePath $_)
        }

        $spec.Sources = $sources
    }

    # Update specs, include or not
    $Specifications | ForEach-Object {
        $spec = $_

        $spec.Include = ($Tags | ForEach-Object { $spec.Tag -like $_ }) -contains $true

        if ($spec.Include -eq $true -and $spec.Deprecated -eq $true -and $DeprecatedTagsBehavior -eq "Skip")
        {
            $spec.Include = $false

            Write-Message ("Tag '{0}' excluded as it is deprecated and the DeprecatedTagsBehavior parameter is '{1}'." -f $spec.Tag, $DeprecatedTagsBehavior) -Level Verbose
        }

        if ($spec.Include -eq $true -and $spec.Experimental -eq $true -and $ExperimentalTagBehavior -eq "Skip")
        {
            $spec.Include = $false

            Write-Message ("Tag '{0}' excluded as it is experimental and the ExperimentalTagBehavior parameter is '{1}'." -f $spec.Tag, $ExperimentalTagBehavior) -Level Verbose
        }
    }

    # Update specs, re-include base images
    if ($ImplicitTagsBehavior -eq "Include")
    {
        $Specifications | Where-Object { $_.Include -eq $true } | ForEach-Object {
            $spec = $_

            # Recursively iterate base images and re-include them if needed
            $baseSpecs = @($Specifications | Where-Object { $_.Include -eq $false -and $spec.Base -contains $_.Tag })

            while ($null -ne $baseSpecs -and $baseSpecs.Length -gt 0)
            {
                $baseSpecs | ForEach-Object {
                    $baseSpec = $_
                    $baseSpec.Include = $true

                    Write-Message ("Tag '{0}' implicitly included '{1}' due to dependency." -f $spec.Tag, $baseSpec.Tag) -Level Verbose
                }

                $baseSpecs = @($Specifications | Where-Object { $_.Include -eq $false -and $baseSpecs.Base -contains $_.Tag })
            }
        }
    }

    # Build graph of all image tags and their base image tags
    $graph = [hashtable]::new()

    $Specifications | Where-Object { $_.Include -eq $true } | ForEach-Object {
        $spec = $_

        $graph.Add($spec.Tag, $spec.Base)
    }

    # Sort the graph so dependencies of images is always before the image that has the dependency (using topological sorting / dependency resolution)
    $sorted = @(Get-TopologicalSort -InputObject $graph)

    # Assign sortable number to each image tag
    $priorities = [System.Collections.Specialized.OrderedDictionary]::new()

    for ($i = 0; $i -lt $sorted.Count; $i++)
    {
        $priorities.Add($sorted[$i], $i)
    }

    # Update specifications with sortable number
    $Specifications | Where-Object { $_.Include -eq $true } | ForEach-Object {
        $spec = $_

        $spec.Priority = $priorities[$spec.Tag]
    }

    # Copy specs sorted by priority into new array
    $specs = [System.Collections.ArrayList]@()
    $specs.AddRange(@($Specifications | Sort-Object -Property Priority))

    # Done
    return $specs
}