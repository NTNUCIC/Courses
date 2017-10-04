using System;

namespace BoringRPG
{
    class Program
    {
        static void Main(string[] args)
        {
            //變數
            string userName;

            Console.Write("請輸入主角姓名：");
            userName = Console.ReadLine();

            Console.WriteLine();
            Console.WriteLine("故事即將開始，請按Enter繼續");
            Console.ReadLine();
            Console.Clear();

            Console.WriteLine("~~~~~~~~~~故事開始~~~~~~~~~~");
            Console.ReadLine();
            Console.Clear();
            Console.WriteLine("{0}是個認真的好孩子", userName);
            Console.WriteLine("每天認真念書");
            Console.WriteLine("認真玩樂");
            Console.WriteLine("認真休息");
            Console.ReadLine();
            Console.Clear();
            Console.WriteLine("在認真過生活的狀況下");
            Console.WriteLine("{0}考上了師大", userName);
            Console.WriteLine("成為師大的一員");
            Console.WriteLine("並參加了資訊研究社");
            Console.WriteLine("期望自己能精進相關能力");
            Console.WriteLine();
            Console.WriteLine("在{0}如此認真的學習下", userName);
            Console.WriteLine("{0}畢業後利用自己的程式能力", userName);
            Console.WriteLine("找到了一份工程師工作");
            Console.ReadLine();
            Console.Clear();
            Console.WriteLine("{0}開始工程師人生", userName);
            Console.WriteLine("每天充滿負能量");
            Console.WriteLine("\"為什麼別人三天能寫完，你要一個禮拜？\"");
            Console.WriteLine("\"為什麼測試的時候好好的，Demo給客戶看就壞掉了？\"");
            Console.WriteLine("\"為什麼同樣的步驟別人做都OK，換你做就會出問題？\"");
            Console.WriteLine("\"為什麼你會把Table Drop掉，導致所有的資料都GG了？\"");
            Console.WriteLine();
            Console.WriteLine("原本認真工作的{0}", userName);
            Console.WriteLine("漸漸不再認真往工程師領域精進");
            Console.WriteLine("\"反正再認真再努力，隔天還是會被罵、會製造出各式各樣的Bug\"");
            Console.WriteLine("{0}想著", userName);
            Console.ReadLine();
            Console.Clear();
            Console.WriteLine("{0}的工作狀態越來越糟", userName);
            Console.WriteLine("也越來越負能量");
            Console.WriteLine("終於在某次大出錯後被憤怒的老闆炒了");
            Console.WriteLine();
            Console.WriteLine("有了經驗");
            Console.WriteLine("{0}決定不要再當工程師", userName);
            Console.WriteLine("而是成為工程師們的老闆！");
            Console.WriteLine();
            Console.WriteLine("於是{0}脫離了被罵的生活", userName);
            Console.WriteLine("成了罵人的老闆");
            Console.WriteLine("賺的錢也比過去更多");
            Console.WriteLine("真是可喜可賀可口可樂");
            Console.WriteLine("(*￣▽￣)/‧☆*\"`*-.,_,.-*'`\"*-.,_☆");
            Console.ReadLine();
            Console.Clear();
            Console.WriteLine("~~~~~~~~~~The End~~~~~~~~~~");
            Console.Read();
        }
    }
}
