using System;
using System.Collections.Generic;

namespace CarServiceBackend.Database.Models
{
    public partial class ResourceUri
    {
        public string ResourceId { get; set; } = null!;
        public string Value { get; set; } = null!;

        public virtual ResourceServerResource Resource { get; set; } = null!;
    }
}
