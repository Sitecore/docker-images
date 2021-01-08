
# How to use

These instructions will help you understand how to **build custom images** derived from the official Sitecore v10 images as well as how to build full Sitecore images using legacy (pre v10) assets.

> **For detailed documentation on how to get started running Sitecore version 10 or above in a containerized environment, please see the [official documentation](https://containers.doc.sitecore.com/docs/intro)**

## Tagging and Windows versions

This repository can build multiple Windows versions. Read more about [Windows Container Version Compatibility](https://docs.microsoft.com/en-us/virtualization/windowscontainers/deploy-containers/version-compatibility).

Here is the convention used for Sitecore image tags before Sitecore 10.x:

```text
 [REGISTRY/]sitecore-<TOPOLOGY>[-VARIANT]-<ROLE>:<SITECORE_VERSION>-<OS_VERSION>
```

Example:

```text
 registry.example.com/sitecore-xm-sxa-jss-cm:9.2.0-windowsservercore-1903
 \__________________/ \____________________/ \___/ \____________________/
           |                    |              |             |
   registry/org/user       repository       sc version   os version
```

**Starting with Sitecore 10.x:**

```text
 [REGISTRY/]community/sitecore-<TOPOLOGY>-custom[-VARIANT]-<ROLE>:<SITECORE_VERSION>-<OS_VERSION>
```

Example:

```text
 registry.example.com/community/sitecore-xm-custom-sxa-jss-cm:10.0.0-windowsservercore-1903
 \__________________/ \_____________________________________/ \____/ \____________________/
           |                             |                      |             |
  registry/org/user                 repository               sc version   os version
```

## Quick start

```PowerShell
.\Build.ps1 -SitecoreVersion "three digit Sitecore version number"
```

This will:

1. Download any missing packages into `.\packages`, if you have another location with files already present you can call `Build.ps1` with the parameter `-InstallSourcePath`.
1. Build all images of latest Sitecore version on latest LTSC (Long Term Support Channel) Windows version.

> Images will always be saved locally but not pushed to any remote registries by default. See [Setting up automated builds](#setting-up-automated-builds) for details on how to do this.

When completed then...

**For Sitecore 9.3.x:**

1. Run `Set-LicenseEnvironmentVariable.ps1 -Path C:\license\license.xml` (use the `PersistForCurrentUser` switch to persist the license for future sessions). This will gzip and base64 encode the license file content and save it in `$env:SITECORE_LICENSE`.
1. Switch directory to `.\windows\tests\9.3.x\` and then run any of the docker-compose files, for example an XM with: `docker-compose --file .\docker-compose.xm.yml up`

9.3 docker images still supports mounting the license file inside the container, if for some reason you need to use this method please see [License file volume mount configuration for 9.3 docker images](#license-file-volume-mount-configuration-for-9.3-docker-images)

**For Sitecore 9.2.x:**

1. Place your Sitecore license file at `C:\license\license.xml`, or override location using the environment variable `LICENSE_PATH` like so: `$env:LICENSE_PATH="D:\my\sitecore\licenses"`
1. Switch directory to `.\windows\tests\9.2.x\` and then run any of the docker-compose files, for example an XM with: `docker-compose --file .\docker-compose.xm.yml up`

**For all Sitecore versions:**

> IMPORTANT: When switching between versions, variants or topologies you need to clear the data folders, you can use the `.\windows\tests\*.*.*\Clean-Data.ps1` script to do so.

## Setting up automated builds

### Prerequisites

- A **private** Docker repository. Any will do, but the easiest is to use a [Azure Container Registry](https://azure.microsoft.com/en-us/services/container-registry/).
- A file location that your build agents can reach to store downloads from [https://dev.sitecore.net/](https://dev.sitecore.net/).

#### Windows

1. Latest Windows 10 or Windows Server 2019 with Hyper-V and Containers features installed.
1. Latest stable Docker engine and cli.

#### Linux (optional)

1. [PowerShell Core](https://github.com/powershell/powershell) so you can use the PowerShell module.
1. Latest stable Docker engine and cli.

### Configure your build server

1. Trigger a build on changes to `master` - to get new versions.
1. Trigger once a week - to get base images updated when Microsoft releases patched images.

Example:

```PowerShell
# required, change if you need to build images in other folders such as ".\linux" or ".\legacy"
$imagesPath = (Join-Path $PSScriptRoot "\windows")

# optional, default value is ".\packages". Can be on local machine or a file share.
$installSourcePath = (Join-Path $PSScriptRoot "\packages")

# optional, on Docker Hub it's your username or organization, else it's the hostname of your
# own registry. This parameter is optional but you will not be able to push images to a
# remote registry without.
#
# PLEASE NOTE: DO NOT SPECIFY A PUBLIC REGISTRY!
#
$registry = "YOUR REGISTRY NAME" `

# Ensure that the private registry connection is authenticated. eg. Azure Container Registry
# az acr login --name $registry
# or
# docker login

# optional, default value is the latest Sitecore version on latest LTSC version
# of Windows. Set to for example "*" for build everything or "*:9.1.1*1903", "*:9.2.0*1903" to
# only build 9.1.1 and 9.2.0 on Windows 1903.
$tags = "*"

# import builder module
Import-Module (Join-Path $PSScriptRoot "\modules\SitecoreImageBuilder") -Force

# restore packages needed for the build, only files missing in $installSourcePath will be downloaded
SitecoreImageBuilder\Invoke-PackageRestore `
    -Path $imagesPath `
    -Destination $installSourcePath `
    -Tags $tags

# build and push images
SitecoreImageBuilder\Invoke-Build `
    -Path $imagesPath `
    -InstallSourcePath $installSourcePath `
    -Registry $registry `
    -Tags $tags
```

## Optional ENTRYPOINT scripts

We now have a few scripts that can be used as `ENTRYPOINT` for development and production use. Using the `ENTRYPOINT` scripts that supports log steaming enables you to observe Sitecore log entries in the `STDOUT` of containers in the foreground or by using commands such as `docker container logs` or `docker container attach`.

### For CM/CD

`C:\tools\entrypoints\iis\Production.ps1` features:

- Adds an UDP appender to all default log4net loggers.
- Starts `ServiceMonitor.exe` in the background.
- Starts `filebeat.exe` in the foreground and outputting to `STDOUT`.
- FileBeat inputs configured:
  - IIS access logs, **disabled** by default, can be switched using environment variable: `ENTRYPOINT_STDOUT_IIS_ACCESS_LOG_ENABLED=true`
  - IIS error logs, **disabled** by default, can be switched using environment variable: `ENTRYPOINT_STDOUT_IIS_ERROR_LOG_ENABLED=true`
  - Sitecore logs, **enabled** by default, can be switched using environment variable: `ENTRYPOINT_STDOUT_SITECORE_LOG_ENABLED=false`

`C:\tools\entrypoints\iis\Development.ps1` features:

- Same as `Production.ps1`.
- Starts the Visual Studio Remote Debugger `msvsmon.exe` in the background **if** the Visual Studio Remote Debugger directory is mounted into `C:\remote_debugger`.
- Starts the `Watch-Directory.ps1` script in the background **if** a directory is mounted into `C:\src`.
  - To customize parameters you can use `WatchDirectoryParameters` and give it a hashtable, example: `entrypoint: powershell.exe -Command "& C:\\tools\\entrypoints\\iis\\Development.ps1 -WatchDirectoryParameters @{ Path = 'C:\\src'; Destination = 'C:\\inetpub\\wwwroot'; ExcludeFiles = @('Web.config'); }"`

See the `cm` and `cd` service in [windows/tests/9.3.x/docker-compose.xm.yml](windows/tests/9.3.x/docker-compose.xm.yml) for configuration examples.

### For XConnect workers (automation engine, processing engine, index worker)

> Please note that this is enabled *from* Sitecore v9.3.0.

`C:\tools\entrypoints\worker\Development.ps1` features:

- Starts the `Watch-Directory.ps1` script in the background **if** a directory is mounted into `C:\src`.
  - To customize parameters you can use `WatchDirectoryParameters` and give it a hashtable, example: `entrypoint: powershell.exe -Command "& C:\\tools\\entrypoints\\worker\\Development.ps1 -WatchDirectoryParameters @{ Path = 'C:\\src'; Destination = 'C:\\worker'; }"`

### For Commerce Engine (authoring, minions, ops, shops)

`C:\tools\entrypoints\sitecore-xc-engine\Production.ps1` features:

- Adds a UDP log appender
- Starts `ServiceMonitor.exe` in the background.
- Starts `filebeat.exe` in the foreground and outputting to `STDOUT`.
- FileBeat inputs configured:
  - IIS access logs, **disabled** by default, can be switched using environment variable: `ENTRYPOINT_STDOUT_IIS_ACCESS_LOG_ENABLED=true`
  - IIS error logs, **disabled** by default, can be switched using environment variable: `ENTRYPOINT_STDOUT_IIS_ERROR_LOG_ENABLED=true`
  - Commerce Engine logs, **enabled** by default, can be switched using environment variable: `ENTRYPOINT_STDOUT_ENGINE_LOG_ENABLED=false`

`C:\tools\entrypoints\sitecore-xc-engine\Development.ps1` features:

- Same as `Production.ps1`.
- Starts the Visual Studio Remote Debugger `msvsmon.exe` in the background **if** the Visual Studio Remote Debugger directory is mounted into `C:\remote_debugger`.
- Starts the `Watch-Directory.ps1` script in the background **if** a directory is mounted into `C:\src`.
  - To customize parameters you can use `WatchDirectoryParameters` and give it a hashtable, example: `entrypoint: powershell.exe -Command "& C:\\tools\\entrypoints\\sitecore-xc-engine\\Development.ps1 -WatchDirectoryParameters @{ Path = 'C:\\src'; Destination = 'C:\\inetpub\\wwwroot'; ExcludeFiles = @('Web.config'); }"`

See the `commerce-authoring` service in [windows/tests/9.3.x/docker-compose.xc.yml](windows/tests/9.3.x/docker-compose.xc.yml) for configuration examples.

## Experimental Modules (not automatically build because of missing prerequisites from Sitecore)

The `Download-Module-Prerequisites.ps1` script will download regular Sitecore packages, and convert them into proper WDP packages by using Sitecore Sitecore Azure Toolkit.

Experimental modules include, and are not limited to:

- Sitecore Publishing Service
- Data Exchange Framework
- Sitecore Commect for Salesforce Marketing Cloud
- Sitecore Connect for Salesforce CRM
- Sitecore Connect for Microsoft Dynamics 365 for Sales
- Sitecore Connect for CMP
- Sitecore Connect for Sitecore DAM
- Coveo for Sitecore
- Coveo for Sitecore SXA

Azure Toolkit has also prerequisites, see (https://doc.sitecore.com/developers/sat/20/sitecore-azure-toolkit/en/getting-started-with-the-sitecore-azure-toolkit.html)

To enable experimental modules, add the `-IncludeExperimental` parameter when calling `Build.ps1`

```PowerShell
.\Build.ps1 -SitecoreVersion "three digit Sitecore version number" -IncludeExperimental
```

## License file volume mount configuration for 9.3 docker images

If you've been using the license file mounted approach in 9.2 docker images, you can still continue using the same approach in 9.3 docker images. Follow these steps

1. Place your Sitecore license file at `C:\license\license.xml`, or override location using the environment variable `LICENSE_PATH` like so: `$env:LICENSE_PATH="D:\my\sitecore\licenses"`
1. Switch directory to `.\windows\tests\9.3.x\`  and then run any of the docker-compose files, for example an XM with: `docker-compose --file .\docker-compose.xm.yml up` after the docker compose file has been updated following the instruction below

### For CM and CD

1. Add a new volume mount configuration using the environment variable `LICENSE_PATH` to a folder inside the container, for example `C:\license`
1. Add a new environment variable `SITECORE_LICENSE_LOCATION` that point to the license file path inside the container, for example: `C:\license\license.xml`

```yaml
cm:
  environment:
    SITECORE_LICENSE_LOCATION: C:\license\license.xml
  volumes:
    - ${LICENSE_PATH}:C:\license
```

### For xconnect, xconnect-automationengine, xconnect-indexworker, xconnect-processingengine

1. Add a new volume mount configuration using the environment variable `LICENSE_PATH` to a folder inside the container, for example `C:\license`
1. Add a new environment variable `SITECORE_LICENSE_LOCATION` that point to the license file folder path inside the container, for example: `C:\license`

```yaml
xconnect:
  environment:
    SITECORE_LICENSE_LOCATION: C:\license
  volumes:
    - ${LICENSE_PATH}:C:\license
```

## Cleanup

Its recommended to clean up you Docker engine hosts (developer workstations, build agents etc.) regularly.

To remove **unused** images (dangling images created during build):

```text
docker image prune --force
```

>TIP: If you need to clean up **everything** you can add the option `--all` to above prune command or run `docker system prune --all --force`. Beware that both will remove **all** images.
