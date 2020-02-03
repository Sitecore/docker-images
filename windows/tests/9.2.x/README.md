# Tests

# Running XC
There are a series of different XC images, to get started you can use the following commands:

> XC requires DNS names to be configured on your host. To automatically do this use [whales-names](https://github.com/gregolsky/whales-names)). You need to add the `identity` and `bizfx` DNS names your `hosts` file - note it needs to reference the internal Container IP, not localhost.

### XC

```
PS> docker-compose -f docker-compose.xc.yml up
```

### XC with SPE
```
PS> docker-compose -f docker-compose.xc.spe.yml up
```

### XC with SPE & SXA
```
PS> docker-compose -f docker-compose.xc.sxa.yml up
```

### XC with SPE & SXA & SXA Storefront
```
PS> docker-compose -f docker-compose.xc.sxa.storefront.yml up
```

# Initializing Data
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

# Storefront Configuration
To setup a storefront, after initializing the engine you need to create a new Tenant & Site, then perform a full publish and index rebuild.

You can follow the standard setup instructions for how to do this:

    https://doc.sitecore.com/users/91/sitecore-experience-commerce/en/set-up-a-storefront-site.html

After this you can access the storefront at:

    https://cd/
