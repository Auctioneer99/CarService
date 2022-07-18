using System;
using System.Collections.Generic;

namespace CarServiceBackend.Database.Models
{
    public partial class ClientScopeClient
    {
        public string ClientId { get; set; } = null!;
        public string ScopeId { get; set; } = null!;
        public bool DefaultScope { get; set; }
    }
}
