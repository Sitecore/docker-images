$azureRepository = "visionsincodedockers.azurecr.io"
$userName = "VisionsInCodeDockers"
$password = "cAWAYGoXLQITxyLbMhkB/BUZPFveJ9b1"

# Login
docker login $azureRepository -u $userName -p $password
#$password | docker login --username $userName --password-stdin

# Load module
Import-Module (Join-Path $PSScriptRoot "\modules\SitecoreImageBuilder") -Force

# Settings
$installSourcePath = (Join-Path $PSScriptRoot "\packages") # PATH TO WHERE YOU KEEP ALL SITECORE ZIP FILES AND LICENSE.XML, can be on local machine or a file share.
$registry = $azureRepository ` # On Docker Hub it's your username or organization, else it's the hostname of your own registry.
$sitecoreUsername = "goranhalvarsson@gmail.com"
$sitecorePassword = "chatelet"

$baseTags = "sitecore-*:9.2.0*1903" # optional (default "*"), set to for example "sitecore-*:9.1.1*ltsc2019" to only build 9.1.1 images on ltsc2019/1809.

# Restore packages needed for base images, only files missing in $installSourcePath will be downloaded
SitecoreImageBuilder\Invoke-PackageRestore `
    -Path (Join-Path $PSScriptRoot "\images") `
    -Destination $installSourcePath `
    -Tags $baseTags `
    -SitecoreUsername $sitecoreUsername `
    -SitecorePassword $sitecorePassword

# Build and push base images
SitecoreImageBuilder\Invoke-Build `
    -Path (Join-Path $PSScriptRoot "\images") `
    -InstallSourcePath $installSourcePath `
    -Registry $registry `
    -Tags $baseTags `
    -PushMode "Never" # optional (default "WhenChanged"), can also be "Never" or "Always".

$variantTags = "*:9.2.0*1903" # optional (default "*"), set to for example "sitecore-xm1-sxa-*:9.1.1*ltsc2019" to only build 9.1.1 images on ltsc2019/1809.

# Restore packages needed for variant images, only files missing in $installSourcePath will be downloaded
SitecoreImageBuilder\Invoke-PackageRestore `
    -Path (Join-Path $PSScriptRoot "\variants") `
    -Destination $installSourcePath `
    -Tags $variantTags `
    -SitecoreUsername $sitecoreUsername `
    -SitecorePassword $sitecorePassword

# Build and push variant images
SitecoreImageBuilder\Invoke-Build `
    -Path (Join-Path $PSScriptRoot "\variants") `
    -InstallSourcePath $installSourcePath `
    -Registry $registry `
    -Tags $variantTags `
    -PushMode "Never" # optional (default "WhenChanged"), can also be "Never" or "Always".