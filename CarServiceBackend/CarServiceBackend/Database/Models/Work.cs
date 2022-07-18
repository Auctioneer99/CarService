using CarServiceBackend.Auth;
using HotChocolate.AspNetCore.Authorization;
using System;
using System.Collections.Generic;

namespace CarServiceBackend.Database.Models
{
    [Authorize]
    public partial class Work
    {
        public long Id { get; set; }
        public long TransportId { get; set; }
        public string ExecutorId { get; set; } = null!;
        public DateTime PerformDate { get; set; }
        public DateTime? ReturnDate { get; set; }
        public double Price { get; set; }
        public double Mileage { get; set; }
        public string Task { get; set; } = null!;

        public virtual Transport Transport { get; set; } = null!;
        public virtual UserEntity Executor { get; set; } = null!;
    }
}
