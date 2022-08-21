using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using BookStore.Common;
using BookStore.Models;

namespace BookStore.Controllers
{
    public class CartInfo
    {
        string name, image;
        decimal price;
        int quantity;

        public string Name { get => name; set => name = value; }
        public string Image { get => image; set => image = value; }
        public decimal Price { get => price; set => price = value; }
        public int Quantity { get => quantity; set => quantity = value; }
    }

    [RoutePrefix("thong-tin-nguoi-dung")]
    public class UserLogController : CheckSessionController
    {
        private BookStoreEntities db = new BookStoreEntities();
        public static string OldPass = "";
        // GET: UserLog

        [Route("")]
        [Route("trang-chu")]
        public ActionResult Index(int? updateSuccess=0)
        {
            var usersession = (UserLogin)Session[CommonConstant.USER_SESSION];
            var user = db.Users.Find(usersession.UserID);
            ViewBag.Name = user.Name;
            ViewBag.updateSuccess=updateSuccess;
            OldPass = user.Password;
            return View(db.Users.Find(usersession.UserID));
        }

        [HttpPost]
        [Route("")]
        [Route("trang-chu")]
        public ActionResult Index([Bind(Include = "ID,UserName,Password,Name,Address,Email,Phone,CreatedDate,Status")] User user)
        {
            ViewBag.updateSuccess = -1;
            ViewBag.Name = user.Name;
            if (ModelState.IsValid)
            {
                if (user.Password == null)
                    user.Password = OldPass;
                else user.Password = Encryptor.MD5Hash(user.Password);
                db.Entry(user).State = EntityState.Modified;
                db.SaveChanges();
                ViewBag.updateSuccess = 1;
                return View(user);
            }
            return View(user);
        }

        public ActionResult DeleteConfirmed(long id)
        {
            User user = db.Users.Find(id);
            db.Users.Remove(user);
            Session[CommonConstant.USER_SESSION] = null;
            Session[CommonConstant.CartSession] = null;
            Session.Timeout = 25;
            db.SaveChanges();
            return RedirectToAction("Index","Home");
        }

        [Route("lich-su-mua-hang")]
        public ActionResult History_Order()
        {
            var usersession = (UserLogin)Session[CommonConstant.USER_SESSION];
            var user = db.Users.Find(usersession.UserID);
            ViewBag.Name = user.Name;
            var his_order = db.Database.SqlQuery<UserCart>("exec GET_USERCART_CANPAGING " + user.ID.ToString() + ",0" + ",3");
            List<CartItem> list = new List<CartItem>();

            foreach(var item in his_order)
            {
                list.Add(new CartItem
                {
                    Product = db.Products.Find(item.ProductID),
                    Quantity = item.Quantity,
                    OrderID = (int)item.OrderID
                });
            }

            var all = db.Database.SqlQuery<UserCart>("exec GET_USERCART_ALL "+usersession.UserID.ToString()).ToList();
            ViewBag.CountProduct = all.Count().ToString("N0");
            ViewBag.TotalNumberProduct = all.Sum(s => s.Quantity).ToString("N0");
            ViewBag.TotalMoney = all.Sum(s => (s.Quantity * ((int)db.Products.Find(s.ProductID).Price.GetValueOrDefault(0)))).ToString("N0");
            return View(list);
        }

        public JsonResult GetUserCart(int skip, int pageSize=3)
        {
            List<string> lName = new List<string>();
            List<string> lPrice = new List<string>();
            List<string> lQuantity = new List<string>();
            List<string> lImage = new List<string>();
            List<string> lSumPrice = new List<string>();
            var usersession = (UserLogin)Session[CommonConstant.USER_SESSION];
            var user = db.Users.Find(usersession.UserID);
            ViewBag.Name = user.Name;
            var his_order = db.Database.SqlQuery<UserCart>("exec GET_USERCART_CANPAGING " + user.ID.ToString() + "," + (skip*pageSize).ToString() + "," + pageSize.ToString());

            foreach (var item in his_order)
            {
                var product = db.Products.Find(item.ProductID);
                lName.Add(product.Name);
                lPrice.Add(product.Price.Value.ToString("N0"));
                lQuantity.Add(item.Quantity.ToString());
                lImage.Add(product.Image);
                lSumPrice.Add((item.Quantity * product.Price.GetValueOrDefault(0)).ToString("N0"));
            }

            //return Json(new
            //{
            //    Name = lName,
            //    Price = lPrice,
            //    Quantity = lQuantity,
            //    Image = lImage,
            //    SumPrice=lSumPrice
            //},JsonRequestBehavior.AllowGet);
            return Json(new
            {
                Name = lName,
                Price = lPrice,
                Quantity = lQuantity,
                Image = lImage,
                SumPrice = lSumPrice
            });
        }
    }
}