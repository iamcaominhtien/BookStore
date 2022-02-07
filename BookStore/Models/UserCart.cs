using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BookStore.Models
{
    public class UserCart
    {
        public long OrderID { get; set; }
        public long ProductID { get; set; }
        public int Quantity { get; set; }
    }
}