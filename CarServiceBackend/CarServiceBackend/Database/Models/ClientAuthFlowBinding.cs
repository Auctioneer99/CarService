using System;
using System.Collections.Generic;

namespace CarServiceBackend.Database.Models
{
    public partial class ClientAuthFlowBinding
    {
        public string ClientId { get; set; } = null!;
        public string? FlowId { get; set; }
        public string BindingName { get; set; } = null!;
    }
}
