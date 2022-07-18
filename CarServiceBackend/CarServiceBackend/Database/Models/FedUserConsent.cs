using System;
using System.Collections.Generic;

namespace CarServiceBackend.Database.Models
{
    public partial class FedUserConsent
    {
        public string Id { get; set; } = null!;
        public string? ClientId { get; set; }
        public string UserId { get; set; } = null!;
        public string RealmId { get; set; } = null!;
        public string? StorageProviderId { get; set; }
        public long? CreatedDate { get; set; }
        public long? LastUpdatedDate { get; set; }
        public string? ClientStorageProvider { get; set; }
        public string? ExternalClientId { get; set; }
    }
}
