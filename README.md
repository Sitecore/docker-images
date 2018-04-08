# Repository of Sitecore Docker base images


Build your own Docker images out of every released Sitecore version since 8.2 rev. 170407 (Update 3) - the first version that officially supported Windows Server 2016. You can use this repository *directly* from you own build server and have it build and push images to your own private Docker repository.

There are some more background and details in this post: [https://invokecommand.net/posts/automatically-build-and-update-base-images](https://invokecommand.net/posts/automatically-build-and-update-base-images).

### Important Note about this repository:
This repository was created to help consolidate efforts around Sitecore and Docker. Although some Sitecore employees may contribute to the efforts, the code and examples found in this repository are created and maintained by the Community, unsupported by Sitecore and to be used for example purposes only and without official support.

This repository was created by combining efforts / assets from repos such as [sitecoreops](https://github.com/sitecoreops/sitecore-images) and [sitecore-nine-docker](https://github.com/pbering/sitecore-nine-docker) and [sitecore-docker](https://github.com/avivasolutionsnl/sitecore-docker) repos. Thanks everyone for the great start and please feel free to continue providing feedback by creating an issue, PR, etc.

## Updates
- [Changed] *Breaking Change* - Replace -SkipPush switch with -PushMode parameter controlling when images get pushed to repository with values of 'Always', 'IfChanged', 'Never' 
- [Added] -RemoveInstallationSourceFiles optional switch to delete the sitecore package zip files from the local folder (Does not remove  from InstallationSourcePath)
- [Fixed] Added UrlRewrite outbound rule to handle Sitecore redirect after login when container is running on another port than 80 (possible in Windows 10 Insider builds for the upcoming 1803 release in April).
- [Fixed] Solr build errors regarding downloads from github (TLS 1.2 now used).
- [Added] Specialized Solr image with all Sitecore cores embedded **and** volume support, for Sitecore 9.0.1 (which defaults to use Solr).
- [Added] Specialized SQL Server images with all Sitecore databases embedded **and** volume support, for Sitecore 9.
- [Changed] all Sitecore 9 images now default has connection strings matching the new specialized SQL Server images.
- [Added] XM1 CM and CD role images for Sitecore 9.

## Prerequisites

- A file share that your build agents can reach, where you have placed zip files downloaded from [https://dev.sitecore.net/](https://dev.sitecore.net/) **and** your license.xml.
- Some kind of build server for example TeamCity, with agents that runs:
  - Windows 10 or Windows Server 2016 that is up to date and at least the 1709 build.
  - Hyper-V installed.
  - Latest stable Docker engine and cli.

## How to use

Configure your build server to:

1. Trigger a build on changes to this git repository - to get new versions.
1. Trigger once a week - to get base images updated when Microsoft releases patched images.

./Build.ps1 should be called like this:

````PowerShell
# Login
"YOUR DOCKER REPOSITORY PASSWORD" | docker login --username "YOUR DOCKER REPOSITORY USERNAME" --password-stdin

# Build and push
. (Join-Path $PSScriptRoot "Build.ps1") `
    -VersionsFilter "*" ` # optional, set to for example "9.0*" to only build 9.0 images
    -InstallSourcePath "PATH TO WHERE YOU KEEP ALL SITECORE ZIP FILES AND LICENSE.XML" `
    -Organization "YOUR ORG NAME" ` # On Docker Hub it's your username unless you create an organization
    -Repository "sitecore" `
    -PushMode ` # Optional, Default to 'Never'. Possible values 'Always', 'IfChanged', 'Never'
    -RemoveInstallationSourceFiles # Optional switch to delete the sitecore package zip files from the local folder (Does not remove  from InstallationSourcePath)
````
## Docker Registry

A Docker registry is a storage and content delivery system, holding named Docker images, available in different tagged versions

A **private** Docker registry is a registry with security restrictions which are managed by the registry's owner. It is commonly used by companies to store and share private Docker images among employees and collaborators.

It is not necessary to have a private Docker registry to build this repository�s images, although it will be necessary to use them in multiple machines without having to rebuild them in each machine.

Please notice that, due to licensing constraints, Docker images with Sitecore files cannot be stored or distributed through any **public** registry.

Any private registry may work, although the easiest is to sign-up for a private plan on [https://hub.docker.com](https://hub.docker.com), for a reasonable price.

In case of having a private registry, use the parameter "-PushMode" while building the Docker images to push them to the private repository once they are built.

