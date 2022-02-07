using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using System.Web.Script.Serialization;
using BookStore.Common;
using BookStore.Models;

namespace BookStore.Controllers
{
    public class OrdersController : CheckSessionController
    {
        private BookStoreEntities db = new BookStoreEntities();
        static bool statusInitial = false;

        public static bool StatusInitial { get => statusInitial; set => statusInitial = value; }

        //GET: Orders
        public void InitialUserCart()
        {
            if (!StatusInitial)
            {
                int cartIndex;
                var user = (UserLogin)Session[CommonConstant.USER_SESSION];

                var getUserCart = db.Database.SqlQuery<UserCart>("exec GET_USERCART " + user.UserID.ToString() + ",1");

                //var getUserCart = from a in db.Carts
                //                  join b in db.CartDetails
                //                  on a.ID equals b.OrderID
                //                  where (a.CustomerID == user.UserID && a.Status == true)
                //                  select new
                //                  {
                //                      OrderID = b.OrderID,
                //                      ProductID = b.ProductID,
                //                      Quantity = b.Quantity
                //                  };
                try
                {
                    cartIndex = (int)getUserCart.ToList()[0].OrderID;
                }
                catch 
                {
                    cartIndex = -1;
                }

                var list = (List<CartItem>)null;

                //if (getUserCart.ToList().Count>0)
                //{
                //    list = new List<CartItem>();
                //    foreach (var item in getUserCart)
                //    {
                //        list.Add(new CartItem
                //        {
                //            Product = db.Products.Find(item.ProductID),
                //            Quantity = (int)item.Quantity,
                //            OrderID = cartIndex
                //        });
                //    }
                //    Session[CommonConstant.CartSession] = list;
                //}
                try
                {
                    if (getUserCart.ToList().Count > 0)
                    {
                        list = new List<CartItem>();
                        foreach (var item in getUserCart)
                        {
                            list.Add(new CartItem
                            {
                                Product = db.Products.Find(item.ProductID),
                                Quantity = (int)item.Quantity,
                                OrderID = cartIndex
                            });
                        }
                        Session[CommonConstant.CartSession] = list;
                    }
                }
                catch { }

                StatusInitial = true;
            }
        }

        public ActionResult Index()
        {
            List<CartItem> list = (List<CartItem>)Session[CommonConstant.CartSession];
            if (list==null)
            {
                InitialUserCart();
                list = (List<CartItem>)Session[CommonConstant.CartSession];
            }

            return View(list);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        public ActionResult AddItem(long productID, int quantity)
        {
            List<CartItem> list = (List<CartItem>)Session[CommonConstant.CartSession];
            if (list==null)
            {
                InitialUserCart();
                list = (List<CartItem>)Session[CommonConstant.CartSession];
            }
            var cart = Session[CommonConstant.CartSession];
            var product = db.Products.Find(productID);
            var cartFunc = new CartFunc();

            //Nếu productID đã có trong giỏ hàng rồi, cộng dồn quantity, ngược lại tạo session 
            if (cart!=null)
            {
                //Nếu có productID này rồi 
                if (list.Exists(x => x.Product.ID == productID))
                {
                    foreach (var item in list)
                    {
                        if (item.Product.ID == productID)
                        {
                            item.Quantity += quantity;
                            //Cap nhat CSDL
                            cartFunc.UpdateCartDetail(item.Product.ID,item.OrderID,item.Quantity);
                            break;
                        }
                    }
                }
                else //Nếu chưa có thì add mới vào 
                {
                    //Tạo mới đối tượng cart item
                    var item = new CartItem();
                    item.Product = product;
                    item.Quantity = quantity;
                    item.OrderID = list[0].OrderID;
                    list.Add(item);

                    //Them vao CSDL
                    var cartdetail = new CartDetail();
                    cartdetail.OrderID = item.OrderID;
                    cartdetail.ProductID = item.Product.ID;
                    cartdetail.Quantity = item.Quantity;
                    cartFunc.InsertCartDetail(cartdetail);
                }
            }
            else //Giỏ hàng trống, nghĩa là chưa có thông tin đặt hàng 
            {
                //Thêm một cart vào CSDL
                UserLogin user = (UserLogin)Session[CommonConstant.USER_SESSION];
                int id = cartFunc.InsertCart(user.UserID);

                //Tạo mới đối tượng cart item
                list = new List<CartItem>();
                var item = new CartItem();
                item.Product = product;
                item.Quantity = quantity;
                item.OrderID = id;
                list.Add(item);

                //Thêm một dòng vào bảng CartDetail
                //Them vao CSDL
                var cartdetail = new CartDetail();
                cartdetail.OrderID = id;
                cartdetail.ProductID = item.Product.ID;
                cartdetail.Quantity = item.Quantity;
                cartFunc.InsertCartDetail(cartdetail);

                //Gán vào session 
                Session[CommonConstant.CartSession] = list;
            }

            return RedirectToAction("Index");
        }

        public JsonResult Update(string cartModel) //trùng tên với dòng số 24 bên cartController.js 
        {
            var jsonCart = new JavaScriptSerializer().Deserialize<List<CartItem>>(cartModel);
            var sessionCart = (List<CartItem>)Session[CommonConstant.CartSession];
            var cartFunc = new CartFunc();
            List<string> res = new List<string>();
            int sum = 0;

            foreach (var item in sessionCart)
            {
                var jsonItem = jsonCart.SingleOrDefault(x => x.Product.ID == item.Product.ID);
                if (jsonItem != null)
                {
                    item.Quantity = jsonItem.Quantity;
                    cartFunc.UpdateCartDetail(item.Product.ID,item.OrderID, jsonItem.Quantity);
                    res.Add((jsonItem.Quantity * item.Product.Price.GetValueOrDefault()).ToString("N0"));
                    sum = sum + (jsonItem.Quantity * ((int)item.Product.Price.GetValueOrDefault()));
                }
            }

            Session[CommonConstant.CartSession] = sessionCart;
            res.Add(sum.ToString("N0"));

            return Json(new
            {
                data = res,
                status = true
            });
        }

        public JsonResult DeleteItem(long id)
        {
            var sessionCart = (List<CartItem>)Session[CommonConstant.CartSession];
            var cartFunc = new CartFunc();
            UserLogin user = (UserLogin)Session[CommonConstant.USER_SESSION];
            int sum = 0;

            //Xóa một dòng bên CSDL
            var cartSessionDel = sessionCart.SingleOrDefault(x => x.Product.ID == id);
            cartFunc.DeleteCartDetail(cartSessionDel.OrderID,cartSessionDel.Product.ID);

            var orderID = sessionCart[0].OrderID;
            sessionCart.RemoveAll(x => x.Product.ID == id);
            
            Session[CommonConstant.CartSession] = sessionCart;

            if (sessionCart.Count==0)
            {
                var cart = db.Carts.Find(orderID);
                db.Carts.Remove(cart);
                db.SaveChanges();
                statusInitial = false;
                Session[CommonConstant.CartSession] = null;
            }
            else
            {
                foreach(var item in sessionCart)
                {
                    sum += (((int)item.Product.Price.GetValueOrDefault()) * item.Quantity);
                }
            }

            return Json(new
            {
                data=sum.ToString("N0"),
                status = true
            });
        }

        public ActionResult CheckOut()
        {
            var user = (UserLogin)Session[CommonConstant.USER_SESSION];
            var cartdetail = (List<CartItem>)Session[CommonConstant.CartSession];
            ViewBag.CustomerInfo = db.Users.Find(user.UserID);
            return View(cartdetail);
        }

        public ActionResult Payment()
        {
            var cartdetail = (List<CartItem>)Session[CommonConstant.CartSession];
            var cart = db.Carts.Find(cartdetail[0].OrderID);
            string row = "<tr><td>{Name}</td><td>{Quantity}</td><td>{Price}đ</td></tr>";
            string cart_detail = "";
            int totalPrice = 0;

            //Cập nhật viewcout (lượt mua), cho sản phẩm
            foreach (var item in cartdetail)
            {
                var product = db.Products.Find(item.Product.ID);
                int temp = product.Quantity - item.Quantity;
                product.Quantity = temp;
                if (temp==0)
                {
                    product.Status = false;
                }
                product.ViewCout += item.Quantity;
                db.Entry(product).State = EntityState.Modified;
                db.SaveChanges();

                cart_detail = cart_detail + row.Replace("{Name}", product.Name).Replace("{Quantity}", item.Quantity.ToString()).Replace("{Price}", product.Price.GetValueOrDefault(0).ToString("N0"));
                totalPrice = totalPrice + ((int)product.Price * item.Quantity);
            }

            //Send mail
            string content = System.IO.File.ReadAllText(Server.MapPath("~/Assets/Client/template/cartEmail.html"));

            content = content.Replace("{{CartDetail}}", cart_detail);
            content = content.Replace("{{TotalPrice}}", totalPrice.ToString("N0"));
            var userSession = (UserLogin)Session[CommonConstant.USER_SESSION];
            var sendmail = new MailInfo();
            sendmail.To = db.Users.SingleOrDefault(s => s.UserName == userSession.UserName).Email;
            sendmail.SendMail(content);

            cart.Status = false;
            db.Entry(cart).State = EntityState.Modified;
            db.SaveChanges();
            Session[CommonConstant.CartSession] = null;
            return RedirectToAction("CheckOut");
        }

        // GET: Orders/Details/5
        public ActionResult Details(long? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Cart order = db.Carts.Find(id);
            if (order == null)
            {
                return HttpNotFound();
            }
            return View(order);
        }

        // GET: Orders/Create
        public ActionResult Create()
        {
            ViewBag.CustomerID = new SelectList(db.Users, "ID", "UserName");
            return View();
        }

        // POST: Orders/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "ID,CreatedDate,CustomerID,Status")] Cart order)
        {
            if (ModelState.IsValid)
            {
                db.Carts.Add(order);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.CustomerID = new SelectList(db.Users, "ID", "UserName", order.CustomerID);
            return View(order);
        }

        // GET: Orders/Edit/5
        public ActionResult Edit(long? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Cart order = db.Carts.Find(id);
            if (order == null)
            {
                return HttpNotFound();
            }
            ViewBag.CustomerID = new SelectList(db.Users, "ID", "UserName", order.CustomerID);
            return View(order);
        }

        // POST: Orders/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "ID,CreatedDate,CustomerID,Status")] Cart order)
        {
            if (ModelState.IsValid)
            {
                db.Entry(order).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.CustomerID = new SelectList(db.Users, "ID", "UserName", order.CustomerID);
            return View(order);
        }

        // GET: Orders/Delete/5
        public ActionResult Delete(long? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Cart order = db.Carts.Find(id);
            if (order == null)
            {
                return HttpNotFound();
            }
            return View(order);
        }

        // POST: Orders/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(long id)
        {
            Cart order = db.Carts.Find(id);
            db.Carts.Remove(order);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

    }
}
