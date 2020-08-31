# Repository of Sitecore Docker images

[//]: # "start: stats"

[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg?style=flat-square)](https://opensource.org/licenses/MIT) ![Repositories](https://img.shields.io/badge/Repositories-105-blue.svg?style=flat-square) ![Tags](https://img.shields.io/badge/Tags-708-blue.svg?style=flat-square) ![Deprecated](https://img.shields.io/badge/Deprecated-0-lightgrey.svg?style=flat-square) ![Dockerfiles](https://img.shields.io/badge/Dockerfiles-93-blue.svg?style=flat-square) ![Default version](https://img.shields.io/badge/Default%20version-9.3.0%20on%20ltsc2019/1809-blue?style=flat-square)

[//]: # "end: stats"

In this repository you will find the official Sitecore container support files, all located in the `/sitecore-container-support/` folder. This folder contains primarily the official tag list (see [SITECORE-TAGS](/sitecore-container-support/sitecore-tags.md)) of all published images but will also be used to hold additional official Sitecore materials related to containers.

Using this repository you can also build custom Docker images for the most recent versions of Sitecore. You can use this repository (preferably from a fork) from your build server and have it build and push images to your private Docker registry. See [INSTRUCTIONS.md](INSTRUCTIONS.md) for how to setup and build, and [IMAGES.md](IMAGES.md) for a list of all images currently available to be built.

Note: The images built from this repo (including pre v10 images) are considered custom images and not officially provided or supported by Sitecore.

## Information about this repository

- This repository was initially created to help consolidate efforts around Sitecore and Docker.
- Official statement on running Sitecore in containers, see [https://kb.sitecore.net/articles/161310](https://kb.sitecore.net/articles/161310).
- The build scripts and examples in this repository are provided and maintained by the community, with significant contributions (and quality assurance?) by Sitecore employees.

### Official Sitecore image tags

Please see [sitecore-tags.md](/sitecore-container-support/sitecore-tags.md)

### Change Log

Please see [CHANGELOG.md](CHANGELOG.md).

### List of all images

Please see [IMAGES.md](IMAGES.md).

### Contributing

Please see [CONTRIBUTING.md](CONTRIBUTING.md).
