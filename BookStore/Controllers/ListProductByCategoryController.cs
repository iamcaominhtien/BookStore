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
using PagedList;

namespace BookStore.Controllers
{
    public class ListProductByCategoryController : Controller
    {
        // GET: ListProductByCategory
        BookStoreEntities db = new BookStoreEntities();
        static long IdOfCate = 1;
        int pageSize = 6;

        public ActionResult Index(long cateid)
        {
            IdOfCate = cateid;
            var products = db.Products.SqlQuery("exec ListProductByCategory " + cateid.ToString());
            ViewBag.PromotionProduct = db.Products.SqlQuery("exec Get_PromotionProduct " + cateid.ToString()).ToList();
            ViewBag.nameProductCategory = db.ProductCategories.Find(cateid).Name;
            ViewBag.totalProductCategory = products.Count();
            ViewBag.ProductCategory = db.ProductCategories.SqlQuery("exec ListProductCategoryByStatus").ToList();
            ViewBag.LatestProducts = db.Products.SqlQuery("exec LatestProducts").ToList();
            ViewBag.TotalPage = Math.Ceiling(1.0*ViewBag.totalProductCategory / pageSize);
            //return View(products.ToPagedList(page, pageSize));
            return View(products.Take(pageSize).ToList());
        }

        [HttpPost]
        public ActionResult SortBy(int sortID)
        {
            var products = db.Products.Where(p => p.CategoryID == IdOfCate);
            if (sortID == 1)//Theo ngay
                products = products.OrderByDescending(p => p.CreatedDate);
            else if (sortID == 2)//Gia ban
                products = products.OrderByDescending(p => p.Price);
            else if (sortID == 3)
                products = products.OrderByDescending(p => p.ViewCout);

            ViewBag.nameProductCategory = db.ProductCategories.Find(IdOfCate).Name;
            ViewBag.totalProductCategory = products.Count();
            ViewBag.ProductCategory = db.ProductCategories.SqlQuery("exec ListProductCategoryByStatus").ToList();
            ViewBag.LatestProducts = db.Products.SqlQuery("exec LatestProducts").ToList();
            return View("Index", products.ToPagedList(1, 6));
        }

        public JsonResult ProductPage(int skip, int cateID)
        {
            List<string> lName = new List<string>();
            List<string> lID = new List<string>();
            List<string> lMetatitle = new List<string>();
            List<string> lImage = new List<string>();
            List<string> lPrice = new List<string>();
            var product = db.Products.SqlQuery("exec GET_LISTPRODUCT_CANPAGING " + cateID.ToString() + "," + ((skip-1) *pageSize).ToString() + "," + pageSize.ToString());

            foreach (var item in product)
            {
                lName.Add(item.Name);
                lID.Add(item.ID.ToString());
                lMetatitle.Add(item.MetaTitle);
                lImage.Add(item.Image);
                lPrice.Add(item.Price.GetValueOrDefault(0).ToString("N0"));
            }

            return Json(new
            {
                Name = lName,
                ID = lID,
                Metatitle = lMetatitle,
                Image = lImage,
                Price=lPrice
            });
        }
    }
}