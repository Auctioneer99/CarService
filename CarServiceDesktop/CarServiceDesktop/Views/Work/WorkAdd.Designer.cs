namespace CarServiceDesktop.Views.Work
{
    partial class WorkAdd
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.label4 = new System.Windows.Forms.Label();
            this.label5 = new System.Windows.Forms.Label();
            this.errorText = new System.Windows.Forms.Label();
            this.transportBox = new System.Windows.Forms.ComboBox();
            this.performDatePicker = new System.Windows.Forms.DateTimePicker();
            this.priceText = new System.Windows.Forms.TextBox();
            this.mileageText = new System.Windows.Forms.TextBox();
            this.taskText = new System.Windows.Forms.TextBox();
            this.backButton = new System.Windows.Forms.Button();
            this.createButton = new System.Windows.Forms.Button();
            this.groupBox1.SuspendLayout();
            this.SuspendLayout();
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.createButton);
            this.groupBox1.Controls.Add(this.backButton);
            this.groupBox1.Controls.Add(this.taskText);
            this.groupBox1.Controls.Add(this.mileageText);
            this.groupBox1.Controls.Add(this.priceText);
            this.groupBox1.Controls.Add(this.performDatePicker);
            this.groupBox1.Controls.Add(this.transportBox);
            this.groupBox1.Controls.Add(this.errorText);
            this.groupBox1.Controls.Add(this.label5);
            this.groupBox1.Controls.Add(this.label4);
            this.groupBox1.Controls.Add(this.label3);
            this.groupBox1.Controls.Add(this.label2);
            this.groupBox1.Controls.Add(this.label1);
            this.groupBox1.Location = new System.Drawing.Point(12, 12);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(247, 242);
            this.groupBox1.TabIndex = 0;
            this.groupBox1.TabStop = false;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(69, 23);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(41, 13);
            this.label1.TabIndex = 0;
            this.label1.Text = "Номер";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(14, 53);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(96, 13);
            this.label2.TabIndex = 1;
            this.label2.Text = "Дата исполнения";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(75, 76);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(33, 13);
            this.label3.TabIndex = 2;
            this.label3.Text = "Цена";
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(66, 102);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(44, 13);
            this.label4.TabIndex = 3;
            this.label4.Text = "Пробег";
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Location = new System.Drawing.Point(58, 128);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(50, 13);
            this.label5.TabIndex = 4;
            this.label5.Text = "Задание";
            // 
            // errorText
            // 
            this.errorText.AutoSize = true;
            this.errorText.ForeColor = System.Drawing.Color.Red;
            this.errorText.Location = new System.Drawing.Point(14, 155);
            this.errorText.Name = "errorText";
            this.errorText.Size = new System.Drawing.Size(0, 13);
            this.errorText.TabIndex = 5;
            // 
            // transportBox
            // 
            this.transportBox.DisplayMember = "number";
            this.transportBox.Location = new System.Drawing.Point(116, 20);
            this.transportBox.Name = "transportBox";
            this.transportBox.Size = new System.Drawing.Size(121, 21);
            this.transportBox.TabIndex = 6;
            this.transportBox.ValueMember = "id";
            this.transportBox.Click += new System.EventHandler(this.transportSearch);
            this.transportBox.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.transportBoxSearch);
            this.transportBox.Leave += new System.EventHandler(this.transportSearchLeave);
            // 
            // performDatePicker
            // 
            this.performDatePicker.CustomFormat = "d.MM.yy H:mm";
            this.performDatePicker.Format = System.Windows.Forms.DateTimePickerFormat.Custom;
            this.performDatePicker.Location = new System.Drawing.Point(116, 47);
            this.performDatePicker.Name = "performDatePicker";
            this.performDatePicker.Size = new System.Drawing.Size(121, 20);
            this.performDatePicker.TabIndex = 7;
            // 
            // priceText
            // 
            this.priceText.Location = new System.Drawing.Point(116, 73);
            this.priceText.Name = "priceText";
            this.priceText.Size = new System.Drawing.Size(121, 20);
            this.priceText.TabIndex = 8;
            this.priceText.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.checkNumber);
            // 
            // mileageText
            // 
            this.mileageText.Location = new System.Drawing.Point(116, 99);
            this.mileageText.Name = "mileageText";
            this.mileageText.Size = new System.Drawing.Size(121, 20);
            this.mileageText.TabIndex = 9;
            this.mileageText.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.checkNumber);
            // 
            // taskText
            // 
            this.taskText.Location = new System.Drawing.Point(116, 125);
            this.taskText.Name = "taskText";
            this.taskText.Size = new System.Drawing.Size(121, 20);
            this.taskText.TabIndex = 10;
            // 
            // backButton
            // 
            this.backButton.Location = new System.Drawing.Point(17, 208);
            this.backButton.Name = "backButton";
            this.backButton.Size = new System.Drawing.Size(75, 23);
            this.backButton.TabIndex = 11;
            this.backButton.Text = "Назад";
            this.backButton.UseVisualStyleBackColor = true;
            this.backButton.Click += new System.EventHandler(this.backButtonClick);
            // 
            // createButton
            // 
            this.createButton.Location = new System.Drawing.Point(162, 208);
            this.createButton.Name = "createButton";
            this.createButton.Size = new System.Drawing.Size(75, 23);
            this.createButton.TabIndex = 12;
            this.createButton.Text = "Создать";
            this.createButton.UseVisualStyleBackColor = true;
            this.createButton.Click += new System.EventHandler(this.createButtonClick);
            // 
            // WorkAdd
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(274, 265);
            this.Controls.Add(this.groupBox1);
            this.Name = "WorkAdd";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
            this.Text = "WorkAdd";
            this.FormClosed += new System.Windows.Forms.FormClosedEventHandler(this.InputTask_FormClosed);
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.Button createButton;
        private System.Windows.Forms.Button backButton;
        private System.Windows.Forms.TextBox taskText;
        private System.Windows.Forms.TextBox mileageText;
        private System.Windows.Forms.TextBox priceText;
        private System.Windows.Forms.DateTimePicker performDatePicker;
        private System.Windows.Forms.ComboBox transportBox;
        private System.Windows.Forms.Label errorText;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label1;
    }
}