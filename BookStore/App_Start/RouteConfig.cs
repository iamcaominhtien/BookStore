using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace BookStore
{
    public class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.MapMvcAttributeRoutes();
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

            //routes.MapRoute(
            //    name: "Product Category",
            //    url: "san-pham/{metatitle}-{cateid}",
            //    defaults: new { controller = "ListProductByCategory", action = "Index", id = UrlParameter.Optional }
            //);

            //routes.MapRoute(
            //    name: "Chi tiết sản phẩm",
            //    url: "chi-tiet/{metatitle}-{cateid}",
            //    defaults: new { controller = "ManageProduct", action = "DetailProduct", id = UrlParameter.Optional }
            //);

            routes.MapRoute(
                name: "Đăng ký",
                url: "dang-ky",
                defaults: new { controller = "UserSession", action = "Register", id = UrlParameter.Optional }
            );

            routes.MapRoute(
                name: "Đăng nhập",
                url: "dang-nhap",
                defaults: new { controller = "UserSession", action = "Login", id = UrlParameter.Optional }
            );

            routes.MapRoute(
                name: "Home",
                url: "trang-chu",
                defaults: new { controller = "Home", action = "Index", id = UrlParameter.Optional }
            );

            //routes.MapRoute(
            //    name: "Shopping Cart",
            //    url: "shopping-cart",
            //    defaults: new { controller = "Orders", action = "Index", id = UrlParameter.Optional }
            //);

            //routes.MapRoute(
            //    name: "Add Cart",
            //    url: "them-gio-hang",
            //    defaults: new { controller = "Orders", action = "AddItem", id = UrlParameter.Optional }
            //);

            //routes.MapRoute(
            //    name: "Check Out",
            //    url: "checkout",
            //    defaults: new { controller = "Orders", action = "CheckOut", id = UrlParameter.Optional }
            //);

            //routes.MapRoute(
            //    name: "Search",
            //    url: "tim-kiem",
            //    defaults: new { controller = "ManageProduct", action = "Search", id = UrlParameter.Optional }
            //);

            routes.MapRoute(
                name: "Liên hệ",
                url: "contact",
                defaults: new { controller = "Home", action = "Contact", id = UrlParameter.Optional }
            );

            //routes.MapRoute(
            //    name: "Quan lí sản phẩm",
            //    url: "quan-li-san-phampnbooks/{action}/{id}",
            //    defaults: new { controller = "Admin/Products", action = "/Admin/Products/Index", id = UrlParameter.Optional},
            //    namespaces: new[] { "BookStore.Areas.Controllers" }
            //);

            //routes.MapRoute(
            //    name: "Quan lí danh mục sản phẩm",
            //    url: "quan-li-danh-muc-san-phampnbooks/{action}/{id}",
            //    defaults: new { controller = "ProductCategories", action = "Index", id = UrlParameter.Optional}
            //);

            //routes.MapRoute(
            //    name: "My Account",
            //    url: "myAccount",
            //    defaults: new { controller = "UserLog", action = "Index", id = UrlParameter.Optional }
            //);

            //routes.MapRoute(
            //    name: "Lịch sử mua hàng",
            //    url: "myAccount/lich-su-mua-hang",
            //    defaults: new { controller = "UserLog", action = "History_Order", id = UrlParameter.Optional }
            //);

            routes.MapRoute(
                name: "Default",
                url: "{controller}/{action}/{id}",
                defaults: new { controller = "Home", action = "Index", id = UrlParameter.Optional }
            );
        }
    }
}
