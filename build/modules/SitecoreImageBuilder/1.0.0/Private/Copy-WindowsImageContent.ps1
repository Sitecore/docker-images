[CmdletBinding()]
param (
    [Parameter()]
    [string]
    $WindowsAssetImage,
    [Parameter()]
    [string]
    $DestinationPath
)

docker container create --name tempWindows $WindowsAssetImage
docker container cp tempWindows:/module $DestinationPath
docker container rm -f tempWindows