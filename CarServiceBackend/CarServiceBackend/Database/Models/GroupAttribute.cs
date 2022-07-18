using System;
using System.Collections.Generic;

namespace CarServiceBackend.Database.Models
{
    public partial class GroupAttribute
    {
        public string Id { get; set; } = null!;
        public string Name { get; set; } = null!;
        public string? Value { get; set; }
        public string GroupId { get; set; } = null!;

        public virtual KeycloakGroup Group { get; set; } = null!;
    }
}
