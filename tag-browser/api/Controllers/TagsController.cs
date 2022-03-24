using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Caching.Memory;
using Newtonsoft.Json;
using Sitecore.Tag.Browser.Common;
using Sitecore.Tag.Browser.Models;
using Sitecore.Tag.Browser.Services;

namespace Sitecore.Tag.Browser.Controllers;

[ApiController]
[Route("api/[controller]")]
[Produces("application/json")]
public class TagsController : ControllerBase
{
    private readonly ILogger<TagsController> _logger;
    private readonly IMemoryCache _memoryCache;


    public TagsController(ILogger<TagsController> logger, IMemoryCache memoryCache)
    {
        _logger = logger;
        _memoryCache = memoryCache;
    }

    [HttpGet()]
    public string Get()
    {
        //if (_memoryCache.TryGetValue("community/modules/custom-cmp-xm-assets-10.0.1-1809", out ImageTag tag))
        //{
        //    if (tag != null)
        //    {
        //        return JsonConvert.SerializeObject(tag);
        //    }
        //}
        //return String.Empty;
        if (_memoryCache.TryGetValue(CacheKeys.AllRepositories, out List<Repository> repositories))
        {
            if (repositories != null)
            {
                return JsonConvert.SerializeObject(repositories);
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
    [HttpGet("ns/{ns}")]
    public string Get(string? ns)
    {
        //if (_memoryCache.TryGetValue("community/modules/custom-cmp-xm-assets-10.0.1-1809", out ImageTag tag))
        //{
        //    if (tag != null)
        //    {
        //        return JsonConvert.SerializeObject(tag);
        //    }
        //}
        //return String.Empty;
        if (_memoryCache.TryGetValue(ns, out List<ImageTag> tags))
        {
            if (tags != null)
            {
                return JsonConvert.SerializeObject(tags);
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
