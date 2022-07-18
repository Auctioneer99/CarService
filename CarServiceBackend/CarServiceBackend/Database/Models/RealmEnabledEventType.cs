using System;
using System.Collections.Generic;

namespace CarServiceBackend.Database.Models
{
    public partial class RealmEnabledEventType
    {
        public string RealmId { get; set; } = null!;
        public string Value { get; set; } = null!;

        public virtual Realm Realm { get; set; } = null!;
    }
}
