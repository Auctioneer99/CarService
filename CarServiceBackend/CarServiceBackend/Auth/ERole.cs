namespace CarServiceBackend.Auth
{
    public static class RoleStrings
    {
        public const string CUSTOMER = "customer";
        public const string EXECUTOR = "executor";
        public const string ADMIN = "admin";
    }

    [Flags]
    public enum ERole : byte
    {
        Customer = 1 << 0,
        Executor = 1 << 1,
        Admin = 1 << 2,
        All = Customer | Executor | Admin
    }

    public static class ERoleExtensions
    {
        public static string[] GetStrings(this ERole role)
        {
            var roles = new List<string>();
            if ((role & ERole.Customer) > 0)
            {
                roles.Add(RoleStrings.CUSTOMER);
            }
            if ((role & ERole.Executor) > 0)
            {
                roles.Add(RoleStrings.EXECUTOR);
            }
            if ((role & ERole.Admin) > 0)
            {
                roles.Add(RoleStrings.ADMIN);
            }
            return roles.ToArray();
        }
    }
}
