using CarServiceDesktop.Auth;
using CarServiceDesktop.Models;
using CarServiceDesktop.Models.Transport;
using CarServiceDesktop.Properties;
using Newtonsoft.Json;
using System;
using System.Data;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace CarServiceDesktop.Views.Work
{
    public partial class WorkAdd : Form
    {
        private AuthService _authService;

        private CancellationTokenSource _tokenSourceTransportSearch = new CancellationTokenSource();

        private TransportView[] _lastSearch = new TransportView[] { };

        public WorkAdd(AuthService authService)
        {
            InitializeComponent();
            _authService = authService;
        }

        private void backButtonClick(object sender, EventArgs e)
        {
            Close();
        }

        private void InputTask_FormClosed(object sender, FormClosedEventArgs e)
        {
            Owner.Show();
        }

        private async void createButtonClick(object sender, EventArgs e)
        {
            errorText.Text = "";
            using (var client = _authService.GenerateClient())
            {
                var gql = new GraphQLRequest();
                try
                {
                    gql.Query = "mutation($transportId:Long! $price:Float! $performDate:DateTime! $mileage:Float! $task:String!){executorMutation{addWork(input:{transportId:$transportId performDate:$performDate price:$price mileage:$mileage task:$task}){id}}}";
                    gql.Variables.Add("transportId", (transportBox.SelectedItem as TransportView)?.Id);
                    gql.Variables.Add("performDate", performDatePicker.Value.ToString());
                    gql.Variables.Add("price", double.Parse(priceText.Text));
                    gql.Variables.Add("mileage", double.Parse(mileageText.Text));
                    gql.Variables.Add("task", taskText.Text);
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

        private void checkNumber(object sender, KeyPressEventArgs e)
        {
            if (sender is TextBox box)
            {
                if (e.KeyChar != (char)8)
                {
                    if (char.IsDigit(e.KeyChar) || e.KeyChar == '.')
                    {
                        var text = box.Text + e.KeyChar;
                        if (Regex.IsMatch(text, @"^\d+\.?\d*$") == false)
                        {
                            e.Handled = true;
                            return;
                        }
                    }
                    else
                    {
                        e.Handled = true;
                        return;
                    }
                }
            }
        }

        private async void transportSearch(object sender, EventArgs e)
        {
            HandleSearch();
        }

        private void transportBoxSearch(object sender, KeyPressEventArgs e)
        {
            HandleSearch();
        }

        private async void HandleSearch()
        {
            _tokenSourceTransportSearch.Cancel();
            _tokenSourceTransportSearch = new CancellationTokenSource();

            try
            {
                await Task.Delay(1000, _tokenSourceTransportSearch.Token);
            }
            catch
            {
                return;
            }

            using (var client = _authService.GenerateClient())
            {
                var gql = new GraphQLRequest();
                gql.Query = "query{transports(number:\"" + transportBox.Text + "\" first:20){nodes{id number}}}";
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

                var transports = JsonConvert.DeserializeObject<TransportView[]>(mapped.data.transports.nodes.ToString());

                int i = transportBox.SelectionStart;
                transportBox.DroppedDown = false;
                _lastSearch = transportBox.Items.Cast<TransportView>().ToArray();
                transportBox.Items.Clear();
                transportBox.Items.AddRange(transports);
                transportBox.DroppedDown = true;
                transportBox.SelectionStart = i;
            }
        }

        private void transportSearchLeave(object sender, EventArgs e)
        {
            if (transportBox.Items.Cast<TransportView>().Union(_lastSearch).Where(t => t.Number == transportBox.Text).Any() == false)
            {
                transportBox.Text = "";
            }
        }
    }
}
