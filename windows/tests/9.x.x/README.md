# Tests

# XC
Start XC using:
```
PS> docker-compose -f docker-compose.xc.yml up
```

> You need to add the `identity` and `bizfx` DNS names your `hosts` file. To automatically do this use [whales-names](https://github.com/gregolsky/whales-names)).

Once all containers are running, perform the following Sitecore Commerce post-install steps using Postman:

    1. Configure your Postman environment to use:
        - `SitecoreIdServerHost` at https://identity
        - `OpsApiHost` at http://localhost:44005
    2. Obtain Identity token
    3. Perform bootstrap ([docs](https://doc.sitecore.com/developers/92/sitecore-experience-commerce/en/bootstrap-the-commerce-engine.html))
    4. Initialize environment ([docs](https://doc.sitecore.com/developers/92/sitecore-experience-commerce/en/clean-and-initialize-the-environment.html))

> Obtain the Postman collections and environment from the Sitecore Commerce SDK.

To verify that everything is working okay browse to:

    1. [BizFx](http://localhost:4200) and verify that Habitat catalog is present
    2. [CM](http://localhost:44001/sitecore) and verify that Habitat catalog is present under `/sitecore/Commerce/Catalog Management/Catalogs`

> The Business Tools run at HTTP and *not* HTTPS. When browsing to the Business Tools from the Control Panel remove the *S* from the address.
