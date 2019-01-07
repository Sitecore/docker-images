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
Import-Module .\build-support.psm1 -Force 

function Find-ExternalBaseImages {
    [cmdletbinding()]
    param(
        [object[]]$Images,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()] 
        [string]$Repository # Can include Organization if needed: <Organization>/<Repository>  | <Repository>
    )

    $externalImages = @{}
    Foreach ($image in $Images) {
        if ($image.BaseImages) {
            Foreach ($baseImage in $image.BaseImages) {
                if (-not $externalImages.ContainsKey($baseImage) -And -not $baseImage.StartsWith($Repository, "CurrentCultureIgnoreCase")) {
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

    $tag = $image.FullName
    
    # Save the digest of previous builds for later comparison
    $previousDigest = $null
    
    if ((docker image ls $tag --quiet)) {
        $previousDigest = (docker image inspect $tag) | ConvertFrom-Json | ForEach-Object { $_.Id }
    }

    Write-Host ("Building '{0}'..." -f $tag)

    # Copy any missing source files into build context
    $image.Sources | ForEach-Object {
        $sourcePath = $_
        $sourceItem = Get-Item -Path $sourcePath
        $targetPath = Join-Path $image.Path $sourceItem.Name

        if (!(Test-Path -Path $targetPath)) {
            Copy-Item $sourceItem -Destination $targetPath -Verbose:$VerbosePreference
        }
    }
    
    if ((docker image ls $tag --quiet)) {
        $previousDigest = (docker image inspect $tag) | ConvertFrom-Json | ForEach-Object { $_.Id }
    }

    # Build image
    $exp = 'docker image build --isolation "hyperv"'
    if ($image.Memory) {
        $exp = $exp + ' --memory ' + $image.Memory
    }
    if ($image.Args) {
        $image.Args.PSobject.Properties | ForEach-Object {
            $exp = $exp + ' --build-arg "' + $_.name + '=' + $_.value + '"'
        }
    }
    $exp = $exp + ' --tag ' + $tag
    $exp = $exp + ' "' + $image.Path + '"'

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
