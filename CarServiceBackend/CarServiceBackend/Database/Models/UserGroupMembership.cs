using System;
using System.Collections.Generic;

namespace CarServiceBackend.Database.Models
{
    public partial class UserGroupMembership
    {
        public string GroupId { get; set; } = null!;
        public string UserId { get; set; } = null!;

        public virtual UserEntity User { get; set; } = null!;
    }
}
