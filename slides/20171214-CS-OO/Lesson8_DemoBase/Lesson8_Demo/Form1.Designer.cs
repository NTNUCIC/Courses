namespace Lesson8_Demo
{
    partial class Form1
    {
        /// <summary>
        /// 設計工具所需的變數。
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// 清除任何使用中的資源。
        /// </summary>
        /// <param name="disposing">如果應該處置 Managed 資源則為 true，否則為 false。</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form 設計工具產生的程式碼

        /// <summary>
        /// 此為設計工具支援所需的方法 - 請勿使用程式碼編輯器修改
        /// 這個方法的內容。
        /// </summary>
        private void InitializeComponent()
        {
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(Form1));
            this.labPlayerName = new System.Windows.Forms.Label();
            this.labDragonName = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.tbxPlayerHP = new System.Windows.Forms.TextBox();
            this.tbxDragonHP = new System.Windows.Forms.TextBox();
            this.label4 = new System.Windows.Forms.Label();
            this.btnAttack1 = new System.Windows.Forms.Button();
            this.btnAttack2 = new System.Windows.Forms.Button();
            this.btnAttack3 = new System.Windows.Forms.Button();
            this.pictureBox1 = new System.Windows.Forms.PictureBox();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).BeginInit();
            this.SuspendLayout();
            // 
            // labPlayerName
            // 
            this.labPlayerName.AutoSize = true;
            this.labPlayerName.Font = new System.Drawing.Font("Calibri", 20.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.labPlayerName.Location = new System.Drawing.Point(12, 9);
            this.labPlayerName.Name = "labPlayerName";
            this.labPlayerName.Size = new System.Drawing.Size(81, 33);
            this.labPlayerName.TabIndex = 0;
            this.labPlayerName.Text = "Player";
            // 
            // labDragonName
            // 
            this.labDragonName.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.labDragonName.AutoSize = true;
            this.labDragonName.Font = new System.Drawing.Font("Calibri", 20.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.labDragonName.Location = new System.Drawing.Point(338, 9);
            this.labDragonName.Name = "labDragonName";
            this.labDragonName.Size = new System.Drawing.Size(94, 33);
            this.labDragonName.TabIndex = 1;
            this.labDragonName.Text = "Dragon";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Font = new System.Drawing.Font("微軟正黑體", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(136)));
            this.label3.Location = new System.Drawing.Point(14, 56);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(57, 20);
            this.label3.TabIndex = 2;
            this.label3.Text = "血量：";
            // 
            // tbxPlayerHP
            // 
            this.tbxPlayerHP.Font = new System.Drawing.Font("Calibri", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tbxPlayerHP.Location = new System.Drawing.Point(77, 54);
            this.tbxPlayerHP.Name = "tbxPlayerHP";
            this.tbxPlayerHP.ReadOnly = true;
            this.tbxPlayerHP.Size = new System.Drawing.Size(100, 27);
            this.tbxPlayerHP.TabIndex = 3;
            this.tbxPlayerHP.TabStop = false;
            // 
            // tbxDragonHP
            // 
            this.tbxDragonHP.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.tbxDragonHP.Font = new System.Drawing.Font("Calibri", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tbxDragonHP.Location = new System.Drawing.Point(332, 54);
            this.tbxDragonHP.Name = "tbxDragonHP";
            this.tbxDragonHP.ReadOnly = true;
            this.tbxDragonHP.Size = new System.Drawing.Size(100, 27);
            this.tbxDragonHP.TabIndex = 4;
            this.tbxDragonHP.TabStop = false;
            // 
            // label4
            // 
            this.label4.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.label4.AutoSize = true;
            this.label4.Font = new System.Drawing.Font("微軟正黑體", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(136)));
            this.label4.Location = new System.Drawing.Point(269, 56);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(57, 20);
            this.label4.TabIndex = 5;
            this.label4.Text = "血量：";
            // 
            // btnAttack1
            // 
            this.btnAttack1.Font = new System.Drawing.Font("微軟正黑體", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(136)));
            this.btnAttack1.Location = new System.Drawing.Point(12, 96);
            this.btnAttack1.Name = "btnAttack1";
            this.btnAttack1.Size = new System.Drawing.Size(165, 33);
            this.btnAttack1.TabIndex = 6;
            this.btnAttack1.Text = "用小刀攻擊";
            this.btnAttack1.UseVisualStyleBackColor = true;
            this.btnAttack1.Click += new System.EventHandler(this.btnAttack1_Click);
            // 
            // button1
            // 
            this.btnAttack2.Font = new System.Drawing.Font("微軟正黑體", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(136)));
            this.btnAttack2.Location = new System.Drawing.Point(12, 135);
            this.btnAttack2.Name = "button1";
            this.btnAttack2.Size = new System.Drawing.Size(165, 33);
            this.btnAttack2.TabIndex = 7;
            this.btnAttack2.Text = "用劍攻擊";
            this.btnAttack2.UseVisualStyleBackColor = true;
            this.btnAttack2.Click += new System.EventHandler(this.btnAttack2_Click);
            // 
            // button2
            // 
            this.btnAttack3.Font = new System.Drawing.Font("微軟正黑體", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(136)));
            this.btnAttack3.Location = new System.Drawing.Point(12, 174);
            this.btnAttack3.Name = "button2";
            this.btnAttack3.Size = new System.Drawing.Size(165, 33);
            this.btnAttack3.TabIndex = 8;
            this.btnAttack3.Text = "用EX．咖哩棒攻擊";
            this.btnAttack3.UseVisualStyleBackColor = true;
            this.btnAttack3.Click += new System.EventHandler(this.btnAttack3_Click);
            // 
            // pictureBox1
            // 
            this.pictureBox1.Image = ((System.Drawing.Image)(resources.GetObject("pictureBox1.Image")));
            this.pictureBox1.Location = new System.Drawing.Point(273, 87);
            this.pictureBox1.Name = "pictureBox1";
            this.pictureBox1.Size = new System.Drawing.Size(151, 188);
            this.pictureBox1.SizeMode = System.Windows.Forms.PictureBoxSizeMode.Zoom;
            this.pictureBox1.TabIndex = 9;
            this.pictureBox1.TabStop = false;
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 12F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(444, 296);
            this.Controls.Add(this.pictureBox1);
            this.Controls.Add(this.btnAttack3);
            this.Controls.Add(this.btnAttack2);
            this.Controls.Add(this.btnAttack1);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.tbxDragonHP);
            this.Controls.Add(this.tbxPlayerHP);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.labDragonName);
            this.Controls.Add(this.labPlayerName);
            this.Name = "Form1";
            this.Text = "Lesson8";
            this.Load += new System.EventHandler(this.Form1_Load);
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label labPlayerName;
        private System.Windows.Forms.Label labDragonName;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.TextBox tbxPlayerHP;
        private System.Windows.Forms.TextBox tbxDragonHP;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Button btnAttack1;
        private System.Windows.Forms.Button btnAttack2;
        private System.Windows.Forms.Button btnAttack3;
        private System.Windows.Forms.PictureBox pictureBox1;
    }
}

