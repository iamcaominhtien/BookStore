using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace BookStore.Models
{
    public class RegisterInfo
    {
        [Key]
        public long ID { set; get; }

        [DisplayName("Tên đăng nhập")]
        [Required(ErrorMessage = "Hãy nhập tên người dùng")]
        public string UserName { set; get; }

        [DisplayName("Mật khẩu"), DataType(DataType.Password)]
        [MinLength(6, ErrorMessage = "Độ dài tối thiểu 6 kí tự")]
        [MaxLength(20, ErrorMessage = "Độ dài tối đa 20 kí tự")]
        [Required(ErrorMessage = "Hãynhập mật khẩu")]
        public string Password { set; get; }

        //[Required(ErrorMessage = "Xác nhận mật khẩu")]
        //[DisplayName("Xác nhận mật khẩu"), DataType(DataType.Password)]
        //[Compare("Password", ErrorMessage = "Mật khẩu không khớp")]
        //public string ConfirmPassword { set; get; }

        [DisplayName("Họ và tên")]
        [Required(ErrorMessage = "Hãy nhập họ tên")]
        public string Name { set; get; }

        [DisplayName("Email")]
        [Required(ErrorMessage = "Hãy nhập email")]
        [DataType(DataType.EmailAddress)]
        public string Email { set; get; }

        [Required(ErrorMessage = "Hãy nhập địa chỉ giao hàng")]
        //[DisplayName("Địa chỉ"), DataType(DataType.MultilineText)]
        public string Address { set; get; }

        [Required(ErrorMessage = "Hãy nhập số điện thoại")]
        [DisplayName("Phone"), DataType(DataType.PhoneNumber)]
        public string Phone { set; get; }
        //public string CaptchaCode { get; set; }
    }
}