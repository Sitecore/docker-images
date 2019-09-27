# NO SIF

## Design decisions

1. Flat image structure: Final image stage is *directly* running on official aspnet images so it's clear what is install and configured by looking at only 1 dockerfile instead of a hierarchy of base images.
1. Assets images: dev.sitecore.net downloads, helper scripts, tools etc. are isolated in 1 image per version. Saves build time and disk space on the host.
1. Windows versions supported is now global configured so build.json files can reference `${windows_version}` and each tag is expanded for each supported version. Default supported Windows versions is as of today: 1903, 1809 (ltsc2019). We support all current releases since (including) latest LTSC release. Reduces maintenance.
1. Multi-stage builds: The build stage does as much as possible (unzip, moves files around, run transforms etc.) and the final stage consumes the output from the build stage. This minimizes the number of layers and the size, in the final image.
1. Sitecore version/role independent Docker files: Potentially only 1 dockerfile per topology+version that can build multiple roles within that topology. Reduces maintenance and duplicate Docker files.
1. Sitecore license is removed from images and must be mounted in at runtime.

## Todo's

1. ...

## Other ideas

1. Switch solr images to **official openjdk images** even when they are **only** on windowsservercore, to ensure we always have latest JAVA patches?
1. Run Sql scripts in WDP packages (create user, set admin password)?
1. Invoke-Build parameter with tags to *never* publish by default: `sitecore-assets:*`, `sitecore-certificates:*`.
1. ...

## Image comparisons, SIF vs. NO-SIF

| Tag                                 | Size Before | Size After | Layers Before | Layers After |
| ----------------------------------- | ----------: | ---------: | ------------: | -----------: |
| `sitecore-xm-cm:9.2.0*1903`         | 7.50GB | **7.26GB** | 17 | **16**
| `sitecore-xm-cd:9.2.0*1903`         | 7.48GB | **7.26GB** | 17 | **16**
| `sitecore-xm-solr:9.2.0*1903`       |  663MB |  **658MB** | 12 | 12
| `sitecore-xm-sqldev:9.2.0*1903`     | 10.5GB | **6.75GB** | 16 | **14**
| `sitecore-xm-sxa-solr:9.2.0*1903`   |  663MB |  **658MB** | 13 | **12**
| `sitecore-xp-solr:9.2.0*1903`       |  663MB |  **660MB** | 13 | **12**
| `sitecore-xp-sqldev:9.2.0*1903`     | 10.8GB | **7.20GB** | 16 | 16
| `sitecore-xp-standalone:9.2.0*1903` | 6.35GB | 7.33GB(WHY?) | 20 | **15**
