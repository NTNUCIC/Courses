using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Lottery
{
    class Program
    {
        static void Main(string[] args)
        {
            int num;
            Random rand = new Random(Guid.NewGuid().GetHashCode());

            Console.WriteLine("==========抽籤！==========");
            Console.Write("總共有幾個選項？");
            int.TryParse(Console.ReadLine(), out num);
            Console.WriteLine("從{0}中抽出{1}", num, rand.Next()%num+1);
            Console.ReadLine();
        }
    }
}
