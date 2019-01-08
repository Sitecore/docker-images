# Repository of Sitecore Docker base images


Build your own Docker images out of every released Sitecore version since 8.2 rev. 170407 (Update 3) - the first version that officially supported Windows Server 2016. You can use this repository *directly* from your own build server and build and push images to your own private Docker repository.

There are some more background and details in this post: [https://invokecommand.net/posts/automatically-build-and-update-base-images](https://invokecommand.net/posts/automatically-build-and-update-base-images).

### Important Note about this repository:
This repository was created to help consolidate efforts around Sitecore and Docker. Although some Sitecore employees may contribute to the efforts, the code and examples found in this repository are created and maintained by the Community, unsupported by Sitecore and to be used for example purposes only and without official support.

This repository was created by combining efforts / assets from repos such as [sitecoreops](https://github.com/sitecoreops/sitecore-images) and [sitecore-nine-docker](https://github.com/pbering/sitecore-nine-docker) and [sitecore-docker](https://github.com/avivasolutionsnl/sitecore-docker) repos. Thanks everyone for the great start and please feel free to continue providing feedback by creating an issue, PR, etc.

## Updates
- [Changed] *Breaking Change* - Replace -SkipPush switch with -PushMode parameter controlling when images get pushed to repository with values of 'Always', 'IfChanged', 'Never' 
- [Added] -RemoveInstallationSourceFiles optional switch to delete the Sitecore package zip files from the local folder (Does not remove  from InstallationSourcePath)
- [Fixed] Added UrlRewrite outbound rule to handle Sitecore redirect after login when container is running on another port than 80 (possible in Windows 10 Insider builds for the upcoming 1803 release in April).
- [Fixed] Solr build errors regarding downloads from GitHub (TLS 1.2 now used).
- [Added] Specialized Solr image with all Sitecore cores embedded **and** volume support, for Sitecore 9.0.1 (which defaults to use Solr).
- [Added] Specialized SQL Server images with all Sitecore databases embedded **and** volume support, for Sitecore 9.
- [Changed] all Sitecore 9 images now default has connection strings matching the new specialized SQL Server images.
- [Added] XM1 CM and CD role images for Sitecore 9.
### August 2018
- [Changed] *Breaking Change* Replaced Build.ps1 by new module "Sitecore.DockerImages.Management"
- [New] *Breaking Change* Dependency on external module "Bendev.Assets.Management"
- [Changed] *Breaking Change* New folder naming
- [New] XP Single base image
- [New] XP Single image
- [Changed] Containers' layers optimisation
- [Changed] Performance optimisations

## Prerequisites

- A file share that your build agents can reach, where you have placed zip files downloaded from [https://dev.sitecore.net/](https://dev.sitecore.net/) **and** your license.xml.
- Some kind of build server for example TeamCity, with agents that runs:
  - Windows 10 or Windows Server 2016 that is up to date and at least the 1709 build.
  - Hyper-V installed.
  - Latest stable Docker engine and cli.
  - The following PowerShell modules installed (to be installed in the same order as shown below):
    - "Bendev.Assets.Management": Available on the PowerShell Gallery: https://www.powershellgallery.com/packages/Bendev.Assets.Management
        ````PowerShell
        # Install module from PowerShell Gallery:
        Install-Module -Name Bendev.Assets.Management
        ````
    - "Sitecore.DockerImages.Management": Available in this repository under "/modules/Sitecore.DockerImages.Management/"
        ````PowerShell
        # Install module from Repository folder (path to be changed as needed):
         CD "C:\Docker\Sitecore\docker-images\modules\Sitecore.DockerImages.Management"
         .\install.ps1
        ````
## How to use

### Get ready

The build process is performed by the module "Sitecore.DockerImages.Management". This module replaces the old PowerShell script named "Build.ps1". 

Before using the "Sitecore.DockerImages.Management" module, it needs to be imported with one of the following instructions:

````PowerShell
# Loading the module from standard PowerShell's modules folder
Import-Module Sitecore.DockerImages.Management -Force -Verbose

# Loading the module directly from the repository's code
Import-Module –Name 'C:\docker\Sitecore\docker-images\modules\Sitecore.DockerImages.Management' -Force -Verbose
````


### Build process

The build process should be triggered as follows:

````PowerShell
# Login
"YOUR DOCKER REPOSITORY PASSWORD" | docker login --username "YOUR DOCKER REPOSITORY USERNAME" --password-stdin

# Build and push
Invoke-SitecoreDockerImageBuild `
  -BuildRootPath "c:\\docker\\Sitecore\\docker-images\\sitecore" `
  -VersionsFilter ".*\\9\.0\.2 rev\. 180604\\.*sitecore-xpsingle.*\\windowsservercore-ltsc2016$" `
  -AssetsSourcePath "c:\\Software\\Sitecore\\Repository\\" `
  -AssetsTransformPath "c:\tmp" `
  -Registry "YourPrivateRepo.azurecr.io" `
  -Isolation 'None' `
  -PushMode 'Never' 
````

Where:
- **BuildRootPath**: Mandatory. Path to the root folder where all images are defined.
- **VersionsFilter**: Optional. Regular expression used to filter the images to be built based on their full path.
- **AssetsSourcePath**: Mandatory. Path to the folder where the required installation files can be found. The Sitecore license file should also be in this folder
- **AssetsTransformPath**: Optional. Path to the folder where the source assets will be pre-processed before being handled to the Docker build context. If missing the folder indicated with parameter "AssetsSourcePath" will be used instead.
- **Registry**: Mandatory. Name of the private docker registry where the new docker images will belong to
- **Isolation**: Optional. Supported values: 'None' and 'hyperv'. Default: 'hyperv'. It allows to specify the parameter "--isolation" in the [docker build](https://docs.docker.com/engine/reference/commandline/build/#specify-isolation-technology-for-container---isolation) command.
- **PushMode**: Optional. Supported values: 'Always', 'IfChanged', 'Never'. Default: 'Never'. Indicates whether the images must be pushed to the registry after it is built.
- **RemoveInstallationAssetFiles**: Optional. Supported values: true and false, Default: false. Indicates whether installation assets should be removed after building the images.
- **WhatIf**: Optional. Allows to check whether the images' assets exist without performing further actions.

Please notice that the module "Sitecore.DockerImages.Management" has a dependency on the module "Bendev.Assets.Management" and must be installed and imported after the "Bendev.Assets.Management" is installed.

### Build Server

Configure your build server to:

1. Trigger a build on changes to this git repository - to get new versions.
1. Trigger once a week - to get base images updated when Microsoft releases patched images.


## Docker Registry

A Docker registry is a storage and content delivery system, holding named Docker images, available in different tagged versions

A **private** Docker registry is a registry with security restrictions which are managed by the registry's owner. It is commonly used by companies to store and share private Docker images among employees and collaborators.

It is not necessary to have a private Docker registry to build this repository’s images, although it will be necessary to use them in multiple machines without having to rebuild them in each machine.

Please notice that, due to licensing constraints, Docker images with Sitecore files cannot be stored or distributed through any **public** registry.

Any private registry may work, although the easiest is to sign-up for a private plan on [https://hub.docker.com](https://hub.docker.com), for a reasonable price.

In case of having a private registry, use the parameter "-PushMode" while building the Docker images to push them to the private repository once they are built.

## Check Docker Image Definitions and their sources

The process of building one or more Sitecore images may take from minutes to hours depending on the number of images to build. It is common to leave it running unattended with the possibility of failing and stopping after some some time without finishing. Therefore, it is recommended to validate some parameters before starting the build process.

There is an easy way to perform a check just by adding the parameter `-WhatIf` to the same PowerShell function that is used to build the images (`Invoke-SitecoreDockerImageBuild`). This way, the function will perform a scan of the image definition files filtered by the parameter `-VersionsFilter` and will also check the existance in the source folder (indicated with the parameter `-AssetsSourcePath`) of the assets/files required by the those same images.

Example:

````PowerShell
# Check parameters:
Invoke-SitecoreDockerImageBuild `
  -BuildRootPath "c:\\docker\\Sitecore\\docker-images\\sitecore" `
  -VersionsFilter ".*\\9\.0\.2 rev\. 180604\\.*sitecore-xpsingle.*\\windowsservercore-ltsc2016$" `
  -AssetsSourcePath "c:\\Software\\Sitecore\\Repository\\" `
  -AssetsTransformPath "c:\tmp" `
  -Registry "YourPrivateRepo.azurecr.io" `
  -Isolation 'None' `
  -PushMode 'Never' `
  -WhatIf
````
Notice the latest parameter `-WhatIf`.
