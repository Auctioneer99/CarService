using CarServiceBackend.Auth;
using HotChocolate.AspNetCore.Authorization;
using System;
using System.Collections.Generic;

namespace CarServiceBackend.Database.Models
{
    [Authorize]
    public partial class Transport
    {
        public Transport()
        {
            Works = new HashSet<Work>();
        }

        public long Id { get; set; }
        public string Number { get; set; } = null!;
        public string Model { get; set; } = null!;
        public string OwnerId { get; set; } = null!;

        [Authorize(Roles = new[] { RoleStrings.CUSTOMER, RoleStrings.ADMIN })]
        public virtual ICollection<Work> Works { get; set; }
    }
}
