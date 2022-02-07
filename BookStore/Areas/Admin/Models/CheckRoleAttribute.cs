using BookStore.Common;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace BookStore.Areas.Admin.Models
{
    public class CheckRoleAttribute:AuthorizeAttribute
    {
        public string RoleID { set; get; }
        protected override bool AuthorizeCore(HttpContextBase httpContext)
        {
            //var session = (UserLogin)HttpContext.Current.Session[CommonConstant.USER_SESSION];
            var session = (UserLogin)HttpContext.Current.Session[CommonConstant.ADMIN_SESSION];
            if (session == null)
            {
                return false;
            }

            List<string> privilegeLevels = this.GetCredentialByLoggedInUser(session.UserName); // Call another method to get rights of the user from DB

            if (privilegeLevels.Contains(this.RoleID) || session.Group == CommonConstant.ADMIN_GROUP)
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        protected override void HandleUnauthorizedRequest(AuthorizationContext filterContext)
        {
            if (HttpContext.Current.Session[CommonConstant.ADMIN_SESSION] == null)
            //if (HttpContext.Current.Session[CommonConstant.USER_SESSION] == null)
            {
                filterContext.Result = new RedirectToRouteResult(
                    new RouteValueDictionary(new { controller = "Login", action = "Index" })
                );
            }
            else
            {
                filterContext.Result = new ViewResult
                {
                    ViewName = "~/Areas/Admin/Views/Shared/_401.cshtml"
                };
            }
        }
        private List<string> GetCredentialByLoggedInUser(string userName)
        {
            return (List<string>)HttpContext.Current.Session[CommonConstant.MAPPING_ROLES];
        }
    }
}