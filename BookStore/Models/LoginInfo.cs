using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using BookStore.Common;

namespace BookStore.Models
{
    public class LoginInfo
    {
        BookStoreEntities db = new BookStoreEntities();

        [Key]
        [DisplayName("Email hoặc tên đăng nhập")]
        [Required(ErrorMessage ="Nhập tên người dùng hoặc email")]
        public string EMailorUserName { set; get; }

        [DisplayName("Mật khẩu"),DataType(DataType.Password)]
        [Required(ErrorMessage = "Nhập mật khẩu")]
        public string Password { set; get; }

        public int LoginUser() 
        {
            string password = Encryptor.MD5Hash(Password);
            var result = db.Users.SingleOrDefault(x => x.Email == EMailorUserName || x.UserName == EMailorUserName);

            //Username doesn't exit
            if (result == null)
                return 0;

            //User is being locked
            if (result.Status == false)
                return -1;

            //Password is true
            if (result.Password == password)
                return 1;

            //All is wrong
            return -2;
        }
    }
}