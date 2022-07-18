using CarServiceDesktop.Auth;
using System;
using System.Windows.Forms;

namespace CarServiceDesktop.Views
{
    public partial class Login : Form
    {
        private AuthService _authService = new AuthService();

        public Login()
        {
            InitializeComponent();
        }

        private async void OnLoginClick(object sender, EventArgs e)
        {
            errorText.Text = "";
            var login = loginText.Text;
            if (login == "")
            {
                errorText.Text += "Введите логин\n";
                return;
            }
            var pass = passwordText.Text;
            if (pass == "")
            {
                errorText.Text += "Введите пароль\n";
                return;
            }

            loginButton.Enabled = false;
            loginText.Enabled = false;
            passwordText.Enabled = false;


            var result = await _authService.LoginUserAsync(login, pass);

            if (result)
            {
                Main mainForm = new Main(_authService);
                mainForm.Show(this);
                Hide();
            }
            else
            {
                errorText.Text = "Логин или\nпароль неверный";
            }
            loginButton.Enabled = true;
            loginText.Enabled = true;
            passwordText.Enabled = true;
        }
    }
}
