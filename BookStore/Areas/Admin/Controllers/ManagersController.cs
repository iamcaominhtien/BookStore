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
    [RoutePrefix("quan-li-quan-tri-vien")]
    public class ManagersController : BasicController
    {
        private BookStoreEntities db = new BookStoreEntities();
        static string oldPass = "";

        [ChildActionOnly]
        public ActionResult SalesChart()
        {
            var statisLastWeek = db.Database.SqlQuery<SaleChart>("exec SaleChartLastWeek");
            var statisThisWeek = db.Database.SqlQuery<SaleChart>("exec SaleChartThisWeek");
            var time = DateTime.Now.AddDays(-7);
            List<int> thisweek = new List<int>();
            List<int> lastweek = new List<int>();
            ViewBag.countthis = 0;
            ViewBag.countlast = 0;

            for (int i = 1; i <= 7; i++)
            {
                try
                {
                    decimal? temp = statisThisWeek.Where(x => x.CreatedDate.Value.ToString("dd-MM-yyyy") == time.ToString("dd-MM-yyyy")).ToList()[0].Price;
                    thisweek.Add(Convert.ToInt32(temp));
                    ViewBag.countthis += Convert.ToInt32(temp);
                }
                catch { thisweek.Add(0); }
                time = time.AddDays(1);
            }

            time = DateTime.Now.AddDays(-14);
            for (int i = 1; i <= 7; i++)
            {
                try
                {
                    decimal? temp = (int)statisLastWeek.Where(x => x.CreatedDate.Value.ToString("dd-MM-yyyy") == time.ToString("dd-MM-yyyy")).ToList()[0].Price;
                    lastweek.Add(Convert.ToInt32(temp));
                    ViewBag.countlast += Convert.ToInt32(temp);
                }
                catch { lastweek.Add(0); }
                time = time.AddDays(1);
            }

            ViewBag.thisweek = thisweek;
            ViewBag.lastweek = lastweek;

            return View();
        }

        [ChildActionOnly]
        public ActionResult ChartNewRegister()
        {
            var statisLastWeek = db.Users.SqlQuery("exec ChartNewRegister_LastWeek");
            var statisThisWeek = db.Users.SqlQuery("exec ChartNewRegister_ThisWeek");
            var time = DateTime.Now.AddDays(-7);
            List<int> thisweek = new List<int>();
            List<int> lastweek = new List<int>();
            ViewBag.countthis = 0;
            ViewBag.countlast = 0;

            for (int i=1;i<=7;i++)
            {
                int temp = statisThisWeek.Count(x => x.CreatedDate.Value.ToString("dd-MM-yyyy") == time.ToString("dd-MM-yyyy"));
                thisweek.Add(temp);
                time = time.AddDays(1);
                ViewBag.countthis += temp;
            }

            time = DateTime.Now.AddDays(-14);
            for (int i = 1; i <= 7; i++)
            {
                int temp = statisLastWeek.Count(x => x.CreatedDate.Value.ToString("dd-MM-yyyy") == time.ToString("dd-MM-yyyy"));
                lastweek.Add(temp);
                time = time.AddDays(1);
                ViewBag.countlast += temp;
            }

            ViewBag.thisweek = thisweek;
            ViewBag.lastweek = lastweek;

            //Các sản phẩm bán chạy trong tuần
            return View();
        }

        //[CheckRole(RoleID = "VIEW")]
        [Route("",Order=1)]
        [Route("trang-chu",Order=0)]
        public ActionResult ManagerHome()
        {
            //Các sản phẩm bán chạy trong tuần
            //var productBestSeller = db.Products.OrderByDescending(x => x.ViewCout).Take(8);
            ViewBag.productBestSeller = db.Database.SqlQuery<ProductOnChart>("exec Product_BestSeller").ToList();
            return View();
        }

        [Route("danh-sach-quan-tri-vien")]
        [CheckRole(RoleID = "EDIT")]
        // GET: Admin/Managers
        [CheckRole(RoleID = "VIEW")]
        public ActionResult Index(string name_admin="",string status="", string username="", string ManagerGroup="")
        {
            var dao = new ManagerFunc();
            ViewBag.ManagerGroup = new SelectList(db.ManagerGroups, "ID", "Name");
            string searchstring = "exec SEARCH_MANAGERS N'" + name_admin + "','" + username + "','" + status + "','" + ManagerGroup + "'";
            var admin = db.Managers.SqlQuery(searchstring).ToList();
            return View(admin);
        }

        // GET: Admin/Managers/Details/5
        [Route("chi-tiet-quan-tri-vien-{id:long?}")]
        [CheckRole(RoleID = "VIEW")]
        public ActionResult Details(long? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Manager manager = db.Managers.Find(id);
            if (manager == null)
            {
                return HttpNotFound();
            }
            return View(manager);
        }

        // GET: Admin/Managers/Create
        [CheckRole(RoleID = "CREATE")]
        [Route("them-moi-quan-tri-vien")]
        public ActionResult Create()
        {
            ViewBag.GroupID = new SelectList(db.ManagerGroups, "ID", "Name");
            return View();
        }

        // POST: Admin/Managers/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        [CheckRole(RoleID = "CREATE")]
        [Route("them-moi-quan-tri-vien")]
        public ActionResult Create([Bind(Include = "ID,SirName,FirstName,UserName,Password,Status,GroupID")] Manager manager)
        {
            if (ModelState.IsValid)
            {
                db.Managers.Add(manager);
                db.SaveChanges();
                return RedirectToAction("Create");
            }

            ViewBag.GroupID = new SelectList(db.ManagerGroups, "ID", "Name", manager.GroupID);
            return View(manager);
        }

        // GET: Admin/Managers/Edit/5
        [CheckRole(RoleID = "EDIT")]
        [Route("cap-nhat-quan-tri-vien{id:long?}")]
        public ActionResult Edit(long? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Manager manager = db.Managers.Find(id);
            if (manager == null)
            {
                return HttpNotFound();
            }
            oldPass = manager.Password;
            ViewBag.GroupID = new SelectList(db.ManagerGroups, "ID", "Name", manager.GroupID);
            return View(manager);
        }

        // POST: Admin/Managers/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        [CheckRole(RoleID = "EDIT")]
        [Route("cap-nhat-quan-tri-vien{id:long?}")]
        public ActionResult Edit([Bind(Include = "ID,SirName,FirstName,UserName,Password,Status,GroupID")] Manager manager)
        {
            if (ModelState.IsValid)
            {
                //var existingManager = db.Products.Find(manager.ID);
                //db.Entry(existingManager).CurrentValues.SetValues(manager);
                db.Entry(manager).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.GroupID = new SelectList(db.ManagerGroups, "ID", "Name", manager.GroupID);
            return View(manager);
        }

        // GET: Admin/Managers/Delete/5
        [CheckRole(RoleID = "DELETE")]
        [Route("xoa-quan-tri-vien")]
        public ActionResult Delete(long? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Manager manager = db.Managers.Find(id);
            if (manager == null)
            {
                return HttpNotFound();
            }
            return View(manager);
        }

        // POST: Admin/Managers/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        [CheckRole(RoleID = "DELETE")]
        [Route("xoa-quan-tri-vien")]
        public ActionResult DeleteConfirmed(long id)
        {
            Manager manager = db.Managers.Find(id);
            db.Managers.Remove(manager);
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

        [HttpPost]
        public JsonResult ChangeStatus(long id)
        {
            var result = new ManagerFunc().ChangeStatus(id);
            return Json(new
            {
                status = result
            });
        }
    }
}
