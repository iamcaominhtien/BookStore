using BookStore.Common;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace BookStore.Controllers
{
    public class CheckSessionController : Controller
    {
        // GET: CheckSession
        protected override void OnActionExecuting(ActionExecutingContext filterContext) //Note: private, not public
        {
            var sess = (UserLogin)Session[CommonConstant.USER_SESSION];

            if (sess == null)
            {
                UserSessionController.ReturnUrl = Request.RawUrl;
                //var temp2= Request.ServerVariables["SCRIPT_NAME"].ToString();
                filterContext.Result = new RedirectToRouteResult(new
                    System.Web.Routing.RouteValueDictionary(new { controller = "UserSession", action = "Login"}));
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