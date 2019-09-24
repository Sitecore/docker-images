# NO SIF

## Design decisions

1. Flat image structure: Final image stage is *directly* running on official aspnet images so it's clear what is install and configured by looking at only 1 dockerfile instead of a hierarchy of base images.
1. Assets images: dev.sitecore.net downloads, helper scripts, tools etc. are isolated in 1 image per version. Saves build time and disk space on the host.
1. Windows versions supported is now global configured so build.json files can reference `${windows_version}` and each tag is expanded for each supported version. Default supported Windows versions is as of today: 1903, 1809 (ltsc2019). We support all current releases since (including) latest LTSC release. Reduces maintenance.
1. Multi-stage builds: The build stage does as much as possible (unzip, moves files around, run transforms etc.) and the final stage consumes the output from the build stage. This minimizes the number of layers and the size, in the final image.
1. Sitecore version/role independent Docker files: Potentially only 1 dockerfile per topology+version that can build multiple roles within that topology. Reduces maintenance and duplicate Docker files.
1. Sitecore license is removed from images and must be mounted in at runtime.

## Todo's

1. Also copy+rename "sqldev" images from `xm1` to `xm` for consistency.
1. Sql database don't need a prefix, should be removed? Solr is already using default core names without prefix.
1. Solr version downloads added to "sitecore-assets" images.
1. ...

## Other ideas

1. ...
