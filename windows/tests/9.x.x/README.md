# Tests

# XC
Start XC using:
```
PS> docker-compose -f docker-compose.xc.yml up
```

> The Identity Server requires to have its service name (`identity`) added as DNS name in your `hosts` file
(automatically add service names to your `hosts` file using [whales-names](https://github.com/gregolsky/whales-names)).

Once all containers are running, perform the following Sitecore Commerce post-install steps using Postman:

    1. Configure your Postman environment to use:
        - `SitecoreIdServerHost` at https://identity
        - `OpsApiHost` at http://http://localhost:44005
    2. Obtain Identity token
    3. Perform bootstrap
    4. Initialize environment

> Obtain the Postman collections and environment from the Sitecore Commerce SDK.

To verify that everything is working okay browse to:

    1. [BizFx](http://localhost:44007) and verify that Habitat catalog is present
    2. [CM](http://localhost:44001/sitecore) and verify that Habitat catalog is present under `/sitecore/Commerce/Catalog Management/Catalogs`