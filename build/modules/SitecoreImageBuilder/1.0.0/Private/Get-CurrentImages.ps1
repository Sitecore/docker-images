function Get-CurrentImages
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

    $tagParser = [regex]"^(?<repository>[^:]*):(?<version>[^-]*)-(?<os>[^-]+)(?:-(?<build>.*))?$"

    Get-BuildSpecifications -Path $Path -AutoGenerateWindowsVersionTags $AutoGenerateWindowsVersionTags | ForEach-Object {
        $spec = $_
        $match = $tagParser.Match($spec.Tag)

        if ($match.Success)
        {
            $repository = $match.Groups["repository"].Value
            $version = $match.Groups["version"].Value
            $os = $match.Groups["os"].Value
            $build = $match.Groups["build"].Value

            Write-Output (New-Object PSObject -Property @{
                    Repository     = $repository;
                    Version        = $version;
                    OS             = $os;
                    Build          = $build;
                    Deprecated     = $spec.Deprecated;
                    Tag            = $spec.Tag;
                    DockerFilePath = $spec.DockerFilePath;
                })
        }
    }
}
