using BookStore.Models;
using BookStore.Common;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Data.Entity;

namespace BookStore.Controllers
{
    public class UserSessionController : Controller
    {
        // GET: UserSession
        BookStoreEntities db = new BookStoreEntities();
        public static string ReturnUrl { get; set; }

        public ActionResult Register()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Register(RegisterInfo model)
        {
            if (ModelState.IsValid)
            {
                var checkUser = db.Users.Count(x => x.UserName == model.UserName) > 0;
                var checkEmail = db.Users.Count(x => x.Email == model.Email) > 0;
                if (checkUser)
                {
                    ModelState.AddModelError("", "Tên đăng nhập đã tồn tại");
                }
                else if (checkEmail)
                {
                    ModelState.AddModelError("", "Email đã tồn tại");
                }
                else
                {
                    try
                    {
                        var newUser = new User();
                        newUser.UserName = model.UserName;
                        newUser.Email = model.Email;
                        newUser.Password = Encryptor.MD5Hash(model.Password);
                        newUser.Name = model.Name;
                        newUser.CreatedDate = DateTime.Now;
                        newUser.Phone = model.Phone;
                        newUser.Address = model.Address;
                        newUser.Status = true;
                        db.Users.Add(newUser);
                        db.SaveChanges();
                        ViewBag.Success = true;
                        ModelState.Clear();
                        //MvcCaptcha.ResetCaptcha("ExampleCaptcha");
                        LoginInfo login = new LoginInfo();
                        return RedirectToAction("Login");
                    }
                    catch
                    {
                        ViewBag.Success = false;
                        ModelState.AddModelError("", "Đăng kí không thành công");
                    }
                }
            }

            return View(model);
        }

        public ActionResult Login()
        {
            //if (ReturnUrl== "/")
            //    ReturnUrl = Request.UrlReferrer.ToString();
            return View();
        }

        [HttpPost]
        public ActionResult Login(LoginInfo model, string RememberMe)
        {
            if (ModelState.IsValid)
            {
                if (RememberMe == "1")
                    Session.Timeout = 1440;
                //Truyền thông tin nhập từ web vài đây
                var result = model.LoginUser();
                if (result == 1)
                {
                    //Lấy ra mã id của username 
                    var user = db.Users.SingleOrDefault(x => x.UserName == model.EMailorUserName || x.Email == model.EMailorUserName);
                    //Tạo một phiên sử dụng cho user 
                    var userSession = new UserLogin();
                    userSession.UserName = user.UserName;
                    userSession.UserID = user.ID;

                    //When overridden in a derived class, adds an item to the session-state collection
                    //Thêm phiên hoạt động 
                    Session.Add(CommonConstant.USER_SESSION, userSession);

                    //Lay thong tin cart
                    int cartIndex;
                    var getUserCart = db.Database.SqlQuery<UserCart>("exec GET_USERCART " + user.ID.ToString() + ",1");
                    try
                    {
                        cartIndex = (int)getUserCart.ToList()[0].OrderID;
                    }
                    catch
                    {
                        cartIndex = -1;
                    }

                    var list = (List<CartItem>)null;

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
                    OrdersController.StatusInitial = true;

                    try
                    {
                        var url = ReturnUrl;
                        ReturnUrl = "/";
                        return Redirect(url);
                    }
                    catch
                    {
                        return Redirect("/");
                    }
                }
                else if (result == 0)
                {
                    ModelState.AddModelError("", "Người dùng/ Email không tồn tại");
                }
                else if (result == -1)
                {
                    ModelState.AddModelError("", "Người dùng đã bị khóa");
                }
                else
                {
                    ModelState.AddModelError("", "Đăng nhập thất bại");
                }
            }

            return View(model);
        }

        public ActionResult Logout()
        {
            //try
            //{
            //    List<CartItem> list = (List<CartItem>)Session[CommonConstant.CartSession];
            //    UserLogin user = (UserLogin)Session[CommonConstant.USER_SESSION];
            //    long id;

            //    if (list[0].OrderID == -1)
            //    {
            //        var order = new Cart();
            //        order.CreatedDate = DateTime.Now;
            //        order.CustomerID = user.UserID;
            //        order.Status = true;
            //        db.Carts.Add(order);
            //        db.SaveChanges();
            //        id = order.ID;
            //    }
            //    else
            //    {
            //        id = list[0].OrderID;
            //    }

            //    foreach (var item in list)
            //    {
            //        var orderdetail = new CartDetail();
            //        orderdetail.ProductID = item.Product.ID;
            //        orderdetail.OrderID = id;
            //        orderdetail.Price = item.Product.Price;
            //        orderdetail.Quantity = item.Quantity;

            //        var test = db.CartDetails.Where(x => x.ProductID == item.Product.ID && x.OrderID == id);
            //        if (test.Any())
            //        {
            //            db.Entry(orderdetail).State = EntityState.Modified;
            //            db.SaveChanges();
            //        }
            //        else
            //        {
            //            db.CartDetails.Add(orderdetail);
            //            db.SaveChanges();
            //        }
            //    }
            //}
            //catch { }

            Session[Common.CommonConstant.USER_SESSION] = null;
            Session[Common.CommonConstant.CartSession] = null;
            Session.Timeout = 25;
            OrdersController.StatusInitial = false;
            return Redirect("/");
        }
    }
}