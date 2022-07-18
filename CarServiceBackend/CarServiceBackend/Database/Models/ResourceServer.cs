using System;
using System.Collections.Generic;

namespace CarServiceBackend.Database.Models
{
    public partial class ResourceServer
    {
        public ResourceServer()
        {
            ResourceServerPermTickets = new HashSet<ResourceServerPermTicket>();
            ResourceServerPolicies = new HashSet<ResourceServerPolicy>();
            ResourceServerResources = new HashSet<ResourceServerResource>();
            ResourceServerScopes = new HashSet<ResourceServerScope>();
        }

        public string Id { get; set; } = null!;
        public bool AllowRsRemoteMgmt { get; set; }
        public string PolicyEnforceMode { get; set; } = null!;
        public short DecisionStrategy { get; set; }

        public virtual ICollection<ResourceServerPermTicket> ResourceServerPermTickets { get; set; }
        public virtual ICollection<ResourceServerPolicy> ResourceServerPolicies { get; set; }
        public virtual ICollection<ResourceServerResource> ResourceServerResources { get; set; }
        public virtual ICollection<ResourceServerScope> ResourceServerScopes { get; set; }
    }
}
