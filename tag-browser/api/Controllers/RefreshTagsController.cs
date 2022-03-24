using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Caching.Memory;
using Sitecore.Tag.Browser.Common;
using Sitecore.Tag.Browser.Models;
using Sitecore.Tag.Browser.Services;

namespace Sitecore.Tag.Browser.Controllers;

[ApiController]
[Route("api/[controller]")]
[Produces("application/json")]
public class RefreshTagsController : ControllerBase
{
    private readonly ILogger<RefreshTagsController> _logger;
    private readonly IMemoryCache _memoryCache;
    public RefreshTagsController(ILogger<RefreshTagsController> logger, IMemoryCache memoryCache)
    {
        _logger = logger;
        _memoryCache = memoryCache;
    }

    [HttpGet(Name = "UpdateImageTags")]
    public async Task<object> GetAsync()
    {
        //TODO: Move this code to ALSO initialize on startup.
        try
        {
            List<Repository> allData = await SitecoreTagService.Get();
            _memoryCache.Set(CacheKeys.AllRepositories, (List<Repository>)allData);
            
            var namespaces = allData.Select(u => u.Namespace).Distinct().ToList();
            _memoryCache.Set(CacheKeys.AllNamespaces, namespaces);

            // Cache repositories by Namespace (e.g. community/modules)
            var namespaceGroup = allData.GroupBy(repo => repo.Namespace);

            foreach (var ns in namespaceGroup)
            {
                _memoryCache.Set(ns.Key, ns.ToList<Repository>());
            }

            // Cache tags by repository and repositories by name
            foreach (Repository? repo in allData)
            {
                _memoryCache.Set(repo.Name, repo);
                foreach (ImageTag tag in repo.Tags)
                {
                    _memoryCache.Set($"{repo.Name}-{tag.Tag}", tag);
                }
            }
            return NoContent();
        }
        catch (Exception)
        {
            return this.Problem(null, null, 500);
        }

    }
}
