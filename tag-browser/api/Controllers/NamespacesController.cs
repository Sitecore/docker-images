using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Caching.Memory;
using Newtonsoft.Json;
using Sitecore.Tag.Browser.Common;
using Sitecore.Tag.Browser.Models;
using Sitecore.Tag.Browser.Services;

namespace Sitecore.Tag.Browser.Controllers;

[ApiController]
[Route("[controller]")]
[Produces("application/json")]
public class NamespacesController : ControllerBase
{
    private readonly ILogger<RepositoryController> _logger;
    private readonly IMemoryCache _memoryCache;


    public NamespacesController(ILogger<RepositoryController> logger, IMemoryCache memoryCache)
    {
        _logger = logger;
        _memoryCache = memoryCache;
    }

    [HttpGet(Name = "GetNamespaces")]
    public string Get()
    {
        if (_memoryCache.TryGetValue(CacheKeys.AllNamespaces, out List<string> namespaces))
        {
            if (namespaces != null)
            {
                return JsonConvert.SerializeObject(namespaces);
            }
            else
            {
                throw new NullReferenceException("This shouldn't happen!");

            }
        }
        else
        {
            // Cache didn't get hit, if we've loaded the cache on startup, this shouldn't happen.
            throw new NullReferenceException("This shouldn't happen");
        }
    }
}
