using Newtonsoft.Json;
using Sitecore.Tag.Browser.Models;

namespace Sitecore.Tag.Browser.Services
{
    public static class SitecoreTagService
    {

        public static async Task<List<Repository>> Get()
        {
            HttpClient client = new();
            HttpResponseMessage response = client.Send(new HttpRequestMessage(HttpMethod.Get, "https://raw.githubusercontent.com/Sitecore/docker-images/master/tags/sitecore-tags.json"));
            var json = await response.Content.ReadAsStringAsync();
            var result = JsonConvert.DeserializeObject<List<Repository>>(json);
            if
                (result != null)
            {
                return result;
            }
            else
            {
                throw new NullReferenceException();
            }
        }
        public static string GetJson<T>(object obj)
        {
            var result = JsonConvert.SerializeObject(obj);
            return result;
        }
    }
}
