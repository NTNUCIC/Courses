using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Lesson8_Demo
{
    public abstract class Character
    {
        protected Character()
        {
            _HP = BaseHP;
        }

        protected int _HP;

        public virtual int GetAttack(Character attacker, Weapon weapon)
        {
            int damage = weapon.GetDamage();
            _HP -= damage;
            return damage;
        }

        public abstract string Name { get; }

        public abstract int BaseHP { get; }

        public int HP
        {
            get { return _HP; }
        }

        public bool IsAlive
        {
            get { return HP > 0; }
        }
    }

    public class Player : Character
    {
        public override string Name
        {
            get { return "Player"; }
        }

        public override int BaseHP
        {
            get { return 30; }
        }
    }

    public class Dragon : Character
    {
        public override string Name
        {
            get { return "龍"; }
        }

        public override int BaseHP
        {
            get { return 500; }
        }

        public DragonBreath DragonBreath = new DragonBreath();
    }
}
