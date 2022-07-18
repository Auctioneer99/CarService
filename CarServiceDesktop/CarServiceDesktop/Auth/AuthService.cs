using CarServiceDesktop.Models;
using CarServiceDesktop.Properties;
using Newtonsoft.Json;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Threading;
using System.Threading.Tasks;

namespace CarServiceDesktop.Auth
{
    public class AuthService
    {
        public AccessToken AccessToken { get; private set; }

        public string AccessTokenRaw => _response.AccessToken;

        private AuthResponse _response;

        public AuthService()
        {

        }

        public AuthService(AccessToken accessToken)
        {
            if (accessToken != null)
            {
                AccessToken = accessToken;
            }
        }

        public async Task<bool> LoginUserAsync(string login, string password)
        {
            using (HttpClient client = new HttpClient())
            {
                var values = new Dictionary<string, string>
                {
                    { "username", login },
                    { "password", password },
                    { "client_id", Settings.Default.AuthClientId },
                    { "grant_type", "password" }
                };

                var content = new FormUrlEncodedContent(values);

                var response = await client.PostAsync(Settings.Default.AuthTokenEndpoint, content);

                if (response.StatusCode != HttpStatusCode.OK)
                {
                    return false;
                }

                var responseString = await response.Content.ReadAsStringAsync();
                var mapped = JsonConvert.DeserializeObject<AuthResponse>(responseString);
                if (mapped != null)
                {
                    var accessJson = mapped.AccessToken.Split('.')[1].DecodeBase64();
                    var accessToken = JsonConvert.DeserializeObject<AccessToken>(accessJson);

                    if (accessToken != null && accessToken.Roles.Contains("executor"))
                    {
                        _response = mapped;
                        AccessToken = accessToken;
                        var refreshTokenInterval = BeginPersist();
                        return true;
                    }
                }
                return false;
            }
        }

        private async Task BeginPersist()
        {
            var source = new CancellationTokenSource();
            while (source.IsCancellationRequested == false)
            {
                await Task.Delay((int)(_response.ExpiresIn * 0.8), source.Token);

                using (HttpClient client = new HttpClient())
                {
                    var values = new Dictionary<string, string>
                    {
                        { "refresh_token", _response.RefreshToken },
                        { "client_id", Settings.Default.AuthClientId },
                        { "grant_type", "refresh_token" }
                    };

                    var content = new FormUrlEncodedContent(values);

                    var response = await client.PostAsync(Settings.Default.AuthRefreshAccessTokenEndpoint, content);

                    if (response.StatusCode != HttpStatusCode.OK)
                    {
                        source.Cancel();
                    }
                    else
                    {
                        var responseString = await response.Content.ReadAsStringAsync();
                        var mapped = JsonConvert.DeserializeObject<AuthResponse>(responseString);
                        if (mapped == null)
                        {
                            source.Cancel();
                        }
                        else
                        {
                            var accessJson = mapped.AccessToken.Split('.')[1].DecodeBase64();
                            var accessToken = JsonConvert.DeserializeObject<AccessToken>(accessJson);
                            if (accessToken != null && accessToken.Roles.Contains("executor"))
                            {
                                _response = mapped;
                                AccessToken = accessToken;
                            }
                            else
                            {
                                source.Cancel();
                            }
                        }
                    }
                }
            }
            AccessToken = null;
            _response = null;
            source.Token.ThrowIfCancellationRequested();
        }

        public void AppendHeaders()
        {

        }

        public HttpClient GenerateClient()
        {
            HttpClient client = new HttpClient();
            client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", AccessTokenRaw);
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            client.DefaultRequestHeaders.Connection.Add("keep-alive");
            client.DefaultRequestHeaders.AcceptEncoding.Add(new StringWithQualityHeaderValue("gzip"));
            client.DefaultRequestHeaders.AcceptEncoding.Add(new StringWithQualityHeaderValue("deflate"));
            client.DefaultRequestHeaders.AcceptEncoding.Add(new StringWithQualityHeaderValue("br"));
            return client;
        }
    }
}
