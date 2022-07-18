using System;
using System.Collections.Generic;

namespace CarServiceBackend.Database.Models
{
    public partial class ClientAttribute
    {
        public string ClientId { get; set; } = null!;
        public string? Value { get; set; }
        public string Name { get; set; } = null!;

        public virtual Client Client { get; set; } = null!;
    }
}
