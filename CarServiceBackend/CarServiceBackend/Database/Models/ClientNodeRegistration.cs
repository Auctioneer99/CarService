using System;
using System.Collections.Generic;

namespace CarServiceBackend.Database.Models
{
    public partial class ClientNodeRegistration
    {
        public string ClientId { get; set; } = null!;
        public int? Value { get; set; }
        public string Name { get; set; } = null!;

        public virtual Client Client { get; set; } = null!;
    }
}
