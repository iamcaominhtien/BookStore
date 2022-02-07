using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BookStore.Common
{
    [Serializable] //Cho phép lưu trạng thái của một đối tương và tạo lại nó khi cần thiết 
    public class UserLogin
    {
        public long UserID { set; get; }
        public string UserName { set; get; }
        public string Group { set; get; }
    }
}