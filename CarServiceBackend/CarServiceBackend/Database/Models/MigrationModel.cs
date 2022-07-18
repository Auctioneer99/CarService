using System;
using System.Collections.Generic;

namespace CarServiceBackend.Database.Models
{
    public partial class MigrationModel
    {
        public string Id { get; set; } = null!;
        public string? Version { get; set; }
        public long UpdateTime { get; set; }
    }
}
