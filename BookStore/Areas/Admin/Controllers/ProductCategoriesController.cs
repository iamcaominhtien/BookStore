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
    public class ProductCategoriesController : Controller
    {
        private BookStoreEntities db = new BookStoreEntities();

        // GET: Admin/ProductCategories
        [CheckRole(RoleID = "VIEW")]
        public ActionResult Index()
        {
            return View(db.ProductCategories.OrderByDescending(p=>p.CreatedDate).ToList());
        }

        [CheckRole(RoleID = "VIEW")]
        [HttpPost]
        public ActionResult Index(string searchString, string status="")
        {
            string search = "SEARCH_PRODUCT_CATEGORY N'" + searchString + "','" + status + "'";
            var managerGroup = db.ProductCategories.SqlQuery(search);
            //return View(db.ProductCategories.OrderByDescending(p => p.CreatedDate).ToList());
            return View(managerGroup.ToList());
        }

        // GET: Admin/ProductCategories/Details/5
        [CheckRole(RoleID = "VIEW")]
        public ActionResult Details(long? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            ProductCategory productCategory = db.ProductCategories.Find(id);
            if (productCategory == null)
            {
                return HttpNotFound();
            }
            return View(productCategory);
        }

        // GET: Admin/ProductCategories/Create
        [CheckRole(RoleID = "CREATE")]
        public ActionResult Create()
        {
            ViewBag.Count = db.ProductCategories.Count() + 1;
            return View();
        }

        // POST: Admin/ProductCategories/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [CheckRole(RoleID = "CREATE")]
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "ID,Name,Image,MetaTitle,DisplayOrder,CreatedDate,CreatedBy,Status")] ProductCategory productCategory)
        {
            var img = Request.Files["Image"];
            string postedFileName = System.IO.Path.GetFileName(img.FileName);
            var path = Server.MapPath("/Images/" + postedFileName);
            img.SaveAs(path);
            
            if (ModelState.IsValid)
            {
                productCategory.Image = postedFileName;
                productCategory.CreatedDate = DateTime.Now;
                productCategory.MetaTitle = ProductFunc.CreateMetatitle(productCategory.Name);
                db.ProductCategories.Add(productCategory);
                db.SaveChanges();
                return RedirectToAction("Create");
            }

            return View(productCategory);
        }

        // GET: Admin/ProductCategories/Edit/5
        [CheckRole(RoleID = "EDIT")]
        public ActionResult Edit(long? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            ProductCategory productCategory = db.ProductCategories.Find(id);
            if (productCategory == null)
            {
                return HttpNotFound();
            }
            return View(productCategory);
        }

        // POST: Admin/ProductCategories/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [CheckRole(RoleID = "EDIT")]
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "ID,Name,Image,MetaTitle,DisplayOrder,CreatedDate,CreatedBy,Status")] ProductCategory productCategory)
        {
            var img = Request.Files["Image"];
            try
            {
                string postedFileName = System.IO.Path.GetFileName(img.FileName);
                var path = Server.MapPath("/Images/" + postedFileName);
                img.SaveAs(path);
                productCategory.Image = postedFileName;
            }
            catch
            {
                productCategory.Image = db.Products.Find(productCategory.ID).Image;
            }
            if (ModelState.IsValid)
            {
                productCategory.MetaTitle = ProductFunc.CreateMetatitle(productCategory.Name);
                db.Entry(productCategory).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(productCategory);
        }

        // GET: Admin/ProductCategories/Delete/5
        [CheckRole(RoleID = "DELETE")]
        public ActionResult Delete(long? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            ProductCategory productCategory = db.ProductCategories.Find(id);
            if (productCategory == null)
            {
                return HttpNotFound();
            }
            return View(productCategory);
        }

        // POST: Admin/ProductCategories/Delete/5
        [CheckRole(RoleID = "DELETE")]
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(long id)
        {
            ProductCategory productCategory = db.ProductCategories.Find(id);
            db.ProductCategories.Remove(productCategory);
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
