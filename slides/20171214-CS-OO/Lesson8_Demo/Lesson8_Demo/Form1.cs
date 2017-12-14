using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Lesson8_Demo
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private Player player = new Player();

        private Dragon dragon = new Dragon();

        private LittleKnife littleKnife = new LittleKnife();

        private Sword sword = new Sword();

        private Excalibur excalibur = new Excalibur();

        private void RefreshHP()
        {
            tbxPlayerHP.Text = player.HP.ToString();
            tbxDragonHP.Text = dragon.HP.ToString();
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            labPlayerName.Text = player.Name;
            labDragonName.Text = dragon.Name;
            RefreshHP();
        }

        private void PlayerAttack(Weapon weapon)
        {
            int d = dragon.GetAttack(player, weapon);
            RefreshHP();
            MessageBox.Show($"{player.Name}使用{weapon.Name}對{dragon.Name}造成{d.ToString()}點傷害!");
            if (!dragon.IsAlive)
            {
                //TODO: dragon dead
            }
            d = player.GetAttack(dragon, dragon.DragonBreath);
            RefreshHP();
            MessageBox.Show($"{dragon.Name}使用{dragon.DragonBreath.Name}對{player.Name}造成{d.ToString()}點傷害!");
            if (!player.IsAlive)
            {
                //TODO: player dead
            }
        }

        //小刀
        private void btnAttack1_Click(object sender, EventArgs e)
        {
            PlayerAttack(littleKnife);
        }

        //劍
        private void btnAttack2_Click(object sender, EventArgs e)
        {
            PlayerAttack(sword);
        }

        //聖劍
        private void btnAttack3_Click(object sender, EventArgs e)
        {
            PlayerAttack(excalibur);
        }
    }
}
