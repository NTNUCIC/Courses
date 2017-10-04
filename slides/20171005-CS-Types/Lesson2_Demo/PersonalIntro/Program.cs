using System;

namespace PersonalIntro
{
    class Program
    {
        static void Main(string[] args)
        {
            //Read, ReadLine
            string gender;
            string name;
            int age;

            Console.Write("請輸入你的性別(M/F): ");
            gender = Console.ReadLine();

            Console.Write("請輸入你的姓名: ");
            name = Console.ReadLine();

            Console.Write("請輸入你的年齡：");
            age = Console.Read();

            Console.WriteLine("姓名：{0}", name);
            Console.WriteLine("性別：{0}", gender);
            Console.WriteLine("年齡：{0}", age);
            Console.ReadLine();

            Console.ReadLine();
            Console.Clear();

            //Parse
            string ageString;

            Console.Write("請輸入你的年齡：");
            ageString = Console.ReadLine();

            age = int.Parse(ageString);
            Console.WriteLine("年齡：{0}", age);

            Console.ReadLine();
            Console.Clear();

            //TryParse
            Console.Write("請輸入你的年齡：");
            ageString = Console.ReadLine();

            int.TryParse(ageString, out age);
            Console.WriteLine("年齡：{0}", age);

            Console.ReadLine();
        }
    }
}
