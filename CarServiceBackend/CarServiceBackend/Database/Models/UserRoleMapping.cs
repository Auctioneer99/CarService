using System;
using System.Collections.Generic;

namespace CarServiceBackend.Database.Models
{
    public partial class UserRoleMapping
    {
        public string RoleId { get; set; } = null!;
        public string UserId { get; set; } = null!;

        public virtual UserEntity User { get; set; } = null!;
    }
}
