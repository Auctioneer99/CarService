﻿using System;
using System.Collections.Generic;

namespace CarServiceBackend.Database.Models
{
    public partial class AuthenticatorConfigEntry
    {
        public string AuthenticatorId { get; set; } = null!;
        public string? Value { get; set; }
        public string Name { get; set; } = null!;
    }
}
