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
    [switch]$SkipPush
)
function Find-BaseImages
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [ValidateScript( {Test-Path $_ -PathType 'Container'})]
        [string]$Path,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$Filter
    )

    Get-ChildItem -Path $Path -Filter $Filter | Foreach-Object {
        Get-ChildItem -Path $_.FullName -Filter "Dockerfile" | Foreach-Object {
            $fromImage = Get-Content -Path $_.FullName | Where-Object { $_.StartsWith("FROM ") } | ForEach-Object { Write-Output $_.Replace("FROM ", "").Trim() }

            if ([string]::IsNullOrEmpty($fromImage))
            {
                throw "Invalid dockerfile '$($_.FullName)', FROM image could not be read."
            }

            Write-Output $fromImage
        }
    }
}

function Find-SitecoreVersions
{
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
        [string]$InstallSourcePath
    )
  
    Get-ChildItem -Path $Path -Filter $Filter | Foreach-Object {
        $version = $_
        $buildFilePath = Join-Path $version.FullName "\build.json"

        if (Test-Path $buildFilePath -PathType Leaf)
        {
            $data = Get-Content -Path $buildFilePath | ConvertFrom-Json
            $sources = $data.sources | ForEach-Object {
                Write-Output (Join-Path $InstallSourcePath $_)
            }

            Write-Output (New-Object PSObject -Property @{
                    Tag     = $data.tag;
                    Path    = $version.FullName;
                    Sources = $sources;
                })
        }
        else
        {
            throw ("Invalid version folder '{0}', file not found: '{1}'." -f $version.Name, $buildFilePath)
        }
    }
}

$ErrorActionPreference = "STOP"

$imagesPath = (Join-Path $PSScriptRoot "\sitecore")

# Pull latest bases images
Find-BaseImages -Path $imagesPath -Filter $VersionsFilter | Select-Object -Unique | ForEach-Object {
    docker pull $_
}

# What to build...
Find-SitecoreVersions -Path $imagesPath -InstallSourcePath $InstallSourcePath -Filter $VersionsFilter | ForEach-Object {
    $version = $_

    # Build up tag to use
    $tag = "{0}:{1}" -f $Repository, $version.Tag

    if (![string]::IsNullOrEmpty($Organization))
    {
        $tag = "{0}/{1}" -f $Organization, $tag
    }
   
    # Save the digest of previous builds for later comparison
    $previousDigest = $null
    
    if ((docker image ls $tag --quiet))
    {
        $previousDigest = (docker image inspect $tag) | ConvertFrom-Json | ForEach-Object { $_.Id }
    }

    Write-Host ("Building '{0}'..." -f $tag)

    # Copy any missing source files into build context
    $version.Sources | ForEach-Object {
        $sourcePath = $_
        $sourceItem = Get-Item -Path $sourcePath
        $targetPath = Join-Path $version.Path $sourceItem.Name

        if (!(Test-Path -Path $targetPath))
        {
            Copy-Item $sourceItem -Destination $targetPath -Verbose:$VerbosePreference
        }
    }
    
    # Build image
    if ($tag -like "*SQL*")
    {
        # Building SQL based images requires more memory than the default 2GB
        docker image build --isolation "hyperv" --memory 4GB --tag $tag $version.Path
    }
    else
    {
        docker image build --isolation "hyperv" --tag $tag $version.Path
    }

    $LASTEXITCODE -ne 0 | Where-Object { $_ } | ForEach-Object { throw ("Build of '{0}' failed" -f $tag) }

    # Determine if we need to push
    $currentDigest = (docker image inspect $tag) | ConvertFrom-Json | ForEach-Object { $_.Id }

    if ($currentDigest -eq $previousDigest)
    {
        Write-Host "Done, current digest is the same as the previous, image has not changed since last build." -ForegroundColor Green

        return
    }
    
    if ($SkipPush)
    {
        Write-Warning "Done, SkipPush switch used."

        return
    }
    
    # Push image
    docker image push $tag

    $LASTEXITCODE -ne 0 | Where-Object { $_ } | ForEach-Object { throw ("Push of '{0}' failed" -f $tag) }

    Write-Host ("Image '{0}' pushed." -f $tag) -ForegroundColor Green
}