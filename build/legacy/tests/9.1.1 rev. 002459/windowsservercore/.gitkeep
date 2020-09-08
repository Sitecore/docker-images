# docker-compose test variants

The currently available variants are built with the parent image pattern. We start with the clean Vanilla Sitecore image. The docker images are built from the WDP packages provided by Sitecore. The WDP is prebuilt web deployment packages for CM and CD configuration. If you want to deploy Sitecore on Azure by using the Azure resource manager (ARM) deployment, the same WDP packages are used. 

We created the following structure

----------------------------
- Vanilla Sitecore         -
-------------^^-------------
- PSE                      -
-------------^^-------------
- JSS                      -
-------------^^-------------
- SXA                      -
-------------^^-------------
- XC (not yet available)   -
-------------^^-------------

Example; XC uses PSE/JSS/SXA

# Supported docker compose environment variables

The Sitecore docker compose variants will now start using the docker environment variables, see https://docs.docker.com/compose/environment-variables/

# windows server core version;  ('1903','ltsc2019')
windows_version=
