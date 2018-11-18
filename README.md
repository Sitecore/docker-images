# Repository of Sitecore Docker base images

Build your own Docker images out of every released Sitecore version since 8.2 rev. 170407 (Update 3) - the first version that officially supported Windows Server 2016. You can use this repository (preferably from a fork so you are in control of updates) from you own build server and have it build and push images to your private Docker repository.

There are some more background and details in this post: [https://invokecommand.net/posts/automatically-build-and-update-base-images](https://invokecommand.net/posts/automatically-build-and-update-base-images).

## Updates

- [Added] Sitecore 9.0.2 XM1 CM/CD, SQL Developer on ltsc2019 and Solr on 1809.
- [Changed] Migrated Microsoft base images to use the [new official registry "mcr.microsoft.com"](https://azure.microsoft.com/en-us/blog/microsoft-syndicates-container-catalog/).
- [Added] Sitecore 8.2.180406 Solr on nanoserver-1803.
- [Added] Sitecore 8.2.180406 SQL Developer on windowsservercore-1803.
- [Added] CD, CM, Processing and Reporting roles to Sitecore 8.2.180406 on windowsservercore-1803.
- [Added] Sitecore 8.2.* on windowsservercore-1803.
- [Added] Sitecore 9.0.2 XM1 CM/CD, SQL Developer and Solr on 1803.
- [Added] Sitecore 9.0.1 on windowsservercore-1803.
- [Added] Sitecore 9.0.1 Solr on nanoserver-1803.
- [Added] Sitecore 9.0.1 SQL Developer on windowsservercore-1803.
- [Added] Sitecore 9.0.1 Solr on windowsservercore-1709.
- [Added] Sitecore 9.0.1 SQL Developer on windowsservercore-1709.
- [Breaking] Restructured versions and tags to support multiple Windows channels (ltsc2016, 1709, 1803 etc), there are now more repositories per version, one for each topology/role. See [Tags and Windows versions](#tags-and-windows-versions).
- [Breaking] Decoupled image tags from structure by specifying full tag in "build.json".
- [Added] Sitecore 8.2 Update 7.
- [Fixed] Added UrlRewrite outbound rule to handle Sitecore redirect after login when container is running on another port than 80 (possible in Windows 10 1803).
- [Fixed] Solr build errors regarding downloads from github (TLS 1.2 now used).
- [Added] Specialized Solr image with all Sitecore cores embedded **and** volume support, for Sitecore 9.0.1 (which defaults to use Solr).
- [Added] Specialized SQL Server images with all Sitecore databases embedded **and** volume support, for Sitecore 9.
- [Changed] all Sitecore 9 images now default has connection strings matching the new specialized SQL Server images.
- [Added] XM1 CM and CD role images for Sitecore 9.

## Current images

| Version | Repository | OS  | OS Version | Tag |
| ------- | ---------- | --- | -----------| --- |
| 9.0.180604 | sitecore-xm1-cm | windowsservercore | ltsc2019 | `sitecore-xm1-cm:9.0.180604-windowsservercore-ltsc2019` [Dockerfile](images/9.0.2%20rev.%20180604/windowsservercore-ltsc2019/sitecore-xm1-cm/Dockerfile) |
| 9.0.180604 | sitecore-xm1-cd | windowsservercore | ltsc2019 | `sitecore-xm1-cd:9.0.180604-windowsservercore-ltsc2019` [Dockerfile](images/9.0.2%20rev.%20180604/windowsservercore-ltsc2019/sitecore-xm1-cd/Dockerfile) |
| 9.0.180604 | sitecore-sqldev | windowsservercore | ltsc2019 | `sitecore-sqldev:9.0.180604-windowsservercore-ltsc2019` [Dockerfile](images/9.0.2%20rev.%20180604/windowsservercore-ltsc2019/sitecore-sqldev/Dockerfile) |
| 9.0.180604 | sitecore-base | windowsservercore | ltsc2019 | `sitecore-base:9.0.180604-windowsservercore-ltsc2019` [Dockerfile](images/9.0.2%20rev.%20180604/windowsservercore-ltsc2019/sitecore-base/Dockerfile) |
| 9.0.180604 | sitecore-solr | nanoserver | 1809 | `sitecore-solr:9.0.180604-nanoserver-1809` [Dockerfile](images/9.0.2%20rev.%20180604/nanoserver-1809/sitecore-solr/Dockerfile) |
| 9.0.180604 | sitecore-xm1-cm | windowsservercore | 1803 | `sitecore-xm1-cm:9.0.180604-windowsservercore-1803` [Dockerfile](images/9.0.2%20rev.%20180604/windowsservercore-1803/sitecore-xm1-cm/Dockerfile) |
| 9.0.180604 | sitecore-xm1-cd | windowsservercore | 1803 | `sitecore-xm1-cd:9.0.180604-windowsservercore-1803` [Dockerfile](images/9.0.2%20rev.%20180604/windowsservercore-1803/sitecore-xm1-cd/Dockerfile) |
| 9.0.180604 | sitecore-sqldev | windowsservercore | 1803 | `sitecore-sqldev:9.0.180604-windowsservercore-1803` [Dockerfile](images/9.0.2%20rev.%20180604/windowsservercore-1803/sitecore-sqldev/Dockerfile) |
| 9.0.180604 | sitecore-solr | nanoserver | 1803 | `sitecore-solr:9.0.180604-nanoserver-1803` [Dockerfile](images/9.0.2%20rev.%20180604/nanoserver-1803/sitecore-solr/Dockerfile) |
| 9.0.180604 | sitecore-base | windowsservercore | 1803 | `sitecore-base:9.0.180604-windowsservercore-1803` [Dockerfile](images/9.0.2%20rev.%20180604/windowsservercore-1803/sitecore-base/Dockerfile) |
| 9.0.171219 | sitecore-sqldev | windowsservercore | ltsc2016 | `sitecore-sqldev:9.0.171219-windowsservercore-ltsc2016` [Dockerfile](images/9.0.1%20rev.%20171219/windowsservercore-ltsc2016/sitecore-sqldev/Dockerfile) |
| 9.0.171219 | sitecore-solr | nanoserver | ltsc2016 | `sitecore-solr:9.0.171219-nanoserver-ltsc2016` [Dockerfile](images/9.0.1%20rev.%20171219/nanoserver-ltsc2016/sitecore-solr/Dockerfile) |
| 9.0.171219 | sitecore-xm1-cm | windowsservercore | 1803 | `sitecore-xm1-cm:9.0.171219-windowsservercore-1803` [Dockerfile](images/9.0.1%20rev.%20171219/windowsservercore-1803/sitecore-xm1-cm/Dockerfile) |
| 9.0.171219 | sitecore-xm1-cd | windowsservercore | 1803 | `sitecore-xm1-cd:9.0.171219-windowsservercore-1803` [Dockerfile](images/9.0.1%20rev.%20171219/windowsservercore-1803/sitecore-xm1-cd/Dockerfile) |
| 9.0.171219 | sitecore-sqldev | windowsservercore | 1803 | `sitecore-sqldev:9.0.171219-windowsservercore-1803` [Dockerfile](images/9.0.1%20rev.%20171219/windowsservercore-1803/sitecore-sqldev/Dockerfile) |
| 9.0.171219 | sitecore-solr | nanoserver | 1803 | `sitecore-solr:9.0.171219-nanoserver-1803` [Dockerfile](images/9.0.1%20rev.%20171219/nanoserver-1803/sitecore-solr/Dockerfile) |
| 9.0.171219 | sitecore-base | windowsservercore | 1803 | `sitecore-base:9.0.171219-windowsservercore-1803` [Dockerfile](images/9.0.1%20rev.%20171219/windowsservercore-1803/sitecore-base/Dockerfile) |
| 9.0.171219 | sitecore-xm1-cm | windowsservercore | 1709 | `sitecore-xm1-cm:9.0.171219-windowsservercore-1709` [Dockerfile](images/9.0.1%20rev.%20171219/windowsservercore-1709/sitecore-xm1-cm/Dockerfile) |
| 9.0.171219 | sitecore-xm1-cd | windowsservercore | 1709 | `sitecore-xm1-cd:9.0.171219-windowsservercore-1709` [Dockerfile](images/9.0.1%20rev.%20171219/windowsservercore-1709/sitecore-xm1-cd/Dockerfile) |
| 9.0.171219 | sitecore-sqldev | windowsservercore | 1709 | `sitecore-sqldev:9.0.171219-windowsservercore-1709` [Dockerfile](images/9.0.1%20rev.%20171219/windowsservercore-1709/sitecore-sqldev/Dockerfile) |
| 9.0.171219 | sitecore-solr | nanoserver | 1709 | `sitecore-solr:9.0.171219-nanoserver-1709` [Dockerfile](images/9.0.1%20rev.%20171219/nanoserver-1709/sitecore-solr/Dockerfile) |
| 9.0.171219 | sitecore-base | windowsservercore | 1709 | `sitecore-base:9.0.171219-windowsservercore-1709` [Dockerfile](images/9.0.1%20rev.%20171219/windowsservercore-1709/sitecore-base/Dockerfile) |
| 9.0.171002 | sitecore-sqldev | windowsservercore | ltsc2016 | `sitecore-sqldev:9.0.171002-windowsservercore-ltsc2016` [Dockerfile](images/9.0.0%20rev.%20171002/windowsservercore-ltsc2016/sitecore-sqldev/Dockerfile) |
| 9.0.171002 | sitecore-xm1-cm | windowsservercore | 1709 | `sitecore-xm1-cm:9.0.171002-windowsservercore-1709` [Dockerfile](images/9.0.0%20rev.%20171002/windowsservercore-1709/sitecore-xm1-cm/Dockerfile) |
| 9.0.171002 | sitecore-xm1-cd | windowsservercore | 1709 | `sitecore-xm1-cd:9.0.171002-windowsservercore-1709` [Dockerfile](images/9.0.0%20rev.%20171002/windowsservercore-1709/sitecore-xm1-cd/Dockerfile) |
| 9.0.171002 | sitecore-base | windowsservercore | 1709 | `sitecore-base:9.0.171002-windowsservercore-1709` [Dockerfile](images/9.0.0%20rev.%20171002/windowsservercore-1709/sitecore-base/Dockerfile) |
| 8.2.180406 | sitecore-sqldev | windowsservercore | 1803 | `sitecore-sqldev:8.2.180406-windowsservercore-1803` [Dockerfile](images/8.2%20rev.%20180406/windowsservercore-1803/sitecore-sqldev/Dockerfile) |
| 8.2.180406 | sitecore-solr | nanoserver | 1803 | `sitecore-solr:8.2.180406-nanoserver-1803` [Dockerfile](images/8.2%20rev.%20180406/nanoserver-1803/sitecore-solr/Dockerfile) |
| 8.2.180406 | sitecore-reporting | windowsservercore | 1803 | `sitecore-reporting:8.2.180406-windowsservercore-1803` [Dockerfile](images/8.2%20rev.%20180406/windowsservercore-1803/sitecore-reporting/Dockerfile) |
| 8.2.180406 | sitecore-processing | windowsservercore | 1803 | `sitecore-processing:8.2.180406-windowsservercore-1803` [Dockerfile](images/8.2%20rev.%20180406/windowsservercore-1803/sitecore-processing/Dockerfile) |
| 8.2.180406 | sitecore-cm | windowsservercore | 1803 | `sitecore-cm:8.2.180406-windowsservercore-1803` [Dockerfile](images/8.2%20rev.%20180406/windowsservercore-1803/sitecore-cm/Dockerfile) |
| 8.2.180406 | sitecore-cd | windowsservercore | 1803 | `sitecore-cd:8.2.180406-windowsservercore-1803` [Dockerfile](images/8.2%20rev.%20180406/windowsservercore-1803/sitecore-cd/Dockerfile) |
| 8.2.180406 | sitecore | windowsservercore | 1803 | `sitecore:8.2.180406-windowsservercore-1803` [Dockerfile](images/8.2%20rev.%20180406/windowsservercore-1803/sitecore/Dockerfile) |
| 8.2.180406 | sitecore | windowsservercore | 1709 | `sitecore:8.2.180406-windowsservercore-1709` [Dockerfile](images/8.2%20rev.%20180406/windowsservercore-1709/Dockerfile) |
| 8.2.171121 | sitecore | windowsservercore | 1803 | `sitecore:8.2.171121-windowsservercore-1803` [Dockerfile](images/8.2%20rev.%20171121/windowsservercore-1803/Dockerfile) |
| 8.2.171121 | sitecore | windowsservercore | 1709 | `sitecore:8.2.171121-windowsservercore-1709` [Dockerfile](images/8.2%20rev.%20171121/windowsservercore-1709/Dockerfile) |
| 8.2.170728 | sitecore | windowsservercore | 1803 | `sitecore:8.2.170728-windowsservercore-1803` [Dockerfile](images/8.2%20rev.%20170728/windowsservercore-1803/Dockerfile) |
| 8.2.170728 | sitecore | windowsservercore | 1709 | `sitecore:8.2.170728-windowsservercore-1709` [Dockerfile](images/8.2%20rev.%20170728/windowsservercore-1709/Dockerfile) |
| 8.2.170614 | sitecore | windowsservercore | 1803 | `sitecore:8.2.170614-windowsservercore-1803` [Dockerfile](images/8.2%20rev.%20170614/windowsservercore-1803/Dockerfile) |
| 8.2.170614 | sitecore | windowsservercore | 1709 | `sitecore:8.2.170614-windowsservercore-1709` [Dockerfile](images/8.2%20rev.%20170614/windowsservercore-1709/Dockerfile) |
| 8.2.170407 | sitecore | windowsservercore | 1803 | `sitecore:8.2.170407-windowsservercore-1803` [Dockerfile](images/8.2%20rev.%20170407/windowsservercore-1803/Dockerfile) |
| 8.2.170407 | sitecore | windowsservercore | 1709 | `sitecore:8.2.170407-windowsservercore-1709` [Dockerfile](images/8.2%20rev.%20170407/windowsservercore-1709/Dockerfile) |
| 8 | sitecore-openjdk | nanoserver | 1809 | `sitecore-openjdk:8-nanoserver-1809` [Dockerfile](images/sitecore-openjdk/nanoserver-1809/Dockerfile) |
| 8 | sitecore-openjdk | nanoserver | 1803 | `sitecore-openjdk:8-nanoserver-1803` [Dockerfile](images/sitecore-openjdk/nanoserver-1803/Dockerfile) |
| 8 | sitecore-openjdk | nanoserver | 1709 | `sitecore-openjdk:8-nanoserver-1709` [Dockerfile](images/sitecore-openjdk/nanoserver-1709/Dockerfile) |

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

1. Trigger a build on changes to this git repository - to get new versions.
1. Trigger once a week - to get base images updated when Microsoft releases patched images.

./Build.ps1 should be called like this:

```PowerShell
# Login
"YOUR DOCKER REPOSITORY PASSWORD" | docker login --username "YOUR DOCKER REPOSITORY USERNAME" --password-stdin

# Load module
Import-Module ".\modules\SitecoreImageBuilder" -Force

# Build and push
SitecoreImageBuilder\Invoke-Build `
    -Path ".\images" `
    -InstallSourcePath "PATH TO WHERE YOU KEEP ALL SITECORE ZIP FILES AND LICENSE.XML" `
    -Registry "YOUR REGISTRY NAME" ` # On Docker Hub it's your username or organization, else it's the DNS to your private registry.
    -Tags "*" ` # optional (default "*"), set to for example "sitecore-openjdk:*-1803", "sitecore-*:9.0.1*1803" to only build 9.0.x images on 1803.
    -PushMode "WhenChanged" # optional (default "WhenChanged"), can also be "Never" or "Always".

```

## Improvements in 1803

Besides the ability to publish ports on localhost and better NAT throughput, startup time has improved and image sizes are also reduced quite a lot. Read more about [Network start-up and performance improvements in Windows 10 April 2018 Update and Windows Server, version 1803](https://blogs.technet.microsoft.com/networking/2018/04/27/network-start-up-and-performance-improvements-in-windows-10-spring-creators-update-and-windows-server-version-1803/).

### Startup

Measurements of starting up a minimal compose file with sql, solr and a cm service with `docker-compose up` and warmup is time the first request to `/sitecore/login` takes:

| OS            | Up (sec) | Warmup (sec) |
| ------------- | --------:| ------------:|
| 1709          | 38       | 45           |
| 1803          | **26**   | **42**       |

> Tested on Windows 10 1803 with a gen. 4 i7-4790 CPU @ 3.60 GHz and a Samsung 850 EVO SSD disk.

### Image sizes

| Image    | 1709     | 1803        |
| ---------| --------:| -----------:|
| sql      | 14.00 GB | **6.95 GB** |
| solr     | 1.50 GB  | **672 MB**  |
| sitecore | 9.69 GB  | **6.13 GB** |