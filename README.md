# Repository of Sitecore Docker base images

Build your own Docker images out of every released Sitecore version since 8.2 rev. 170407 (Update 3) - the first version that officially supported Windows Server 2016. You can use this repository *directly* from you own build server and have it build and push images to your own private Docker repository.

## Prerequisites

* A **private** Docker repository. Any will do, but the easiest is to sign-up for a private plan on [https://hub.docker.com](https://hub.docker.com), the cheapest one is $7/mo.
* Some kind of build server for example TeamCity, with agents that runs:
  * Windows 10 or Windows Server 2016 that is up to date and at least the 1709 build.
  * Hyper-V installed.
  * Latest stable Docker engine and cli.
* A file share that your build agents can reach, where you have placed zip files downloaded from [https://dev.sitecore.net/](https://dev.sitecore.net/) and your license.xml.

## How to use

Configure your build server to:

1. Trigger a build on changes to this git repository - to get new versions.
1. Trigger once a week - to get base images updated when Microsoft releases patched images.

./Build.ps1 should be called like this:

````PowerShell
# Login
"YOUR DOCKER REPOSITORY PASSWORD" | docker login --username "YOUR DOCKER REPOSITORY USERNAME" --password-stdin

# Build
. (Join-Path $PSScriptRoot "Build.ps1") `
    -InstallSourcePath "PATH TO WHERE YOU KEEP ALL SITECORE ZIP FILES AND LICENSE.XML" `
    -Organization "YOUR ORG NAME" ` # On Docker Hub it's your username unless you create an organization
    -Repository "sitecore"
````
