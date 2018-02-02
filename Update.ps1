[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [ValidateScript( {Test-Path $_ -PathType 'Container'})] 
    [string]$VersionsPath,
    [Parameter(Mandatory = $false)]
    [string]$GitPushUrl
)

$ErrorActionPreference = "STOP"

function Find-MostRecentTag
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()] 
        [string]$ImagePrefix
    )

    $repository = $ImagePrefix -split ":" | Select-Object -First 1
    $response = Invoke-RestMethod -Uri "https://hub.docker.com/v2/repositories/$repository/tags?page_size=100" -Verbose:$false
    $latest = $response.results | Foreach-Object { Write-Output ("{0}:{1}" -f $repository, $_.name) }
    $latestTag = $latest | Where-Object { $_.StartsWith($ImagePrefix) } | Select-Object -First 1
    
    if ($latestTag -eq $null)
    {
        throw "Could not determine most recent tag for '$ImagePrefix'."
    }

    Write-Output $latestTag
}

function Update-DockerFile
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [ValidateScript( {Test-Path $_ -PathType Leaf})] 
        [string]$Path
    )

    $fileContent = Get-Content $Path
    $fromLine = $fileContent | Where-Object { $_.StartsWith("FROM ") }
    $fromImage = $fromLine.Replace("FROM ", "")
    
    # SAC is "Semi-Annual Channel" and LTSC is "Long-Term Servicing Channel"
    # In near future I assume that tags with "1709" change to "sac" instead...
    $channel = @{ $true = "sac"; $false = "ltsc" }[$fromImage.Contains("1709")]

    if($channel -eq "sac") 
    {
        $fromImagePrefix = "{0}-1709_" -f $fromImage.Substring(0, $fromImage.LastIndexOf("-"))
    }
    else 
    {
        $fromImagePrefix = "{0}-10" -f $fromImage.Substring(0, $fromImage.LastIndexOf("-"))
    }

    Write-Host "---"
    Write-Host "File: $Path"
    Write-Host "Image: $fromImage"
    Write-Host "Channel: $channel"
    Write-Host "Prefix: $fromImagePrefix"

    $latestFromImage = Find-MostRecentTag -ImagePrefix $fromImagePrefix

    if ($fromImage -eq $latestFromImage)
    {
        Write-Host ("Skipping '{0}', already using latest image." -f $Path)

        return
    }

    Write-Host ("Updating '{0}' from '{1}' to '{2}'." -f $Path, $fromImage, $latestFromImage)

    $newFileContent = $fileContent.Replace($fromLine, "FROM $latestFromImage")

    [System.IO.File]::WriteAllLines($Path, $newFileContent, (New-Object System.Text.UTF8Encoding $false))
}

# Check if git is present
if ((Get-Command "git" -ErrorAction SilentlyContinue) -eq $null)
{
    throw "Could not find the git command"
}

# Check to see if there is newer base images for each Dockerfile and update accordingly
Get-ChildItem -Path $VersionsPath -Recurse -Filter "Dockerfile" | ForEach-Object {
    Update-DockerFile -Path $_.FullName
}

# Commit and push if there are any changes
if ((git status --short) -ne $null)
{
    if ([string]::IsNullOrEmpty($GitPushUrl))
    {
        Write-Warning "Skipping push, there was changes but you didn't supply the -GitPushUrl parameter..."

        return
    }
    
    git add --all
    git commit --message "base images updated to latest os version" --quiet
    git push --quiet $GitPushUrl

    Write-Host "Done pushing changes!" -ForegroundColor Green
}
else
{
    Write-Host "No changes to push..."
}