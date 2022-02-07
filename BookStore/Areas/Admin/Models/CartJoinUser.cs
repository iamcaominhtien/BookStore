using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BookStore.Areas.Admin.Models
{
    public class CartJoinUser
    {
        public long ID { get; set; }
        public Nullable<System.DateTime> CreatedDate { get; set; }
        public string Name { get; set; }
        public Nullable<bool> Status { get; set; }
    }
}