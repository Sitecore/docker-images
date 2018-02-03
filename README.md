# Repository of Sitecore Docker base images

Build your own Docker images of every released Sitecore version since 8.2 rev. 170407 (Update 3), the first version that officially supported Windows Server 2016.

## How to use

Configure your build server to trigger:

1. A build on any changes to this git repository - to get new versions.
1. Scheduled once a week - to get updated bases images when Microsoft releases patched images.

/Build.ps1 should be called like this:

````PowerShell
# Login
"YOUR DOCKER REPOSITORY PASSWORD" | docker login --username "YOUR DOCKER REPOSITORY USERNAME" --password-stdin

# Build
. (Join-Path $PSScriptRoot "Build.ps1") `
    -InstallSourcePath "PATH TO WHERE YOU KEEP ALL SITECORE ZIP FILES AND LICENSE.XML" `
    -Repository "sitecore" `
    -Organization "mycompany" # Optional
````