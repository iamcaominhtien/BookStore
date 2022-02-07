using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BookStore.Areas.Admin.Models
{
    public class SaleChart
    {
        public Nullable<System.DateTime> CreatedDate { get; set; }
        public Nullable<decimal> Price { get; set; }
    }
}