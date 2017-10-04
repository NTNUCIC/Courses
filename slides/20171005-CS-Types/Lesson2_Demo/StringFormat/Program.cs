using System;

namespace StringFormat
{
    class Program
    {
        static void Main(string[] args)
        {
            //串接
            string name = "Kei";
            int age = 24;
            float height = 155.4F;
            float weight = float.MaxValue;

            string intro = string.Format("大家好，\n我是{0}，\n今年歲{1}，\n身高{2}，\n體重{3}，\n請多多指教！",
                                          name,
                                          age,
                                          height,
                                          weight);

            Console.Write(intro);

            Console.ReadLine();
            Console.Clear();

            //指定格式
            name = "Kei";
            age = 24;
            height = 155.4F;
            weight = float.MaxValue;

            intro = string.Format("大家好，\n我是{0}，\n今年歲{1}，\n身高{2:F2}，\n體重{3:F4}，\n請多多指教！",
                                          name,
                                          age,
                                          height,
                                          weight);

            Console.Write(intro);

            Console.ReadLine();
        }
    }
}
