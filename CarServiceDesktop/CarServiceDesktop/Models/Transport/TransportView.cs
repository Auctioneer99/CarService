using Newtonsoft.Json;

namespace CarServiceDesktop.Models.Transport
{
    public class TransportView
    {
        [JsonProperty(PropertyName = "id")]
        public long Id { get; set; }

        [JsonProperty(PropertyName = "number")]
        public string Number { get; set; }
    }
}
