using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Lesson6_Demo
{
    /// <summary>
    /// 自訂義的類別
    /// </summary>
    class MyClass
    {
        /// <summary>
        /// 數字
        /// Field 欄位
        /// </summary>
        private int myNumber;

        /// <summary>
        /// 數字
        /// Property 屬性
        /// </summary>
        public int Number
        {
            get
            {
                return myNumber;
            }
            set
            {
                myNumber = value;
            }
        }

        /// <summary>
        /// 屬性
        /// </summary>
        public int Property { get; set; }

        /// <summary>
        /// 建構子
        /// </summary>
        public MyClass()
        {

        }

        /// <summary>
        /// 將我的數字加上一個數字
        /// </summary>
        /// <param name="input">你要加的數字</param>
        public void AddNum(int input)
        {
            myNumber += input;
        }

        /// <summary>
        /// 我的數字是不是零
        /// </summary>
        /// <returns>是否為零</returns>
        public bool IsZero()
        {
            if (myNumber == 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        /// <summary>
        /// 清空物件資料回預設值
        /// </summary>
        public void ClearData()
        {
            clear();
        }

        /// <summary>
        /// 清空物件資料回預設值
        /// </summary>
        private void clear()
        {
            myNumber = 0;
            Property = 0;
        }
    }
}
