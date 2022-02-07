using BookStore.Common;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BookStore.Models
{
    [Serializable]
    public class CartItem
    {
        BookStoreEntities db = new BookStoreEntities();

        public Product Product { get; set; }
        public int Quantity { get; set; }
        public int OrderID { set; get; }
    }
}