using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BookStore.Areas.Admin.Models
{
    public class ProductOnChart
    {
        public string Name { get; set; }
        public int Quantity { get; set; }
        public Nullable<decimal> Price { get; set; }
        public string Image { get; set; }
    }
}