﻿using System;
using System.Collections.Generic;

namespace CarServiceBackend.Database.Models
{
    public partial class IdentityProviderConfig
    {
        public string IdentityProviderId { get; set; } = null!;
        public string? Value { get; set; }
        public string Name { get; set; } = null!;

        public virtual IdentityProvider IdentityProvider { get; set; } = null!;
    }
}
