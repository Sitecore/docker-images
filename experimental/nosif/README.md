# NO SIF

## Design decisions

1. Flat image structure: Final image stage is *directly* using aspnet/runtime so it's clear what is install and configured by looking at only 1 dockerfile instead of a hierarchy of base images.
1. Assets images: dev.sitecore.net downloads, helper scripts, tools etc. are isolated in 1 image per version. Saves build time and disk space on the host.
1. Multi-stage builds: The build stage does as much as possible (unzip, moves files around, run transforms etc.) and the final stage consumes the output from the build stage. This minimizes the number of layers and the size, in the final image.
1. Sitecore version/role independent Docker files: Potentially only 1 dockerfile per topology that can build multiple roles within that topology. Reduces maintenance and duplicate Docker files.

## Ideas

1. Windows channels could be "global" and not in each build.json to further reduce maintenance.
