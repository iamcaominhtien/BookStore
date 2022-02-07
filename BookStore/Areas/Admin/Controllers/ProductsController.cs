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

namespace BookStore.Areas.Admin.Controllers
{
    [RouteArea("admin")]
    [RoutePrefix("quan-li-san-pham")]
    [Route("{action=index}")]
    public class ProductsController : Controller
    {
        private BookStoreEntities db = new BookStoreEntities();

        // GET: Admin/Products
        [CheckRole(RoleID = "VIEW")]
        public ActionResult Index()
        {
            ViewBag.CategoryID = new SelectList(db.ProductCategories, "ID", "Name");
            //var products = db.Products.OrderByDescending(p=>p.CreatedDate).Include(p => p.ProductCategory);
            //return View(products.ToList());
            string search = "SEARCH_PRODUCT_MULTIPLE N'" + "" + "','" + "" + "','" + "" + "','" + "" + "','" + "" + "'";
            var products = db.Products.SqlQuery(search);
            //products = (System.Data.Entity.Infrastructure.DbSqlQuery<Product>)db.Products.Where(s => s.ID == s.ID);
            return View(products.ToList());
        }

        [CheckRole(RoleID = "VIEW")]
        [HttpPost]
        public ActionResult Index(string searchString="", string status="", string minPrice="", string maxPrice="", string CategoryID="")
        {
            string ret = "";
            if (Request.UrlReferrer != null)
            {
                ret = Request.UrlReferrer.ToString();
            }
            ViewBag.CategoryID = new SelectList(db.ProductCategories, "ID", "Name");
            string search = "SEARCH_PRODUCT_MULTIPLE N'" + searchString + "','" + status + "','" + minPrice + "','" + maxPrice + "','" + CategoryID + "'";
            var products = db.Products.SqlQuery(search);
            return View(products.ToList());
        }

        // GET: Admin/Products/Details/5
        [CheckRole(RoleID = "VIEW")]
        public ActionResult Details(long? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Product product = db.Products.Find(id);
            if (product == null)
            {
                return HttpNotFound();
            }
            return View(product);
        }

        // GET: Admin/Products/Create
        [CheckRole(RoleID = "CREATE")]
        public ActionResult Create()
        {
            ViewBag.CategoryID = new SelectList(db.ProductCategories, "ID", "Name");
            return View();
        }

        // POST: Admin/Products/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [CheckRole(RoleID = "CREATE")]
        [HttpPost, ValidateInput(false)]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "ID,Name,MetaTitle,Description,Image,MoreImages,Authors,Price,PromotionPrice,Quantity,CategoryID,Detail,CreatedDate,Status,TopHot,ViewCout")] Product product)
        {
            var img = Request.Files["Image"];
            string postedFileName = System.IO.Path.GetFileName(img.FileName);
            var path = Server.MapPath("/Images/" + postedFileName);
            img.SaveAs(path);
            if (ModelState.IsValid)
            {
                product.Image = postedFileName;
                product.CreatedDate = DateTime.Now;
                product.MetaTitle = ProductFunc.CreateMetatitle(product.Name);
                product.ViewCout = 0;
                if (product.PromotionPrice < 0)
                    product.PromotionPrice = 0;
                if (product.Quantity == 0)
                    product.Status = false;
                db.Products.Add(product);
                db.SaveChanges();
                return RedirectToAction("Create");
            }

            ViewBag.CategoryID = new SelectList(db.ProductCategories, "ID", "Name", product.CategoryID);
            return View(product);
        }

        // GET: Admin/Products/Edit/5
        [CheckRole(RoleID = "EDIT")]
        public ActionResult Edit(long? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Product product = db.Products.Find(id);
            if (product == null)
            {
                return HttpNotFound();
            }
            ViewBag.CategoryID = new SelectList(db.ProductCategories, "ID", "Name", product.CategoryID);
            return View(product);
        }

        // POST: Admin/Products/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [CheckRole(RoleID = "EDIT")]
        [HttpPost, ValidateInput(false)]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "ID,Name,MetaTitle,Description,Image,MoreImages,Authors,Price,PromotionPrice,Quantity,CategoryID,Detail,CreatedDate,Status,TopHot,ViewCout")] Product product)
        {
            var img = Request.Files["Image"];
            try
            {
                string postedFileName = System.IO.Path.GetFileName(img.FileName);
                var path = Server.MapPath("/Images/" + postedFileName);
                img.SaveAs(path);
                product.Image = postedFileName;
            }
            catch
            {
                product.Image = db.Products.Find(product.ID).Image;
            }

            if (ModelState.IsValid)
            {
                product.MetaTitle = ProductFunc.CreateMetatitle(product.Name);
                var existingProduct = db.Products.Find(product.ID);
                db.Entry(existingProduct).CurrentValues.SetValues(product);
                //db.Entry(product).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.CategoryID = new SelectList(db.ProductCategories, "ID", "Name", product.CategoryID);
            return View(product);
        }

        // GET: Admin/Products/Delete/5
        [CheckRole(RoleID = "DELETE")]
        public ActionResult Delete(long? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Product product = db.Products.Find(id);
            if (product == null)
            {
                return HttpNotFound();
            }
            return View(product);
        }

        // POST: Admin/Products/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(long id)
        {
            Product product = db.Products.Find(id);
            db.Products.Remove(product);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
