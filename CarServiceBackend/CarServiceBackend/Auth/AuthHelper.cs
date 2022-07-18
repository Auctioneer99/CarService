using System.Security.Claims;

namespace CarServiceBackend.Auth
{
    public static class AuthHelper
    {
        public static string GetId(this ClaimsPrincipal claims)
        {
            var a = claims.FindFirst("http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier");
            
            return a?.Value;
        }

        public static bool IsAuthenticated(this ClaimsPrincipal claims)
        {
            return ((ClaimsIdentity)claims.Identity).IsAuthenticated;
        }

        public static bool IsInRole(this ClaimsPrincipal claims, ERole role)
        {
            foreach(var r in role.GetStrings())
            {
                if (claims.IsInRole(r))
                {
                    return true;
                }
            }
            return false;
        }

        public static bool NotInRole(this ClaimsPrincipal claims, ERole role)
        {
            foreach (var r in role.GetStrings())
            {
                if (claims.IsInRole(r))
                {
                    return false;
                }
            }
            return true;
        }
    }
}
