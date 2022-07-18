using CarServiceDesktop.Auth;
using CarServiceDesktop.Views.Work;
using System;
using System.Windows.Forms;

namespace CarServiceDesktop.Views
{
    public partial class Main : Form
    {
        private AuthService _authService;

        public Main(AuthService authService)
        {
            InitializeComponent();
            _authService = authService;
        }

        private void outputButtonClick(object sender, EventArgs e)
        {

        }

        private void OnClosed(object sender, FormClosedEventArgs e)
        {
            Application.Exit();
        }

        private void workButtonClick(object sender, EventArgs e)
        {
            WorksView inputForm = new WorksView(_authService);
            inputForm.Show(this);
            Hide();
        }
    }
}
