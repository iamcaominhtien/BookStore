using BookStore.Areas.Admin.Models;
using BookStore.Common;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace BookStore.Areas.Admin.Controllers
{
    [RouteArea("admin")]
    public class LoginController : Controller
    {
        private BookStoreEntities db = new BookStoreEntities();

        // GET: Admin/Login
        [Route("dang-nhap")]
        public ActionResult Index()
        {
            return View();
        }

        [HttpPost]
        [Route("dang-nhap")]
        public ActionResult Index(LoginModel model)
        {
            if (ModelState.IsValid)
            {
                if (model.RememberMe==true)
                    Session.Timeout = 1440;
                var dao = new ManagerFunc();
                //Truyền thông tin nhập từ web vài đây
                var result = dao.Login(model.UserName, model.Password);
                if (result == 1)
                {
                    //Lấy ra mã id của username 
                    var user = dao.GetByName(model.UserName);
                    //Tạo một phiên sử dụng cho user 
                    var userSession = new UserLogin();
                    userSession.UserName = user.UserName;
                    userSession.UserID = user.ID;
                    userSession.Group = db.ManagerGroups.Find(user.GroupID).Name;
                    var listMappingRoles = dao.GetMappingRoles(user.UserName);
                    Session.Add(CommonConstant.MAPPING_ROLES, listMappingRoles);

                    //When overridden in a derived class, adds an item to the session-state collection
                    //Thêm phiên hoạt động 
                    //Session.Add(CommonConstant.USER_SESSION, userSession);
                    Session.Add(CommonConstant.ADMIN_SESSION, userSession);
                    return RedirectToAction("ManagerHome", "Managers");
                }
                else if (result == 0)
                {
                    ModelState.AddModelError("", "This Admin doesn't exit");
                }
                else if (result == -1)
                {
                    ModelState.AddModelError("", "This Admin is being locked");
                }
                else if (result==-2)
                {
                    ModelState.AddModelError("", "Login failed");
                }
                else
                {
                    ModelState.AddModelError("", "Liên hệ Admin để cấp quyền xem nội dung này");
                }
            }
            return View("Index");
        }

        [Route("dang-xuat")]
        public ActionResult Logout()
        {
            //Session[CommonConstant.USER_SESSION] = null;
            Session[CommonConstant.ADMIN_SESSION] = null;
            Session.Timeout = 25;
            return RedirectToAction("Index", "Login");
        }
    }
}