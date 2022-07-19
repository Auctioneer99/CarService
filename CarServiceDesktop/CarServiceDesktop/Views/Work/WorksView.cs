using CarServiceDesktop.Auth;
using CarServiceDesktop.Helpers;
using CarServiceDesktop.Models;
using CarServiceDesktop.Models.Work;
using CarServiceDesktop.Properties;
using CarServiceDesktop.Views.Transport;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Text;
using System.Windows.Forms;

namespace CarServiceDesktop.Views.Work
{
    public partial class WorksView : Form
    {
        private const int PAGE_SIZE = 10;

        private AuthService _authService;
        private string _previouslySearchedNumber = "";
        private int _previouslySearchedOffset = 0;

        private List<WorkView> _datagridViewSource;

        private List<WorkView> _unchangedData;

        public WorksView(AuthService authService)
        {
            InitializeComponent();

            bindingSource.DataSource = new PageOffsetList() { PageSize = PAGE_SIZE };
            _authService = authService;
        }


        private async void bindingSource_CurrentChanged(object sender, EventArgs e)
        {
            int offset = (((BindingSource)sender)?.Current as int?) ?? 0;
            if (_previouslySearchedOffset == offset)
            {
                return;
            }
            _previouslySearchedOffset = offset;
            UpdateData(offset, _previouslySearchedNumber);
        }

        private void searchButtonClick(object sender, EventArgs e)
        {
            _previouslySearchedNumber = numberText.Text;
            _previouslySearchedOffset = 0;
            UpdateData(0, numberText.Text);
        }

        private async void UpdateData(int offset, string number)
        {
            using (var client = _authService.GenerateClient())
            {
                var gql = new GraphQLRequest();
                gql.Query = "query($take:Int!,$skip:Int!,$number:String){works(take:$take,skip:$skip,where:{transport:{number:{contains:$number}}}){totalCount items{id performDate returnDate price mileage task transport{id number}}}}";
                gql.Variables.Add("take", PAGE_SIZE);
                gql.Variables.Add("skip", offset);
                gql.Variables.Add("number", number);
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
                            errorText.Text += err?.extensions?.message;
                        }
                    }
                    else
                    {
                        errorText.Text += "Не удалось отправить запрос\n";
                    }
                    return;
                }

                int totalRecords = mapped.data.works.totalCount;
                var records = ((IEnumerable<dynamic>)mapped.data.works.items).Select(i => new WorkView()
                {
                    Id = i.id,
                    Number = i.transport.number,
                    Price = i.price,
                    Mileage = i.mileage,
                    PerformDate = ((DateTime)i.performDate).ToLocalTime(),
                    ReturnDate = ((DateTime?)i.returnDate)?.ToLocalTime(),
                    Task = i.task,
                });
                _unchangedData = records.ToList();
                _datagridViewSource = records.ToList();
                dataGridView.DataSource = _datagridViewSource;
                bindingSource.DataSource = new PageOffsetList() { PageSize = PAGE_SIZE, TotalRecords = totalRecords };
            }
        }

        private void backButtonClick(object sender, EventArgs e)
        {
            Close();
        }

        private void InputTask_FormClosed(object sender, FormClosedEventArgs e)
        {
            Owner.Show();
        }

        private async void saveButtonClick(object sender, EventArgs e)
        {
            errorText.Text = "";
            var values = (dataGridView.DataSource as List<WorkView>);
            using (var client = _authService.GenerateClient())
            {
                for (int i = 0; i < values.Count; i++)
                {
                    var inspectable = values[i];
                    if (inspectable.Equals(_unchangedData[i]) == false)
                    {
                        var gql = new GraphQLRequest();
                        gql.Query = "mutation($id:Long! $returnDate:DateTime $price:Float! $mileage:Float! $task:String!){executorMutation{updateWork(input:{id:$id returnDate:$returnDate price:$price mileage:$mileage task:$task}){id returnDate task mileage price}}}";
                        gql.Variables.Add("id", inspectable.Id);
                        gql.Variables.Add("returnDate", inspectable.ReturnDate);
                        gql.Variables.Add("price", inspectable.Price);
                        gql.Variables.Add("mileage", inspectable.Mileage);
                        gql.Variables.Add("task", inspectable.Task);
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
                                    errorText.Text += err?.extensions?.message + "\n";
                                    errorText.Text += err?.message + "\n";
                                }
                            }
                            else
                            {
                                errorText.Text += "Не удалось отправить запрос\n";
                            }
                            return;
                        }

                        if (mapped.errors != null)
                        {
                            foreach(var err in mapped.errors)
                            {
                                errorText.Text += err.message + "\n";
                            }
                            return;
                        }
                        var fill = _unchangedData[i];
                        fill.ReturnDate = mapped.data.executorMutation.updateWork.returnDate;
                        fill.Price = mapped.data.executorMutation.updateWork.price;
                        fill.Mileage = mapped.data.executorMutation.updateWork.mileage;
                        fill.Task = mapped.data.executorMutation.updateWork.task;
                    }
                }
            }

        }

        private void dataGridView_CellParsing(object sender, DataGridViewCellParsingEventArgs e)
        {
            if (e.ColumnIndex == 6)
            {   
                var formatProvider = this.dataGridView.Rows[e.RowIndex]
                                         .Cells[e.ColumnIndex]
                                         .InheritedStyle
                                         .FormatProvider;
                try
                {
                    e.Value = DateTime.ParseExact(e.Value.ToString(), "dd.MM.yy H:mm", CultureInfo.InvariantCulture);
                }
                catch (FormatException)
                {
                    if (e.Value is DateTime?)
                    {
                        e.Value = null;
                    }
                    else
                    {
                        if (e.Value is DateTime)
                        {
                            e.Value = DateTime.Now;
                        }
                    }
                }
                e.ParsingApplied = true;
            }
            else
            {   
                e.ParsingApplied = false;
            }
        }

        private void addButton_Click(object sender, EventArgs e)
        {
            WorkAdd inputForm = new WorkAdd(_authService);
            inputForm.Show(this);
            Hide();
        }

        private void addTransportButton_Click(object sender, EventArgs e)
        {
            TransportAdd inputForm = new TransportAdd(_authService);
            inputForm.Show(this);
            Hide();
        }
    }
}
