using System;
using System.Collections.Generic;

namespace CarServiceBackend.Database.Models
{
    public partial class UserRequiredAction
    {
        public string UserId { get; set; } = null!;
        public string RequiredAction { get; set; } = null!;

        public virtual UserEntity User { get; set; } = null!;
    }
}
