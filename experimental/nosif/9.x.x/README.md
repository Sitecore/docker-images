# No SIF

## Design decisions

1. Flat image structure: final image runtime stage is directly done aspnet/runtime, it's clear what is install and configured by looking at only 1 dockerfile.
1. Assets images: Downloads, helper scripts, tools etc. are isolated in 1 image per version. Saves build time and disk space.

## Todo's

1. ...
