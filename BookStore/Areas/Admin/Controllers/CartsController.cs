using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using BookStore.Areas.Admin.Models;
using BookStore.Common;
using BookStore.Models;

namespace BookStore.Areas.Admin.Controllers
{
    [RouteArea("admin", AreaPrefix = "quan-tri-vien")]
    [RoutePrefix("quan-li-dat-hang")]
    public class CartsController : BasicController
    {
        private BookStoreEntities db = new BookStoreEntities();

        // GET: Admin/Carts
        [CheckRole(RoleID = "EDIT")]
        [Route("danh-sach-don-dat-hang",Order =0)]
        [Route("", Order = 1)]
        public ActionResult Index()
        {
            string search = "Search_Cart N'" + "','" + "','" + "','" + "'";
            var carts = db.Database.SqlQuery<CartJoinUser>(search);
            return View(carts.ToList());
        }

        [HttpPost]
        [CheckRole(RoleID = "EDIT")]
        [Route("danh-sach-don-dat-hang", Order = 0)]
        [Route("", Order = 1)]
        public ActionResult Index(string name_admin="", string status="", string fromDate="", string toDate="")
        {
            string search = "Search_Cart N'" + name_admin + "','" + status + "','" + fromDate + "','" + toDate + "'";
            var carts = db.Database.SqlQuery<CartJoinUser>(search);
            return View(carts.ToList());
        }

        [CheckRole(RoleID = "EDIT")]
        [Route("chi-tiet-don-hang-{id:long?}")]
        public ActionResult Details(long? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Cart cart = db.Carts.Find(id);
            if (cart == null)
            {
                return HttpNotFound();
            }

            var getUserCart = db.Database.SqlQuery<UserCart>("exec GetUserCart_ByCartID " + id.ToString());

            var list = new List<CartItem>();
            if (getUserCart.ToList().Count > 0)
            {
                list = new List<CartItem>();
                foreach (var item in getUserCart)
                {
                    list.Add(new CartItem
                    {
                        Product = db.Products.Find(item.ProductID),
                        Quantity = (int)item.Quantity,
                        OrderID = (int)id
                    });
                }
            }

            ViewBag.CartDetail = list;
            ViewBag.CustomerName = db.Users.Find(cart.CustomerID).Name;
            return View(cart);
        }

        [CheckRole(RoleID = "EDIT")]
        [Route("xoa-nhom-{id:long}")]
        public ActionResult DeleteConfirmed(long id)
        {
            Cart cart = db.Carts.Find(id);
            db.Carts.Remove(cart);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
