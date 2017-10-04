using System;

namespace Calculatiion
{
    class Program
    {
        static void Main(string[] args)
        {
            //四則運算1
            int cake = 3;

            Console.WriteLine("我做了{0}個蛋糕", cake);
            Console.WriteLine("每個蛋糕切八片後得到{0}片", cake * 8);
            Console.WriteLine("但是運送過程中晃壞了3片剩下{0}片", cake * 8 - 3);
            Console.WriteLine("剩的蛋糕分給5個人，每個人拿到{0}片，剩下{1}片", (cake * 8 - 3) / 5, (cake * 8 - 3) % 5);

            Console.ReadLine();
            Console.Clear();

            //四則運算2
            int cake2 = 3;
            cake2 = cake2 * 8;
            cake2 = cake2 - 3;

            int eachPerson = cake2 / 5;
            int left = cake2 % 5;

            Console.WriteLine("剩的蛋糕分給5個人，每個人拿到{0}片，剩下{1}片", eachPerson, left);

            Console.ReadLine();
            Console.Clear();

            //偷懶的四則運算
            int cake3 = 3;
            cake3 *= 8;
            cake3 -= 3;

            eachPerson = cake3 / 5;
            left = cake3 % 5;

            Console.WriteLine("剩的蛋糕分給5個人，每個人拿到{0}片，剩下{1}片", eachPerson, left);

            Console.ReadLine();
        }
    }
}
