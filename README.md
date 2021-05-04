# Repository of Sitecore Docker images

[//]: # "start: stats"

[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg?style=flat-square)](https://opensource.org/licenses/MIT) ![Repositories](https://img.shields.io/badge/Repositories-316-blue.svg?style=flat-square) ![Tags](https://img.shields.io/badge/Tags-2697-blue.svg?style=flat-square) ![Deprecated](https://img.shields.io/badge/Deprecated-0-lightgrey.svg?style=flat-square) ![Dockerfiles](https://img.shields.io/badge/Dockerfiles-139-blue.svg?style=flat-square) ![Default version](https://img.shields.io/badge/Default%20version-10.0.0%20on%20ltsc2019/1809-blue?style=flat-square)

[//]: # "end: stats"

In this repository you will find the official Sitecore container support files. The `/tags/` folder contains the official tags list of all published images (see [SITECORE-TAGS.md](tags/sitecore-tags.md)).

Using this repository you can also build custom Docker images for the most recent versions of Sitecore. You can use this repository (preferably from a fork) from your build server and have it build and push images to your private Docker registry. See [INSTRUCTIONS.md](build/INSTRUCTIONS.md) for how to setup and build, and [IMAGES.md](build/IMAGES.md) for a list of all custom images currently available to be built.

## Information about this repository

- Official statement on running Sitecore in containers, see [https://kb.sitecore.net/articles/161310](https://kb.sitecore.net/articles/161310).
- **The images built from the build folder in this repo are not supported by Sitecore.**
- The build scripts and examples in this repository are provided and maintained by the community, with contributions and code reviews by Sitecore.
- This repository was initially created to help consolidate efforts around Sitecore and Docker.
- In scenarios where you or your organization require domains to be whitelisted, please see the following domains associated with the Sitecore Container Registry:
  - scr.sitecore.com
  - scr-data-westeurope.sitecore.com
  - scr-data-eastus.sitecore.com
  - scr-data-eastasia.sitecore.com

### Official Sitecore image tags

Please see [SITECORE-TAGS.md](tags/sitecore-tags.md).

### How to setup and build custom images

Please see [INSTRUCTIONS.md](build/INSTRUCTIONS.md).

### List of custom images available to build

Please see [IMAGES.md](build/IMAGES.md).

### How to contribute

Please see [CONTRIBUTING.md](CONTRIBUTING.md).

### Repository changelog

Please see [CHANGELOG.md](build/CHANGELOG.md).
