using System;
using System.Collections.Generic;

namespace CarServiceBackend.Database.Models
{
    public partial class ScopeMapping
    {
        public string ClientId { get; set; } = null!;
        public string RoleId { get; set; } = null!;

        public virtual Client Client { get; set; } = null!;
    }
}
