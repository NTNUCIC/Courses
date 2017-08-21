using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BMICalculator
{
    class Program
    {
        static void Main(string[] args)
        {
            //定義變數
            string heightInput;
            string weightInput;
            float height;
            float weight;

            //顯示畫面&讀取使用者輸入
            Console.WriteLine("===========BMI計算器===========");
            Console.WriteLine("請輸入身高(cm)：");
            heightInput = Console.ReadLine();
            Console.WriteLine("請輸入體重(kg)：");
            weightInput = Console.ReadLine();

            //計算
            //string轉float
            float.TryParse(heightInput, out height);
            float.TryParse(weightInput, out weight);
            //身高cm轉m
            height /= 100;
            //BMI
            float bmi = weight / (height*height);

            //顯示結果
            Console.WriteLine("你的BMI是：{0}", bmi);

            //保持畫面暫停
            Console.Read();
        }
    }
}
