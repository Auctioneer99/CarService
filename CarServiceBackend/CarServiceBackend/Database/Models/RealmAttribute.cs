using System;
using System.Collections.Generic;

namespace CarServiceBackend.Database.Models
{
    public partial class RealmAttribute
    {
        public string Name { get; set; } = null!;
        public string RealmId { get; set; } = null!;
        public string? Value { get; set; }

        public virtual Realm Realm { get; set; } = null!;
    }
}
