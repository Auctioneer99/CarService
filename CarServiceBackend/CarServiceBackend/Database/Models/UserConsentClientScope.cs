using System;
using System.Collections.Generic;

namespace CarServiceBackend.Database.Models
{
    public partial class UserConsentClientScope
    {
        public string UserConsentId { get; set; } = null!;
        public string ScopeId { get; set; } = null!;

        public virtual UserConsent UserConsent { get; set; } = null!;
    }
}
