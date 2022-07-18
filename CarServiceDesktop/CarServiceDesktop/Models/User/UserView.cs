using Newtonsoft.Json;

namespace CarServiceDesktop.Models.User
{
    public class UserView
    {
        [JsonProperty(PropertyName = "id")]
        public string Id { get; set; }

        [JsonProperty(PropertyName = "name")]
        public string Name { get; set; }
    }
}
