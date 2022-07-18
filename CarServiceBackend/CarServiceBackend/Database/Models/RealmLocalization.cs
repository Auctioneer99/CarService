using System;
using System.Collections.Generic;

namespace CarServiceBackend.Database.Models
{
    public partial class RealmLocalization
    {
        public string RealmId { get; set; } = null!;
        public string Locale { get; set; } = null!;
        public string Texts { get; set; } = null!;
    }
}
