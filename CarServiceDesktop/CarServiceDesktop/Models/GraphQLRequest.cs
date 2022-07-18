using Newtonsoft.Json;
using System.Collections.Generic;

namespace CarServiceDesktop.Models
{
    public class GraphQLRequest
    {
        [JsonProperty(PropertyName = "operationName")]
        public string OperationName { get; set; }

        [JsonProperty(PropertyName = "variables")]
        public Dictionary<string, object> Variables { get; set; } = new Dictionary<string, object>();

        [JsonProperty(PropertyName = "query")]
        public string Query { get; set; }
    }
}
