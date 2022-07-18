using Newtonsoft.Json;

namespace CarServiceDesktop.Models
{
    public class AccessToken
    {
        [JsonProperty(PropertyName = "exp")]
        public long Exp { get; set; }

        [JsonProperty(PropertyName = "iat")]
        public long IAT { get; set; }

        [JsonProperty(PropertyName = "jti")]
        public string JTI { get; set; }

        [JsonProperty(PropertyName = "iss")]
        public string Iss { get; set; }

        [JsonProperty(PropertyName = "aud")]
        public string Aud { get; set; }

        [JsonProperty(PropertyName = "sub")]
        public string Sub { get; set; }

        [JsonProperty(PropertyName = "typ")]
        public string Typ { get; set; }

        [JsonProperty(PropertyName = "azp")]
        public string AZP { get; set; }

        [JsonProperty(PropertyName = "session_state")]
        public string SessionState { get; set; }

        [JsonProperty(PropertyName = "acr")]
        public string Acr { get; set; }

        [JsonProperty(PropertyName = "allowed-origins")]
        public string[] AllowedOrigins { get; set; }

        [JsonProperty(PropertyName = "realm_access")]
        public object RealmAccess { get; set; }

        [JsonProperty(PropertyName = "resource_access")]
        public object ResourceAccess { get; set; }

        [JsonProperty(PropertyName = "scope")]
        public string Scope { get; set; }

        [JsonProperty(PropertyName = "sid")]
        public string Sid { get; set; }

        [JsonProperty(PropertyName = "email_verified")]
        public bool EmailVerified { get; set; }

        [JsonProperty(PropertyName = "roles")]
        public string[] Roles { get; set; }

        [JsonProperty(PropertyName = "name")]
        public string Name { get; set; }

        [JsonProperty(PropertyName = "preferred_username")]
        public string PreferredUsername { get; set; }

        [JsonProperty(PropertyName = "given_name")]
        public string GivenName { get; set; }

        [JsonProperty(PropertyName = "family_name")]
        public string FamilyName { get; set; }

        [JsonProperty(PropertyName = "email")]
        public string Email { get; set; }

    }
}
