using BookStore.Common;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace BookStore.Areas.Admin.Controllers
{
    public class BasicController : Controller
    {
        // GET: Admin/Basic
        // GET: Admin/Basic
        protected override void OnActionExecuting(ActionExecutingContext filterContext) //Note: private, not public
        {
            var sess = (UserLogin)Session[CommonConstant.ADMIN_SESSION];
            //var sess = (UserLogin)Session[CommonConstant.USER_SESSION];

            if (sess == null)
            {
                filterContext.Result = new RedirectToRouteResult(new
                    System.Web.Routing.RouteValueDictionary(new { controller = "Login", action = "Index", area = "Admin"}));
            }
            base.OnActionExecuting(filterContext);
        }

        protected void SetAlert(string message, string type)
        {
            TempData["AlertMessage"] = message;

            if (type == "success")
                TempData["AlertType"] = "alert-success";
            else if (type == "warning")
                TempData["AlertType"] = "alert-success";
            else if (type == "error")
                TempData["AlertType"] = "alert-success";
        }
    }
}