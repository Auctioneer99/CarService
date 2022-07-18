using System;
using System.Collections.Generic;

namespace CarServiceBackend.Database.Models
{
    public partial class FedUserConsentClScope
    {
        public string UserConsentId { get; set; } = null!;
        public string ScopeId { get; set; } = null!;
    }
}
