using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AskGod
{
    class Program
    {
        static void Main(string[] args)
        {
            //true - 正(陽)
            //false - 反(反)
            bool left;
            bool right;
            Random rd = new Random(Guid.NewGuid().GetHashCode());

            Console.WriteLine("==========擲筊==========");
            Console.WriteLine("請按Enter鍵開始");
            Console.ReadLine();

            left = rd.Next(0, 1) == 0;
            right = rd.Next(0, 1) == 0;

            if (left == right)
            {
                if (left == true)
                {
                    Console.WriteLine("你擲出的是: 笑筊");
                }
                else
                {
                    Console.WriteLine("你擲出的是: 陰筊");
                }
            }
            else
            {
                Console.WriteLine("你擲出的是: 聖筊");
            }

            Console.ReadLine();
        }
    }
}
