using System;

namespace ChatRoom
{
    class Program
    {
        static void Main(string[] args)
        {
            string name;

            Console.WriteLine("==========正妹三寶聊天室==========");

            Console.Write("請輸入姓名:");
            name = Console.ReadLine();

            Console.WriteLine("{0}: 你好呀!", name);
            Console.WriteLine("正妹: Hi");
            Console.WriteLine("{0}: 你今天看起來心情不錯耶~", name);
            Console.WriteLine("正妹: 嗯嗯~");
            Console.WriteLine("{0}: 真巧，我今天心情也不錯!", name);
            Console.WriteLine("正妹: 哈哈XD");
            Console.WriteLine("{0}: 國慶連假打算做什麼呢?", name);
            Console.WriteLine("正妹: 沒特別想法耶");
            Console.WriteLine("正妹: 我先去洗澡哦，晚點再聊~");
            Console.WriteLine("(正妹已離開聊天室)");

            Console.ReadLine();
        }
    }
}
