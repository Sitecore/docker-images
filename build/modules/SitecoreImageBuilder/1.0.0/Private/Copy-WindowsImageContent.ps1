function Copy-WindowsImageContent
{
    [CmdletBinding()]
    param (
        [Parameter()]
        [string]
        $WindowsAssetImage,
        [Parameter()]
        [string]
        $DestinationPath
    )

    if (!(Test-Path $DestinationPath))
    {
        New-Item $DestinationPath -ItemType Directory -Force
    }
    Write-Message "Copying assets from $WindowsAssetImage to $DestinationPath"
    docker container create --name tempWindows $WindowsAssetImage
    if ($LASTEXITCODE -ne 0)
    {
        throw "Failed to create container"
    }
    docker container cp tempWindows:/module $DestinationPath
    docker container rm -f tempWindows

}