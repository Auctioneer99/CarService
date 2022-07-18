using System;
using System.Collections.Generic;

namespace CarServiceBackend.Database.Models
{
    public partial class GroupRoleMapping
    {
        public string RoleId { get; set; } = null!;
        public string GroupId { get; set; } = null!;

        public virtual KeycloakGroup Group { get; set; } = null!;
    }
}
