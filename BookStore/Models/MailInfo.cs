using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BookStore.Models
{
    public class MailInfo
    {
        string email_default = "pnbooknt@gmail.com";
        string pass_default = "iwilkillyou00753200";
        
        public string From { get; set; }

        public string Password { get; set; }

        public string To { get; set; }

        public string Subject { get; set; }

        public string Body { get; set; }
        public string Email_default { get => email_default; set => email_default = value; }
        public string Pass_default { get => pass_default; set => pass_default = value; }

        public MailInfo()
        {
            From = email_default;
            Password = pass_default;
            Subject = "Đơn hàng mới từ PhuongNamBook ngày " + DateTime.Now.ToString("dd-MM-yyyy") + ", lúc " + DateTime.Now.ToString("h:mm tt");
        }

        public MailInfo(string From, string Password, string Subject)
        {
            this.From = From; this.Password = Password; this.Subject = Subject;
        }

        public MailInfo(string Subject)
        {
            From = email_default;
            Password = pass_default;
            this.Subject = Subject;
        }

        public void SendMail(string content=null)
        {
            System.Net.Mail.MailMessage mail = new System.Net.Mail.MailMessage();
            mail.From = new System.Net.Mail.MailAddress(From);
            mail.To.Add(To);
            mail.Subject = Subject;
            if (content == null)
                mail.Body = Body;
            else mail.Body = content;
            mail.IsBodyHtml = true;
            System.Net.Mail.SmtpClient smtp = new System.Net.Mail.SmtpClient("smtp.gmail.com", 587);
            smtp.Credentials = new System.Net.NetworkCredential(From, Password);
            smtp.EnableSsl = true;
            smtp.Send(mail);
        }
    }
}