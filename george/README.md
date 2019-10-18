# Sitecore on Docker

## Overview

This repository contains utilities and `Dockerfile`s to create images for the Sitecore platform.

## Images

The following images will be built upon execution of `Build-ScDockerImages.ps1`:

### Base Images

Base images are created to install any prerequisites needed for each platform. There is a separate base image for each platform and the base images are Windows version specific. The same base images can be used to create Sitecore images of varying versions.

#### scbase-aspnet

This is the base image for ASP.NET applications.

#### scbase-netframework

This is the base image for .NET Framework applications.

#### scbase-netcore

This is the base image for .NET Core applications.

### Application Images

Each application on the Sitecore platform has its own separate image - this includes each of the xConnect worker roles. These application images are built off of the base images.

#### sitecore

The image for the main Sitecore application based on `scbase-aspnet`.

#### xconnect

The image for the xConnect web service based on `scbase-aspnet`.

#### xconnect.indexworker

The image for the xConnect Search Indexer service based on `scbase-netframework`.

#### xconnect.maengine

The image for the xConnect Marketing Automation Engine service based on `scbase-netframework`.

#### xconnect.processingengine

The image for the xConnect Processing Engine service based on `scbase-netframework`.

#### identity

The image for the Sitecore Identity application based on `scbase-netcore`.

### Tags

The base images are tagged strictly by Windows versions, i.e. `1903`, `ltsc2019`, etc.

The application images are tagged based on a concatenation of Windows versions and Sitecore versions. For example, for a Windows 1903 image for Sitecore 9.2, the tag name would be `1903-9.2`.

## How It Works

Each base image has a PowerShell script called `Bootstrapper.ps1` that is executed as the entrypoint for each image. This script does 2 main things:

1. Updates the application with the appropriate configuration transforms and installs any configured certificates.
2. Executes the application to run in the container. For ASP.NET applications, this is the `ServiceMonitor.exe` executable that ships with the ASP.NET images.

The configuration for each application is defined in a JSON file named `configuration.json` which is included as part of the image build. The `configuration.json` file defines a series of mappings from environment variables to XPath targets so any values that are defined in a mapping are replaced with their corresponding environment variable value. This simulates a typical best practice for containers, that is, to maintain application configuration though external configuration (in this case, environment variables) to keep containers reusable.

Since this occurs when the bootstrapper is executed at a container's entrypoint, environment variables can be updated between container lifetimes and will be reflected in their corresponding `.config` files. If you want to add/modify mappings defined in the `configuration.json` file, you will need to do so locally and rebuild the application images so that the updated `configuration.json` file is part of the image and will be referenced when the container starts up.
