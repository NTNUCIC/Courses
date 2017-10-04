using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ColorTrans
{
    class Program
    {
        static void Main(string[] args)
        {
            int r;
            int g;
            int b;

            string rString;
            string gString;
            string bString;

            #region rgb轉hex
            
            Console.WriteLine("==========色碼轉換器==========");
            Console.WriteLine("請輸入三色色碼(0~255)");
            Console.Write("r:");
            rString = Console.ReadLine();
            Console.Write("g:");
            gString = Console.ReadLine();
            Console.Write("b:");
            bString = Console.ReadLine();

            //文字轉數字
            int.TryParse(rString, out r);
            int.TryParse(gString, out g);
            int.TryParse(bString, out b);

            //轉換成16進位顯示
            Console.WriteLine("轉換出來的色碼是：#{0:X2}{1:X2}{2:X2}", r, g, b);
            Console.ReadLine();
            Console.Clear();
            
            #endregion

            #region hex轉rgb

            string hex;

            Console.WriteLine("==========色碼轉換器==========");
            Console.Write("請輸入十六進位色碼：#");
            hex = Console.ReadLine();

            //文字轉數字
            int hexNum = int.Parse(hex, System.Globalization.NumberStyles.HexNumber);

            r = Convert.ToInt32(Math.Floor(hexNum / Math.Pow(16, 4)));
            g = Convert.ToInt32(Math.Floor(hexNum % Math.Pow(16, 4) / Math.Pow(16,2)));
            b = Convert.ToInt32(Math.Floor(hexNum % Math.Pow(16, 2)));

            Console.WriteLine("轉換出來的色碼是：rgb({0:D2},{1:D2},{2:D2})", r, g, b);
            Console.ReadLine();

            #endregion
        }
    }
}
