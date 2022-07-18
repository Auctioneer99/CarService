using System;
using System.Collections.Generic;

namespace CarServiceBackend.Database.Models
{
    public partial class IdpMapperConfig
    {
        public string IdpMapperId { get; set; } = null!;
        public string? Value { get; set; }
        public string Name { get; set; } = null!;

        public virtual IdentityProviderMapper IdpMapper { get; set; } = null!;
    }
}
