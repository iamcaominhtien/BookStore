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
    [RouteArea("admin", AreaPrefix = "quan-tri-vien")]
    [RoutePrefix("quan-li-nhom-quan-tri")]
    public class ManagerGroupsController : BasicController
    {
        private BookStoreEntities db = new BookStoreEntities();
        private static string returnUrl = "Index";

        // GET: Admin/ManagerGroups
        [CheckRole(RoleID = "VIEW")]
        [Route("danh-sach-quan-tri-vien")]
        public ActionResult Index()
        {
            return View(db.ManagerGroups.ToList());
        }

        [CheckRole(RoleID = "VIEW")]
        [HttpPost]
        [Route("danh-sach-quan-tri-vien")]
        public ActionResult Index(string searchString, string status, string fromDate, string toDate)
        {
            string search = "Search_ManagerGroup'" + searchString + "','" + status + "','" + fromDate + "','" + toDate + "'";
            var managerGroup = db.ManagerGroups.SqlQuery(search);
            return View(managerGroup.ToList());
        }

        // GET: Admin/ManagerGroups/Create
        [CheckRole(RoleID = "CREATE")]
        [Route("them-nhom-moi")]
        public ActionResult Create()
        {
            return View();
        }

        // POST: Admin/ManagerGroups/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [CheckRole(RoleID = "CREATE")]
        [HttpPost]
        [ValidateAntiForgeryToken]
        [Route("them-nhom-moi")]
        public ActionResult Create([Bind(Include = "ID,Name,Note,CreatedDate,Status")] ManagerGroup managerGroup)
        {
            if (ModelState.IsValid)
            {
                managerGroup.CreatedDate = DateTime.Now;
                db.ManagerGroups.Add(managerGroup);
                db.SaveChanges();
                return RedirectToAction("Create");
            }

            return View(managerGroup);
        }

        // GET: Admin/ManagerGroups/Edit/5
        [CheckRole(RoleID = "EDIT")]
        [Route("cap-nhat-thong-tin-nhom")]
        public ActionResult Edit(long? id)
        {
            returnUrl = Request.UrlReferrer.ToString();
            ViewBag.returnUrl = returnUrl;
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            ManagerGroup managerGroup = db.ManagerGroups.Find(id);
            if (managerGroup == null)
            {
                return HttpNotFound();
            }
            return View(managerGroup);
        }

        // POST: Admin/ManagerGroups/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [CheckRole(RoleID = "EDIT")]
        [HttpPost]
        [ValidateAntiForgeryToken]
        [Route("cap-nhat-thong-tin-nhom")]
        public ActionResult Edit([Bind(Include = "ID,Name,Note,CreatedDate,Status")] ManagerGroup managerGroup)
        {
            if (ModelState.IsValid)
            {
                db.Entry(managerGroup).State = EntityState.Modified;
                db.SaveChanges();
                return Redirect(returnUrl);
            }
            return View(managerGroup);
        }

        // GET: Admin/ManagerGroups/Delete/5
        [CheckRole(RoleID = "DELETE")]
        [Route("xoa-nhom-quan-tri-{id:long?}")]
        public ActionResult Delete(long? id)
        {
            returnUrl = Request.UrlReferrer.ToString();
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            ManagerGroup managerGroup = db.ManagerGroups.Find(id);
            if (managerGroup == null)
            {
                return HttpNotFound();
            }
            return View(managerGroup);
        }

        // POST: Admin/ManagerGroups/Delete/5
        [CheckRole(RoleID = "DELETE")]
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        [Route("xoa-nhom-quan-tri-{id:long?}")]
        public ActionResult DeleteConfirmed(long id)
        {
            ManagerGroup managerGroup = db.ManagerGroups.Find(id);
            db.ManagerGroups.Remove(managerGroup);
            db.SaveChanges();
            return Redirect(returnUrl);
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
