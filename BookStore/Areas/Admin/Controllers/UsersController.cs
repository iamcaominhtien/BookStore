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
    [RoutePrefix("quan-li-khach-hang")]
    public class UsersController : BasicController
    {
        private BookStoreEntities db = new BookStoreEntities();

        // GET: Admin/Users
        [CheckRole(RoleID = "VIEW")]
        [Route("danh-sach-khach-hang",Order=0)]
        [Route("", Order = 1)]
        public ActionResult Index(string username="", string email="", string phone="", string status="", string name_user="", string address="")
        {
            string search = "exec SEARCH_USERS N'" + name_user + "',N'" + address + "','" + username + "','" + status + "','" + email + "','" + phone + "'";
            return View(db.Users.SqlQuery(search).ToList());
        }

        // GET: Admin/Users/Details/5
        [CheckRole(RoleID = "VIEW")]
        [Route("chi-tiet-khach-hang-{id:long?}")]
        public ActionResult Details(long? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            User user = db.Users.Find(id);
            if (user == null)
            {
                return HttpNotFound();
            }
            return View(user);
        }

        // GET: Admin/Users/Create
        [CheckRole(RoleID = "CREATE")]
        [Route("them-khach-hang-moi")]
        public ActionResult Create()
        {
            return View();
        }

        // POST: Admin/Users/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        [CheckRole(RoleID = "CREATE")]
        [Route("them-khach-hang-moi")]
        public ActionResult Create([Bind(Include = "ID,UserName,Password,Name,Address,Email,Phone,CreatedDate,Status")] User user)
        {
            if (ModelState.IsValid)
            {
                bool testUser = db.Users.Count(s => s.UserName == user.UserName) > 0;
                bool testEmail = db.Users.Count(s => s.Email == user.Email) > 0;

                if (testUser)
                {
                    ModelState.AddModelError("", "Tên đăng nhập đã tồn tại");
                    return View(user);
                }
                if(testEmail)
                {
                    ModelState.AddModelError("", "Email đã tồn tại");
                    return View(user);
                }
                user.Password = Encryptor.MD5Hash(user.Password);
                user.CreatedDate = DateTime.Now;
                db.Users.Add(user);
                db.SaveChanges();
                return RedirectToAction("Create");
            }

            return View(user);
        }

        // GET: Admin/Users/Edit/5
        [CheckRole(RoleID = "EDIT")]
        [Route("cap-nhat-thong-tin-khach-hang")]
        public ActionResult Edit(long? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            User user = db.Users.Find(id);
            if (user == null)
            {
                return HttpNotFound();
            }
            return View(user);
        }

        // POST: Admin/Users/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [CheckRole(RoleID = "EDIT")]
        [HttpPost]
        [ValidateAntiForgeryToken]
        [Route("cap-nhat-thong-tin-khach-hang")]
        public ActionResult Edit([Bind(Include = "ID,UserName,Password,Name,Address,Email,Phone,CreatedDate,Status")] User user)
        {
            if (ModelState.IsValid)
            {
                db.Entry(user).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(user);
        }

        // GET: Admin/Users/Delete/5
        [CheckRole(RoleID = "DELETE")]
        [Route("xoa-khach-hang-{id:long?}")]
        public ActionResult Delete(long? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            User user = db.Users.Find(id);
            if (user == null)
            {
                return HttpNotFound();
            }
            return View(user);
        }

        // POST: Admin/Users/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        [Route("xoa-khach-hang-{id:long?}")]
        public ActionResult DeleteConfirmed(long id)
        {
            User user = db.Users.Find(id);
            db.Users.Remove(user);
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
