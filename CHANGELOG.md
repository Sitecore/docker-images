# Changelog

## July 2019

- [Added] New Sitecore 9.2.0 XM/XP SQL Server on Linux.
- [Added] New Sitecore 9.2.0 XM/XP/SXA Solr 7.5.0 on Linux.
- [Added] Sitecore 9.2.0 XM/XP variants with Sitecore Experience Accelerator (SXA) on ltsc2019 and 1903.
- [Added] Sitecore 9.2.0 XM/XP variants with Sitecore PowerShell Extensions (SPE) on ltsc2019 and 1903.
- [Added] Sitecore 9.2.0 XM/XP base images on ltsc2019 and 1903.

## June 2019

- [Added] Added 9.0.2 PSE,SXA 1.8.1 on variants.
- [Fixed] SXA 1.8.1 on Sitecore 9.1.1 XM and XP is now correctly configured with all Web.config transforms, specificity the `sxaxm:define` appSetting and the SXA MediaRequestHandler.
- [**Breaking**] Consolidated [sitecoreops/sitecore-images](https://github.com/sitecoreops/sitecore-images) and this repository. All future work will happen right here from now on. If you need the old `master` branch you can use the `legacy` branch that is a copy from just before the consolidation.
- [Changed] Added multiple release channels (ie ltsc2019, 1903) on variants.

## May 2019 (and before)

- [Changed] All SQL images are now based on the `mssql-developer:2017` image.
- [**Breaking**] To build deprecated image tags, you now need set the `DeprecatedTagsBehavior` parameter to `Include`.
- [Deprecated] All 1709 images is now deprecated as the [.NET framework is no longer supported on this build](https://github.com/Microsoft/dotnet-framework-docker/issues/259). You can still build them using `-DeprecatedTagsBehavior "Include"`.
- [Removed] ltsc2016 images is now deleted completely as ltsc2019 is now the current ltsc version.
- [Fixed] Using `ARG` variables in Docker files can now be with and without `{}`. 
- [Changed] The `build.json` format has changed to support the use of `build-arg` during `docker image build`. In this new format we can support multiple release channels (ie 1803, ltsc2019, 1903) within a single build folder using `ARG` while reducing maintenance time and disk space needed.
- [Deprecated] Sitecore 8.2 rev. 161221 is now marked as deprecated. You can still build them using `-DeprecatedTagsBehavior "Include"`.
- [Deprecated] Sitecore 7.5 is now marked as deprecated. You can still build them using `-DeprecatedTagsBehavior "Include"`.
- [**Breaking**] Added build / restore support for deprecated images. Images that are deprecated is not build by default anymore, only when setting parameter `-DeprecatedTagsBehavior "Include"`.
- [Added] Ability to download required packages from dev.sitecore.net, see [How to use](#how-to-use) section for more details. Thanks [@Brad-Christie](https://github.com/Brad-Christie) :+1:
- [Changed] Implicit tags are now automatically included by default when using the `-Tags` parameter so you don't have to explicit define all dependent tags. Thanks [@Brad-Christie](https://github.com/Brad-Christie) :+1:
- [Added] Added Sitecore 9.1.1 XM and XP on 1903. Thanks [@jballe](https://github.com/jballe) :+1:
- [Added] Node support for JSS CM images, the integrated Mode require node on the instance for Server-Side Rendering (SSR). [@bplasmeijer](https://github.com/bplasmeijer)
- [Changed] Fixed tags for JSS images, was tagged with 10.0.1 instead of 11.0.1 which is the version installed, see [#35](https://github.com/sitecoreops/sitecore-images/issues/35). Thanks [@mikkelvalentinsorensen](https://github.com/mikkelvalentinsorensen) :+1:
- [Changed] Sitecore 9.1.1 XM and XP SQL images are now based on the new `mssql-developer:2017-windowsservercore-ltsc2019` image.
- [Added] Microsoft SQL Server 2017 base image on ltsc2019 added.
- [Added] New variant: Sitecore 9.1.1 with Sitecore Experience Accelerator (SXA). Thanks [@bplasmeijer](https://github.com/bplasmeijer) :+1:
- [Added] New variant: Sitecore 9.1.1 with Sitecore JavaScript Services (JSS). Thanks [@bplasmeijer](https://github.com/bplasmeijer) :+1:
- [Added] New variant: Sitecore 9.1.1 with PowerShell Extensions (PSE). Thanks [@bplasmeijer](https://github.com/bplasmeijer) :+1:
- [Added] New variants build support. See [How to use](#how-to-use) and [Current variants](#current-variants).
- [Changed] Sitecore 9.1.1 IIS app pools now runs as `LocalSystem` so they are allowed to write to volume mounts on Windows Server 2016/2019 hosts.
- [Fixed] Sitecore Solr images on 1809 now runs as `ContainerAdministrator` again to fix access denied errors, see [#27](https://github.com/sitecoreops/sitecore-images/issues/27). Thanks [@joostmeijles](https://github.com/joostmeijles) :+1:
- [**Breaking**] Sitecore 9.1.1 XM images renamed **back** to `xm1`, see [#28](https://github.com/sitecoreops/sitecore-images/issues/28). Thanks [@sergeyshushlyapin](https://github.com/sergeyshushlyapin) :+1:
- [Changed] Sitecore 9.1.1 images now overrides default `ENTRYPOINT` to get `ServiceMonitor` to monitor and inject Docker defined environment variables into the Application Pool that runs Sitecore. Thanks [@jballe](https://github.com/jballe) :+1:
- [Changed] Sitecore 9.1.1 XP Solr image now runs the additional xConnect Solr core configuration from `App_Data`. Thanks [@joostmeijles](https://github.com/joostmeijles) :+1:
- [Added] Sitecore 9.1.1 XM and XP on ltsc2019/1809, ~~please notice that the `xm1` tags is now just `xm`~~.
- [**Breaking**] Sitecore 9.1.0 images tagged with `9.1.001564` is renamed to `9.1.0` to align with the [new Sitecore NuGet versioning](https://sitecore.myget.org/feed/sc-packages/package/nuget/Sitecore.Kernel/9.1.0).
- [Added] Sitecore 7.5.150212 CM/CD and SQL on 1803.
- [Added] Sitecore 8.2.161221 CM/CD and SQL on 1709/1803.
- [Fixed] Removed VOLUME instructions from 9.1.0/9.0.2 Solr and SQL on 1809/ltsc2019/1803, see [#22](https://github.com/sitecoreops/sitecore-images/issues/22).
- [Fixed] Build process now takes tag filters into account when pulling external base images.
- [Added] Sitecore 9.1.0 XP CM/CD/xConnect on ltsc2019, SQL Developer and Solr (7.2.1) on 1809.
- [Added] Sitecore 9.1.0 XP CM/CD/xConnect on 1803, SQL Developer and Solr (7.2.1) on 1803.
- [Added] Sitecore 8.2.180406 Solr on nanoserver-1809.
- [Added] Sitecore 8.2.180406 CD/CM/Processing and Reporting on windowsservercore-ltsc2019.
- [Fixed] Solr `write.lock` files are now deleted before Solr start, see [#15](https://github.com/sitecoreops/sitecore-images/issues/15).
- [Added] Sitecore 9.0.2 XP CM/CD/xConnect, SQL Developer and Solr on 1803.
- [Added] Sitecore 9.0.2 XM1 CM/CD, SQL Developer and Solr on 1709.
- [Added] Sitecore 9.1.0 XM1 CM/CD, SQL Developer and Solr (7.2.1) on 1803. Please note the new XM1 specific tags for SQL and Solr.
- [Changed] Restructured Sitecore 9.1.0 XM1 CM/CD/base docker files to use multi-stage builds, number of layers reduced from 25 to 13 and the size is also reduced to 5.06 GB on ltsc2019.
- [Added] Sitecore 9.1.0 XM1 CM/CD, SQL Developer on ltsc2019 and Solr (7.2.1) on 1809. Please note the new XM1 specific tags for SQL and Solr.
- [Changed] Updated Sitecore 9.0.1, 9.0.2 Solr images to latest patch release: 6.6.3.
- [Changed] Updated openjdk base images used for Solr to latest version: java-1.8.0-openjdk-1.8.0.191-1.b12.
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
- [**Breaking**] Restructured versions and tags to support multiple Windows channels (ltsc2016, 1709, 1803 etc), there are now more repositories per version, one for each topology/role. See [Tags and Windows versions](#tags-and-windows-versions).
- [**Breaking**] Decoupled image tags from structure by specifying full tag in "build.json".
- [Added] Sitecore 8.2 Update 7.
- [Fixed] Added UrlRewrite outbound rule to handle Sitecore redirect after login when container is running on another port than 80 (possible in Windows 10 1803).
- [Fixed] Solr build errors regarding downloads from github (TLS 1.2 now used).
- [Added] Specialized Solr image with all Sitecore cores embedded **and** volume support, for Sitecore 9.0.1 (which defaults to use Solr).
- [Added] Specialized SQL Server images with all Sitecore databases embedded **and** volume support, for Sitecore 9.
- [Changed] all Sitecore 9 images now default has connection strings matching the new specialized SQL Server images.
- [Added] XM1 CM and CD role images for Sitecore 9.

## August 2018

- [Changed] *Breaking Change* Replaced Build.ps1 by new module "Sitecore.DockerImages.Management"
- [New] *Breaking Change* Dependency on external module "Bendev.Assets.Management"
- [Changed] *Breaking Change* New folder naming
- [New] XP Single base image
- [New] XP Single image
- [Changed] Containers' layers optimization
- [Changed] Performance optimizations
