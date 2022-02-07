using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace BookStore.Common
{
    public class LoginModel
    {
        [Required(ErrorMessage = "Hãy nhập user name")]
        public string UserName { set; get; }

        [Required(ErrorMessage = "Hãy nhập password")]
        public string Password { set; get; }
        public bool RememberMe { set; get; }
    }
}