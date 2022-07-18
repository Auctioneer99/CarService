using CarServiceDesktop.Auth;
using CarServiceDesktop.Models;
using CarServiceDesktop.Models.User;
using CarServiceDesktop.Properties;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace CarServiceDesktop.Views.Transport
{
    public partial class TransportAdd : Form
    {
        private AuthService _authService;

        private CancellationTokenSource _tokenSourceUserSearch = new CancellationTokenSource();

        private UserView[] _lastSearch = new UserView[] { };

        public TransportAdd(AuthService authService)
        {
            InitializeComponent();
            _authService = authService;
        }

        private void ownerBox_KeyPress(object sender, KeyPressEventArgs e)
        {
            HandleSearch();
        }

        private void ownerBox_Click(object sender, EventArgs e)
        {
            HandleSearch();
        }

        private async void HandleSearch()
        {
            _tokenSourceUserSearch.Cancel();
            _tokenSourceUserSearch = new CancellationTokenSource();

            try
            {
                await Task.Delay(1000, _tokenSourceUserSearch.Token);
            }
            catch
            {
                return;
            }

            using (var client = _authService.GenerateClient())
            {
                var gql = new GraphQLRequest();
                gql.Query = "query{owners(name:\"" + ownerBox.Text + "\" first:20){nodes{id name}}}";
                var request = new HttpRequestMessage()
                {
                    RequestUri = new Uri(Settings.Default.ApiEndpoint),
                    Method = HttpMethod.Post,
                    Content = new StringContent(JsonConvert.SerializeObject(gql), Encoding.UTF8, "application/json")
                };
                var response = await client.SendAsync(request);

                if (response.StatusCode != HttpStatusCode.OK)
                {
                    errorText.Text = "Не удалось отправить запрос";
                    return;
                }

                var responseString = await response.Content.ReadAsStringAsync();
                dynamic mapped = JsonConvert.DeserializeObject(responseString);

                var transports = JsonConvert.DeserializeObject<UserView[]>(mapped.data.owners.nodes.ToString());

                int i = ownerBox.SelectionStart;
                ownerBox.DroppedDown = false;
                _lastSearch = ownerBox.Items.Cast<UserView>().ToArray();
                ownerBox.Items.Clear();
                ownerBox.Items.AddRange(transports);
                ownerBox.DroppedDown = true;
                ownerBox.SelectionStart = i;
            }
        }

        private async void createButton_Click(object sender, EventArgs e)
        {
            errorText.Text = "";
            using (var client = _authService.GenerateClient())
            {
                var gql = new GraphQLRequest();
                try
                {
                    gql.Query = "mutation($userId: String! $number: String! $model: String!){executorMutation{addTransport(input:{ownerId:$userId number:$number model:$model}){id}}}";
                    gql.Variables.Add("userId", (ownerBox.SelectedItem as UserView)?.Id);
                    gql.Variables.Add("number", numberText.Text);
                    gql.Variables.Add("model", modelText.Text);
                }
                catch
                {
                    errorText.Text += "Данные введены неправильно (число)\n";
                }
                var g = JsonConvert.SerializeObject(gql);

                var request = new HttpRequestMessage()
                {
                    RequestUri = new Uri(Settings.Default.ApiEndpoint),
                    Method = HttpMethod.Post,
                    Content = new StringContent(JsonConvert.SerializeObject(gql), Encoding.UTF8, "application/json")
                };
                var response = await client.SendAsync(request);

                var responseString = await response.Content.ReadAsStringAsync();
                dynamic mapped = JsonConvert.DeserializeObject(responseString);


                if (response.StatusCode != HttpStatusCode.OK)
                {
                    if (mapped.errors != null)
                    {
                        foreach (var err in mapped.errors)
                        {
                            errorText.Text += err.extensions?.message;
                            errorText.Text += err.message;
                        }
                    }
                    else
                    {
                        errorText.Text += "Не удалось отправить запрос\n";
                    }
                    return;
                }
            }

            Close();
        }

        private void backButton_Click(object sender, EventArgs e)
        {
            Close();
        }

        private void TransportAdd_FormClosed(object sender, FormClosedEventArgs e)
        {
            Owner.Show();
        }
    }
}
