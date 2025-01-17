﻿using System;
using System.Collections.Generic;

namespace CarServiceBackend.Database.Models
{
    public partial class DefaultClientScope
    {
        public string RealmId { get; set; } = null!;
        public string ScopeId { get; set; } = null!;
        public bool DefaultScope { get; set; }

        public virtual Realm Realm { get; set; } = null!;
    }
}
