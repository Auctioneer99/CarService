using System;
using System.Collections.Generic;

namespace CarServiceBackend.Database.Models
{
    public partial class ResourceAttribute
    {
        public string Id { get; set; } = null!;
        public string Name { get; set; } = null!;
        public string? Value { get; set; }
        public string ResourceId { get; set; } = null!;

        public virtual ResourceServerResource Resource { get; set; } = null!;
    }
}
