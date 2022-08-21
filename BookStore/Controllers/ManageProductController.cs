using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using BookStore.Common;
using PagedList;

namespace BookStore.Controllers
{
    [RoutePrefix("quan-li-sach")]
    public class ManageProductController : Controller
    {
        // GET: ManageProduct
        BookStoreEntities db = new BookStoreEntities();
        int pageSize = 8;

        [Route("chi-tiet-sach-{cateid}")]
        public ActionResult DetailProduct(int cateid)
        {
            var product = db.Products.SqlQuery("exec DetailProduct " + cateid.ToString()).ToList();
            //var product = db.Products.Find(cateid);
            ViewBag.Product = product;
            ViewBag.ProductCategory = db.ProductCategories.Find(product[0].CategoryID);
            ViewBag.RelatedProduct = db.Products.SqlQuery("exec RelatedProduct " + cateid.ToString()).ToList();
            return View(product[0]);
        }

        public JsonResult ListName(string term)
        {
            //var data = db.Products.Where(x => x.Name.Contains(term)).Select(x => x.Name).ToList();
            var data = db.Database.SqlQuery<string>("exec SEARCH_PRODUCT N'" + term + "'").ToList();
            return Json(new
            {
                data = data,
                status = true
            },JsonRequestBehavior.AllowGet);
        }

        [Route("tim-kiem-sach")]
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Search(string keyword="")
        {
            return RedirectToAction("SearchResult", "ManageProduct", new { keyword = keyword });
        }

        [Route("ket-qua-tim-kiem/{keyword}")]
        public ActionResult SearchResult(string keyword)
        {
            string searchstring = "exec SEARCH_PRODUCT_BY_KEY N'" + keyword + "','" + "','" + "'";
            //var products = db.Products.Where(x => x.Name.Contains(keyword)).ToList();
            var products = db.Products.SqlQuery(searchstring).ToList();
            ViewBag.KeyWord = keyword;
            ViewBag.totalProductCategory = products.Count();
            ViewBag.ProductCategory = db.ProductCategories.SqlQuery("exec ListProductCategoryByStatus").ToList();
            ViewBag.LatestProducts = db.Products.SqlQuery("exec LatestProducts").ToList();
            //return View(products.ToPagedList(page, pageSize));
            return View(products.Take(pageSize).ToList());
        }

        public JsonResult ProductPage(string keyword, int skip)
        {
            List<string> lName = new List<string>();
            List<string> lID = new List<string>();
            List<string> lMetatitle = new List<string>();
            List<string> lImage = new List<string>();
            List<string> lPrice = new List<string>();
            string searchstring = "SEARCH_PRODUCT_BY_KEY N'" + keyword + "','" +pageSize.ToString() + "','" + ((skip-1)*pageSize).ToString()+"'";
            //var products = db.Products.Where(x => x.Name.Contains(keyword)).ToList();
            var product = db.Products.SqlQuery(searchstring).ToList();

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
                Price = lPrice
            });
        }
    }
}