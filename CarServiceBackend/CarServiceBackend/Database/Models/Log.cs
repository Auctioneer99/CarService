using System;
using System.Collections.Generic;

namespace CarServiceBackend.Database.Models
{
    public partial class Log
    {
        public long Id { get; set; }
        public DateTime? Date { get; set; }
        public string? Thread { get; set; }
        public string? Level { get; set; }
        public string? Logger { get; set; }
        public string? LogUser { get; set; }
        public string? Message { get; set; }
        public string? Error { get; set; }
    }
}
