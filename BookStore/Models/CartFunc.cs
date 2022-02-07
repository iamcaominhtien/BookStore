using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;
using BookStore.Common;

namespace BookStore.Models
{
    public class CartFunc
    {
        BookStoreEntities db = new BookStoreEntities();

        public int InsertCart(long CustomerID)
        {
            try
            {
                var cart = new Cart();
                cart.CreatedDate = DateTime.Now;
                cart.CustomerID = CustomerID;
                cart.Status = true;
                db.Carts.Add(cart);
                db.SaveChanges();
                return (int)cart.ID;
            }
            catch { }
            return -1;
        }

        public bool DeleteCart(long id)
        {
            try
            {
                Cart order = db.Carts.Find(id);
                db.Carts.Remove(order);
                db.SaveChanges();
                return true;
            }
            catch { }

            return false;
        }

        public bool InsertCartDetail(CartDetail s)
        {
            try
            {
                db.CartDetails.Add(s);
                db.SaveChanges();
                return true;
            }
            catch { }
            return false;
        }

        public bool UpdateCartDetail(long productID, long orderID, int quantity)
        {
            try
            {
                //var cartdetail = db.CartDetails.SingleOrDefault(x => x.ProductID == productID && x.OrderID == orderID);
                var cartdetail = db.CartDetails.SqlQuery("exec GET_CARTDETAIL " + productID.ToString() + "," + orderID.ToString()).ToList();
                cartdetail[0].Quantity = quantity;
                db.Entry(cartdetail[0]).State = EntityState.Modified;
                //cartdetail.Quantity = quantity;
                //db.Entry(cartdetail).State = EntityState.Modified;
                db.SaveChanges();
                return true;
            }
            catch { }
            return false;
        }

        public bool DeleteCartDetail(long orderID, long productID)
        {
            var cartDetail = db.CartDetails.SingleOrDefault(x => x.OrderID == orderID && x.ProductID == productID);
            db.CartDetails.Remove(cartDetail);
            db.SaveChanges();
            return true;
        }
    }
}