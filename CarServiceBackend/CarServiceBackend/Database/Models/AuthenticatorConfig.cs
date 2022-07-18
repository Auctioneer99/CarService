using System;
using System.Collections.Generic;

namespace CarServiceBackend.Database.Models
{
    public partial class AuthenticatorConfig
    {
        public string Id { get; set; } = null!;
        public string? Alias { get; set; }
        public string? RealmId { get; set; }

        public virtual Realm? Realm { get; set; }
    }
}
