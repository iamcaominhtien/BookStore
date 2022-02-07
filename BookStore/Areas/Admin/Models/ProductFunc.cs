using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;

namespace BookStore.Areas.Admin.Models
{
    public class ProductFunc
    {
        public static string CreateMetatitle(string s)
        {
            //Regex regex = new Regex("\\p{IsCombiningDiacriticalMarks}+");
            //string temp = s.Normalize(NormalizationForm.FormD);
            ////return regex.Replace(temp, String.Empty).Replace('\u0111', 'd').Replace('\u0110', 'D').Replace(" ", "_").Replace(".", "_").Replace("-","_").ToLower();
            //return regex.Replace(temp, String.Empty).Replace('\u0111', 'd').Replace('\u0110', 'D').Replace(" ", "_").Replace(".", "_").Replace("-", "_").Replace("&", "_").ToLower();
            Regex rgx = new Regex("[^a-zA-Z0-9 -]");
            Regex rgx2 = new Regex("\\p{IsCombiningDiacriticalMarks}+");
            string str = s.Normalize(NormalizationForm.FormD);
            str = rgx2.Replace(str, String.Empty).Replace('\u0111', 'd').Replace('\u0110', 'D').Replace(" ", "_").ToLower();
            return rgx.Replace(str, "_");
        }
    }
}