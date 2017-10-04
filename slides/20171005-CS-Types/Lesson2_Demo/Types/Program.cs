using System;

namespace Types
{
    class Program
    {
        static void Main(string[] args)
        {
            //布林
            bool isAmyGirl = true;
            bool isAndyGirl = false;

            Console.WriteLine("Is Amy a Girl? {0}", isAmyGirl);
            Console.WriteLine("Is Andy a Girl? {0}", isAndyGirl);

            Console.ReadLine();
            Console.Clear();

            //數字
            int deposit = -200;
            int score = 100;
            uint age = 24;
            long rich = 1239847199868777238;
            short studentCount = 155;

            float height = 155.4F;
            double bill = 699.14389713214938513;
            decimal cash = 13.1384719837419834774663717382435234252344235234523543234522435223452123M;

            Console.WriteLine("Deposit: {0}", deposit);
            Console.WriteLine("Score: {0}", score);
            Console.WriteLine("Age: {0}", age);
            Console.WriteLine("Rich: {0}", rich);
            Console.WriteLine("StudentCount: {0}", studentCount);

            Console.WriteLine("Height: {0}", height);
            Console.WriteLine("Bill: {0}", bill);
            Console.WriteLine("Cash: {0}", cash);

            Console.ReadLine();
            Console.Clear();

            //文字
            char grade = 'F';
            string name = "Kei";

            Console.WriteLine("Student Name: {0}.", name);
            Console.WriteLine("Grade: {0}", grade);

            Console.ReadLine();
            Console.Clear();

            //其他
            grade myGrade = Program.grade.Acceptable;
            grade kerwinGrade = Program.grade.Outstanding;
            grade ryanGrade = Program.grade.Terrible;

            Console.WriteLine("Mine: {0}", myGrade);
            Console.WriteLine("Kerwin's: {0}", kerwinGrade);
            Console.WriteLine("Ryan's: {0}", ryanGrade);
            Console.ReadLine();
        }

        //定義列舉
        public enum grade
        {
            Outstanding,
            ExceedsExpectations,
            Acceptable,
            Poor,
            Dreadful,
            Terrible
        };
    }
}
