# Tests

## Running XM or XP

To start XM or XP topology based Sitecore instance with a desired set of Sitecore Modules installed (PSE, SXA, JSS or Publishing Service) please use the corresponding docker-compose yml file. For example, to start Sitecore XP with SXA and Publishing Service run the following command in PowerShell:

```{.ps1}
PS> docker-compose -f docker-compose.xp.sxa.ps.yml up
```

# Running XC

**Important Note:** Sitecore Commerce is not available for the 9.1.1 version.