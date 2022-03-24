using Newtonsoft.Json;

namespace Sitecore.Tag.Browser.Models
{
    public class Repository
    {
        public string? Name { get; set; }
        public string? Namespace { get; set; }
        public IList<ImageTag> Tags { get; set; } = new List<ImageTag>();

    }
}
