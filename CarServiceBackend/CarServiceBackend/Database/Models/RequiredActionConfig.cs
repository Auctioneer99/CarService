using System;
using System.Collections.Generic;

namespace CarServiceBackend.Database.Models
{
    public partial class RequiredActionConfig
    {
        public string RequiredActionId { get; set; } = null!;
        public string? Value { get; set; }
        public string Name { get; set; } = null!;
    }
}
