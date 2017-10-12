using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Mora
{
    class Program
    {
        static void Main(string[] args)
        {
            Random rd = new Random(Guid.NewGuid().GetHashCode());
            int yours;
            int computers;

            Console.Write("你要出(1)剪刀 (2)石頭 (3)布?");

            int.TryParse(Console.ReadLine(), out yours);
            computers = rd.Next(1, 3);

            Console.WriteLine("電腦出的是: {0}", computers);

            if (yours == 1)
            {
                if (computers == 1)
                {
                    Console.WriteLine("平手");
                }
                else if (computers == 2)
                {
                    Console.WriteLine("Win: 電腦");
                }
                else if (computers == 3)
                {
                    Console.WriteLine("Win: 玩家");
                }
                else
                {
                    Console.WriteLine("錯誤的輸入");
                }
            }
            else if (yours == 2)
            {
                if (computers == 1)
                {
                    Console.WriteLine("Win: 玩家");
                }
                else if (computers == 2)
                {
                    Console.WriteLine("平手");
                }
                else if (computers == 3)
                {
                    Console.WriteLine("Win: 電腦");
                }
                else
                {
                    Console.WriteLine("錯誤的輸入");
                }
            }
            else if (yours == 3)
            {
                if (computers == 1)
                {
                    Console.WriteLine("Win: 電腦");
                }
                else if (computers == 2)
                {
                    Console.WriteLine("Win: 玩家");
                }
                else if (computers == 3)
                {
                    Console.WriteLine("平手");
                }
                else
                {
                    Console.WriteLine("錯誤的輸入");
                }
            }

            Console.ReadLine();
        }
    }
}
