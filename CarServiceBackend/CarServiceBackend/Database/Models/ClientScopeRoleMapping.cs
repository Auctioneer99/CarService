using System;
using System.Collections.Generic;

namespace CarServiceBackend.Database.Models
{
    public partial class ClientScopeRoleMapping
    {
        public string ScopeId { get; set; } = null!;
        public string RoleId { get; set; } = null!;

        public virtual ClientScope Scope { get; set; } = null!;
    }
}
