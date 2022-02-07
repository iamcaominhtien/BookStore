using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using BookStore.Common;
using System.Data;
using System.Data.Entity;
using System.Net;
using System.Web.Mvc;
using BookStore.Areas.Admin.Models;

namespace BookStore.Areas.Admin.Models
{
    public class ManagerFunc
    {
        BookStoreEntities db = new BookStoreEntities();

        public List<string> GetMappingRoles(string username)
        {
            var data = from a in db.ManagerGroups
                       join b in db.MappingRoles
                       on a.ID equals b.ManagerGroupID
                       join c in db.Roles
                       on b.RoleID equals c.ID
                       join d in db.Managers
                       on a.ID equals d.GroupID
                       where d.UserName == username
                       select new
                       {
                           Name = c.Name
                       };

            List<string> temp = new List<string>();
            foreach(var item in data)
            {
                temp.Add(item.Name);
            }

            return temp;
        }

        public int Login(string username, string password)
        {
            var result = db.Managers.SingleOrDefault(x => x.UserName == username);

            //Username doesn't exit
            if (result == null)
                return 0;

            //User is being locked
            if (result.Status == false)
                return -1;

            var group = db.ManagerGroups.Find(result.GroupID).Name;
            //Password is true
            if (result.Password == password)
            {
                if (group == CommonConstant.ADMIN_GROUP || group == CommonConstant.MOD_GROUP || group == CommonConstant.MEMBER_GROUP)
                    return 1;
                return -3;
            }

            //All is wrong
            return -2;
        }

        public Manager GetByName(string username)
        {
            return db.Managers.SingleOrDefault(x => x.UserName == username);
        }

        public IEnumerable<Manager> SeacrhManager(string searchString)
        {
            var result = db.Managers.Where(s => s.ID == s.ID);
            if (!string.IsNullOrEmpty(searchString))
                result = db.Managers.Where(s => s.UserName.Contains(searchString)).Include(s => s.GroupID);
            return result.ToList();
        }

        //public List<Category> ListAll(long? selectedId = null)
        //{
        //    return db.Categories.Where(x => x.Status == true).ToList();
        //}

        public bool ChangeStatus(long id)
        {
            var admin = db.Managers.Find(id);
            admin.Status = !admin.Status;
            db.SaveChanges();
            return (bool)admin.Status;
        }
    }
}