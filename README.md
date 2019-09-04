# Repository of Sitecore Docker images

[//]: # "start: stats"

[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/licenses/MIT) ![Repositories](https://img.shields.io/badge/Repositories-62-blue.svg) ![Tags](https://img.shields.io/badge/Tags-274-blue.svg) ![Deprecated](https://img.shields.io/badge/Deprecated-27-lightgrey.svg) ![Dockerfiles](https://img.shields.io/badge/Dockerfiles-131-blue.svg)

[//]: # "end: stats"

Build your own Docker images for every released Sitecore version since 8.2 rev. 170407 (Update 3). See [current images](IMAGES.md) for an up-to-date list of which base images available and [Current variants](IMAGES.md#current-variants) for variants, base images with additional modules installed such as SXA and JSS. You can use this repository (preferably from a fork) from you own build server and have it build and push images to your own private Docker registry. Jump to the [How to use](#how-to-use) section for more details.

## IMPORTANT NOTES ABOUT THIS REPOSITORY

- This repository was created to help consolidate efforts around Sitecore and Docker.
- **The code and examples found in this repository are created and maintained by the Community, unsupported by Sitecore and to be used for example purposes only and without official support.**

### Change Log

Please see [Change Log](CHANGELOG.md)

### Complete Image List

Please see [Images](IMAGES.md)

### Tags and Windows versions

This repository now supports multiple Windows versions and support channels ie. "ltsc2016", "1709" and "1803". Read more about [Windows Container Version Compatibility](https://docs.microsoft.com/en-us/virtualization/windowscontainers/deploy-containers/version-compatibility).

Here is the convention used when tagging images:

```text
 registry.example.com/sitecore-xm1-cm:9.0.171219-windowsservercore-1709
 \__________________/ \_____________/ \________/ \____________________/
           |                 |             |               |
   registry/org/user    repository    sc version       os version
```

>Please note that the `sc version` part of the tags matches the corresponding NuGet package version for a given Sitecore version and **not** the "marketing version" ie 9.0.1, 9.0.2 etc. This is to make it clear in the implementing projects which NuGet package versions goes with which tags.  

## How to use

### Prerequisites

- A **private** Docker repository. Any will do, but the easiest is to use a [Azure Container Registry](https://azure.microsoft.com/en-us/services/container-registry/) or to sign-up for a private plan on [https://hub.docker.com](https://hub.docker.com), you need at least the "Small" plan at $12/mo.
- A file share that your build agents can reach, where you have placed zip files downloaded from [https://dev.sitecore.net/](https://dev.sitecore.net/) **and** your license.xml.
- Some kind of build server for example TeamCity, with agents that runs:
  - Windows 10 or Windows Server 2016 that is up to date and on latest build.
  - Hyper-V and Containers Windows features installed.
  - Latest stable Docker engine and cli.

### Configure your build server

1. Trigger on build changes on `master` - to get new versions.
1. Trigger once a week - to get base images updated when Microsoft releases patched images.

> Please note: To build deprecated tags, for example Sitecore 7.5, you need to explicit add it to the `Tags` parameter like so: `-Tags "*:7.5*"`.

Example:

```PowerShell
# Login
"YOUR DOCKER REPOSITORY PASSWORD" | docker login --username "YOUR DOCKER REPOSITORY USERNAME" --password-stdin

# Load module
Import-Module (Join-Path $PSScriptRoot "\modules\SitecoreImageBuilder") -Force

# Settings
$installSourcePath = (Join-Path $PSScriptRoot "\packages") # PATH TO WHERE YOU KEEP ALL SITECORE ZIP FILES AND LICENSE.XML, can be on local machine or a file share.
$registry = "YOUR REGISTRY NAME" ` # On Docker Hub it's your username or organization, else it's the hostname of your own registry.
$sitecoreUsername = "YOUR dev.sitecore.net USERNAME"
$sitecorePassword = "YOUR dev.sitecore.net PASSWORD"

$baseTags = "*" # optional (default "*"), set to for example "sitecore-*:9.1.1*ltsc2019" to only build 9.1.1 images on ltsc2019/1809.

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
    -PushMode "WhenChanged" # optional (default "WhenChanged"), can also be "Never" or "Always".

$variantTags = "*" # optional (default "*"), set to for example "sitecore-xm1-sxa-*:9.1.1*ltsc2019" to only build 9.1.1 images on ltsc2019/1809.

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
    -PushMode "WhenChanged" # optional (default "WhenChanged"), can also be "Never" or "Always".
```
