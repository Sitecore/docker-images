function Get-CurrentImagesMarkdown
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [ValidateScript( { Test-Path $_ -PathType "Container" })]
        [string]$Path
        ,
        [Parameter(Mandatory = $false)]
        [array]$AutoGenerateWindowsVersionTags = (Get-SupportedWindowsVersions)
    )

    Write-Output "| Version | Repository | OS  | Build      | Tag |"
    Write-Output "| ------- | ---------- | --- | -----------| --- |"

    Get-CurrentImages -Path $Path -AutoGenerateWindowsVersionTags $AutoGenerateWindowsVersionTags | Sort-Object -Property Version, Build, Repository -Descending | ForEach-Object {
        $dockerFileUrl = (Resolve-Path $_.DockerFilePath -Relative).Replace(".\", "").Replace("\", "/").Replace(" ", "%20")

        if ($_.Deprecated)
        {
            Write-Output ("| ~~{0}~~ | ~~{1}~~ | ~~{2}~~ | ~~{3}~~ | ~~``{4}`` [Dockerfile]({5})~~ |" -f $_.Version, $_.Repository, $_.OS, $_.Build, $_.Tag, $dockerFileUrl)
        }
        else
        {
            Write-Output ("| {0} | {1} | {2} | {3 } | ``{4}`` [Dockerfile]({5}) |" -f $_.Version, $_.Repository, $_.OS, $_.Build, $_.Tag, $dockerFileUrl)
        }
    }
}
