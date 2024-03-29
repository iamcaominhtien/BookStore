﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace BookStore.Common
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel;
    using System.ComponentModel.DataAnnotations;

    public partial class User
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public User()
        {
            this.Carts = new HashSet<Cart>();
        }
    
        public long ID { get; set; }

        [DisplayName("Tên đăng nhập")]
        [Required(ErrorMessage ="Nhập tên đăng nhập")]
        public string UserName { get; set; }

        [DisplayName("Mật khẩu")]
        [Required(ErrorMessage = "Nhập mật khẩu")]
        [DataType(DataType.Password)]
        public string Password { get; set; }

        [DisplayName("Họ và tên")]
        [Required(ErrorMessage = "Nhập tên")]
        public string Name { get; set; }

        [DisplayName("Địa chỉ")]
        [Required(ErrorMessage = "Nhập địa chỉ")]
        public string Address { get; set; }

        [DisplayName("Email")]
        [Required(ErrorMessage = "Nhập email")]
        [DataType(DataType.EmailAddress,ErrorMessage ="Nhập đúng định dạng email")]
        public string Email { get; set; }

        [DisplayName("Số điện thoại")]
        [DataType(DataType.PhoneNumber)]
        [Required(ErrorMessage = "Nhập số điện thoại")]
        public string Phone { get; set; }

        [DisplayName("Ngày tạo")]
        public Nullable<System.DateTime> CreatedDate { get; set; }

        [DisplayName("Trạng thái")]
        public Nullable<bool> Status { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Cart> Carts { get; set; }
    }
}
