[CmdletBinding()]
param(
    [Parameter(Mandatory = $false)]
    [string]$VersionsFilter = "*",
    [Parameter(Mandatory = $true)]
    [ValidateScript( {Test-Path $_ -PathType 'Container'})] 
    [string]$InstallSourcePath
)

function Find-SitecoreVersions {
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

        if (Test-Path $buildFilePath -PathType Leaf) {
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
        else {
            throw ("Invalid version folder '{0}', file not found: '{1}'." -f $version.Name, $buildFilePath)
        }
    }
}

$ErrorActionPreference = "STOP"

$imagesPath = (Join-Path $PSScriptRoot "\sitecore")


# What to build...
Find-SitecoreVersions -Path $imagesPath -InstallSourcePath $InstallSourcePath -Filter $VersionsFilter | ForEach-Object {
    $version = $_

    # Build up tag to use
    $tag = $version.Tag

    Write-Host ("Checking '{0}'..." -f $tag)

    # Copy any missing source files into build context
    $version.Sources | ForEach-Object {
        $sourcePath = $_
        if (!(Test-Path -Path $sourcePath)) {
            Write-Host ("Missing source: '{0}'..." -f $sourcePath) -ForegroundColor Red
        }else{
            Write-Host ("Found Source: '{0}'..." -f $sourcePath) -ForegroundColor Green
        }
    }
    
}