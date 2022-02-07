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
using BookStore.Models;

namespace BookStore.Controllers
{
    public class HomeController : Controller
    {
        BookStoreEntities db = new BookStoreEntities();

        // GET: Home
        public ActionResult Index()
        {
            ViewBag.Products = db.Products.SqlQuery("exec SortProductByCateID").ToList();
            ViewBag.LatestProducts = db.Products.SqlQuery("exec LatestProducts").ToList();
            ViewBag.TopRatedProduct = db.Products.SqlQuery("exec TopRatedProduct 20").ToList();
            ViewBag.HotProduct = db.Products.SqlQuery("exec HotProduct").ToList();
            ViewBag.ProductCategory = db.ProductCategories.SqlQuery("exec ListProductCategoryByStatus").ToList();
            return View(db.ProductCategories.ToList());
        }

        [ChildActionOnly]
        public PartialViewResult MenuProductCategory()
        {
            return PartialView(db.ProductCategories.SqlQuery("exec ListProductCategoryByStatus").ToList());
        }

        public ActionResult Contact()
        {
            return View(db.Contacts.Find(1));
        }

        [HttpPost]
        public ActionResult Contact(string customerName, string customerEmail, string customerMessage)
        {
            var mailInfo = new MailInfo();
            System.Net.Mail.MailMessage mail = new System.Net.Mail.MailMessage();
            mail.From = new System.Net.Mail.MailAddress(mailInfo.Email_default);
            mail.To.Add(mailInfo.Email_default);
            mail.Subject = "Tin nhắn từ khách hàng vào ngày " + DateTime.Now.ToString("dd-MM-yyyy") + ", lúc " + DateTime.Now.ToString("h:mm tt");

            string content = System.IO.File.ReadAllText(Server.MapPath("~/Assets/Client/template/contactEMail.html"));
            content = content.Replace("{{Name}}", customerName).Replace("{{Email}}", customerEmail).Replace("{{Message}}", customerMessage);
            mail.Body = content;
            mail.IsBodyHtml = true;
            System.Net.Mail.SmtpClient smtp = new System.Net.Mail.SmtpClient("smtp.gmail.com", 587);
            smtp.Credentials = new System.Net.NetworkCredential(mailInfo.Email_default,mailInfo.Pass_default);
            smtp.EnableSsl = true;
            smtp.Send(mail);
            return View(db.Contacts.Find(1));
        }
    }
}