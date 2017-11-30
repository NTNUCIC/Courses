using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Lesson6_Demo
{
    class Program
    {
        static void Main(string[] args)
        {
            // null 表示不存在實體
            MyClass myObject = null;
            Console.WriteLine("myObject: {0}", myObject);

            //建立實體
            myObject = new MyClass();
            Console.WriteLine("myObject.IsZero: {0}", myObject.IsZero());
            Console.WriteLine("myObject.Number: {0}", myObject.Number);
            Console.WriteLine("myObject.Property: {0}", myObject.Property);
            Console.WriteLine();

            myObject.Number += 3;
            Console.WriteLine("myObject.IsZero: {0}", myObject.IsZero());
            Console.WriteLine("myObject.Number: {0}", myObject.Number);
            Console.WriteLine("myObject.Property: {0}", myObject.Property);
            Console.WriteLine();

            myObject.Property += 2;
            Console.WriteLine("myObject.IsZero: {0}", myObject.IsZero());
            Console.WriteLine("myObject.Number: {0}", myObject.Number);
            Console.WriteLine("myObject.Property: {0}", myObject.Property);
            Console.WriteLine();

            myObject.AddNum(4);
            Console.WriteLine("myObject.IsZero: {0}", myObject.IsZero());
            Console.WriteLine("myObject.Number: {0}", myObject.Number);
            Console.WriteLine("myObject.Property: {0}", myObject.Property);
            Console.WriteLine();

            myObject.ClearData();
            Console.WriteLine("myObject.IsZero: {0}", myObject.IsZero());
            Console.WriteLine("myObject.Number: {0}", myObject.Number);
            Console.WriteLine("myObject.Property: {0}", myObject.Property);
            Console.WriteLine();

            //private的東西外部無法取得
            //myObject.myNumber = 3;
            //myObject.clear();

            Console.ReadLine();
        }
    }
}
