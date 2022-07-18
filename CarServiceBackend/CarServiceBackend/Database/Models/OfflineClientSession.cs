using System;
using System.Collections.Generic;

namespace CarServiceBackend.Database.Models
{
    public partial class OfflineClientSession
    {
        public string UserSessionId { get; set; } = null!;
        public string ClientId { get; set; } = null!;
        public string OfflineFlag { get; set; } = null!;
        public int? Timestamp { get; set; }
        public string? Data { get; set; }
        public string ClientStorageProvider { get; set; } = null!;
        public string ExternalClientId { get; set; } = null!;
    }
}
