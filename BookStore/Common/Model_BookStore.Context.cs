﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace BookStore.Common
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    using System.Data.Entity.Core.Objects;
    using System.Linq;
    
    public partial class BookStoreEntities : DbContext
    {
        public BookStoreEntities()
            : base("name=BookStoreEntities")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public virtual DbSet<Cart> Carts { get; set; }
        public virtual DbSet<CartDetail> CartDetails { get; set; }
        public virtual DbSet<Contact> Contacts { get; set; }
        public virtual DbSet<Manager> Managers { get; set; }
        public virtual DbSet<ManagerGroup> ManagerGroups { get; set; }
        public virtual DbSet<MappingRole> MappingRoles { get; set; }
        public virtual DbSet<Product> Products { get; set; }
        public virtual DbSet<ProductCategory> ProductCategories { get; set; }
        public virtual DbSet<Role> Roles { get; set; }
        public virtual DbSet<Slide> Slides { get; set; }
        public virtual DbSet<sysdiagram> sysdiagrams { get; set; }
        public virtual DbSet<User> Users { get; set; }
    
        public virtual ObjectResult<BestSellerProductCategoryThisWeek_Result> BestSellerProductCategoryThisWeek()
        {
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<BestSellerProductCategoryThisWeek_Result>("BestSellerProductCategoryThisWeek");
        }
    
        public virtual ObjectResult<ChartNewRegister_LastWeek_Result> ChartNewRegister_LastWeek()
        {
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<ChartNewRegister_LastWeek_Result>("ChartNewRegister_LastWeek");
        }
    
        public virtual ObjectResult<ChartNewRegister_ThisWeek_Result> ChartNewRegister_ThisWeek()
        {
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<ChartNewRegister_ThisWeek_Result>("ChartNewRegister_ThisWeek");
        }
    
        public virtual ObjectResult<CheckUserCart_Result> CheckUserCart(Nullable<int> customerID)
        {
            var customerIDParameter = customerID.HasValue ?
                new ObjectParameter("CustomerID", customerID) :
                new ObjectParameter("CustomerID", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<CheckUserCart_Result>("CheckUserCart", customerIDParameter);
        }
    
        public virtual ObjectResult<DetailProduct_Result> DetailProduct(Nullable<int> cateid)
        {
            var cateidParameter = cateid.HasValue ?
                new ObjectParameter("cateid", cateid) :
                new ObjectParameter("cateid", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<DetailProduct_Result>("DetailProduct", cateidParameter);
        }
    
        public virtual ObjectResult<GET_CARTDETAIL_Result> GET_CARTDETAIL(Nullable<int> productID, Nullable<int> orderID)
        {
            var productIDParameter = productID.HasValue ?
                new ObjectParameter("productID", productID) :
                new ObjectParameter("productID", typeof(int));
    
            var orderIDParameter = orderID.HasValue ?
                new ObjectParameter("orderID", orderID) :
                new ObjectParameter("orderID", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<GET_CARTDETAIL_Result>("GET_CARTDETAIL", productIDParameter, orderIDParameter);
        }
    
        public virtual ObjectResult<GET_LISTPRODUCT_CANPAGING_Result> GET_LISTPRODUCT_CANPAGING(Nullable<int> cateID, Nullable<int> skip, Nullable<int> pageSize)
        {
            var cateIDParameter = cateID.HasValue ?
                new ObjectParameter("CateID", cateID) :
                new ObjectParameter("CateID", typeof(int));
    
            var skipParameter = skip.HasValue ?
                new ObjectParameter("skip", skip) :
                new ObjectParameter("skip", typeof(int));
    
            var pageSizeParameter = pageSize.HasValue ?
                new ObjectParameter("pageSize", pageSize) :
                new ObjectParameter("pageSize", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<GET_LISTPRODUCT_CANPAGING_Result>("GET_LISTPRODUCT_CANPAGING", cateIDParameter, skipParameter, pageSizeParameter);
        }
    
        public virtual ObjectResult<GET_USERCART_Result> GET_USERCART(Nullable<int> customerID, Nullable<int> status)
        {
            var customerIDParameter = customerID.HasValue ?
                new ObjectParameter("CustomerID", customerID) :
                new ObjectParameter("CustomerID", typeof(int));
    
            var statusParameter = status.HasValue ?
                new ObjectParameter("Status", status) :
                new ObjectParameter("Status", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<GET_USERCART_Result>("GET_USERCART", customerIDParameter, statusParameter);
        }
    
        public virtual ObjectResult<GET_USERCART_CANPAGING_Result> GET_USERCART_CANPAGING(Nullable<int> customerID, Nullable<int> skip, Nullable<int> pageSize)
        {
            var customerIDParameter = customerID.HasValue ?
                new ObjectParameter("CustomerID", customerID) :
                new ObjectParameter("CustomerID", typeof(int));
    
            var skipParameter = skip.HasValue ?
                new ObjectParameter("skip", skip) :
                new ObjectParameter("skip", typeof(int));
    
            var pageSizeParameter = pageSize.HasValue ?
                new ObjectParameter("pageSize", pageSize) :
                new ObjectParameter("pageSize", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<GET_USERCART_CANPAGING_Result>("GET_USERCART_CANPAGING", customerIDParameter, skipParameter, pageSizeParameter);
        }
    
        public virtual ObjectResult<GetManagerByUserName_Result> GetManagerByUserName(string param1)
        {
            var param1Parameter = param1 != null ?
                new ObjectParameter("param1", param1) :
                new ObjectParameter("param1", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<GetManagerByUserName_Result>("GetManagerByUserName", param1Parameter);
        }
    
        public virtual ObjectResult<GetUserCart_ByCartID_Result> GetUserCart_ByCartID(Nullable<int> cartID)
        {
            var cartIDParameter = cartID.HasValue ?
                new ObjectParameter("CartID", cartID) :
                new ObjectParameter("CartID", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<GetUserCart_ByCartID_Result>("GetUserCart_ByCartID", cartIDParameter);
        }
    
        public virtual ObjectResult<HotProduct_Result> HotProduct()
        {
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<HotProduct_Result>("HotProduct");
        }
    
        public virtual ObjectResult<LatestProducts_Result> LatestProducts()
        {
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<LatestProducts_Result>("LatestProducts");
        }
    
        public virtual ObjectResult<ListProductByCategory_Result> ListProductByCategory(Nullable<int> cate_id)
        {
            var cate_idParameter = cate_id.HasValue ?
                new ObjectParameter("cate_id", cate_id) :
                new ObjectParameter("cate_id", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<ListProductByCategory_Result>("ListProductByCategory", cate_idParameter);
        }
    
        public virtual ObjectResult<ListProductCategoryByStatus_Result> ListProductCategoryByStatus()
        {
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<ListProductCategoryByStatus_Result>("ListProductCategoryByStatus");
        }
    
        public virtual ObjectResult<Product_BestSeller_Result> Product_BestSeller()
        {
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<Product_BestSeller_Result>("Product_BestSeller");
        }
    
        public virtual ObjectResult<RelatedProduct_Result> RelatedProduct(Nullable<int> productID)
        {
            var productIDParameter = productID.HasValue ?
                new ObjectParameter("productID", productID) :
                new ObjectParameter("productID", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<RelatedProduct_Result>("RelatedProduct", productIDParameter);
        }
    
        public virtual ObjectResult<SaleChartLastWeek_Result> SaleChartLastWeek()
        {
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<SaleChartLastWeek_Result>("SaleChartLastWeek");
        }
    
        public virtual ObjectResult<SaleChartThisWeek_Result> SaleChartThisWeek()
        {
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<SaleChartThisWeek_Result>("SaleChartThisWeek");
        }
    
        public virtual int Search_ManagerGroup(string searchString, string status, string fromDate, string toDate)
        {
            var searchStringParameter = searchString != null ?
                new ObjectParameter("searchString", searchString) :
                new ObjectParameter("searchString", typeof(string));
    
            var statusParameter = status != null ?
                new ObjectParameter("status", status) :
                new ObjectParameter("status", typeof(string));
    
            var fromDateParameter = fromDate != null ?
                new ObjectParameter("fromDate", fromDate) :
                new ObjectParameter("fromDate", typeof(string));
    
            var toDateParameter = toDate != null ?
                new ObjectParameter("toDate", toDate) :
                new ObjectParameter("toDate", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("Search_ManagerGroup", searchStringParameter, statusParameter, fromDateParameter, toDateParameter);
        }
    
        public virtual ObjectResult<string> SEARCH_PRODUCT(string sEARCH)
        {
            var sEARCHParameter = sEARCH != null ?
                new ObjectParameter("SEARCH", sEARCH) :
                new ObjectParameter("SEARCH", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<string>("SEARCH_PRODUCT", sEARCHParameter);
        }
    
        public virtual int SEARCH_PRODUCT_CATEGORY(string sEARCH, string sTATUS)
        {
            var sEARCHParameter = sEARCH != null ?
                new ObjectParameter("SEARCH", sEARCH) :
                new ObjectParameter("SEARCH", typeof(string));
    
            var sTATUSParameter = sTATUS != null ?
                new ObjectParameter("STATUS", sTATUS) :
                new ObjectParameter("STATUS", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("SEARCH_PRODUCT_CATEGORY", sEARCHParameter, sTATUSParameter);
        }
    
        public virtual int SEARCH_PRODUCT_MULTIPLE(string sEARCH, string sTATUS, string mINPRICE, string mAXPRICE, string cATEGORYID)
        {
            var sEARCHParameter = sEARCH != null ?
                new ObjectParameter("SEARCH", sEARCH) :
                new ObjectParameter("SEARCH", typeof(string));
    
            var sTATUSParameter = sTATUS != null ?
                new ObjectParameter("STATUS", sTATUS) :
                new ObjectParameter("STATUS", typeof(string));
    
            var mINPRICEParameter = mINPRICE != null ?
                new ObjectParameter("MINPRICE", mINPRICE) :
                new ObjectParameter("MINPRICE", typeof(string));
    
            var mAXPRICEParameter = mAXPRICE != null ?
                new ObjectParameter("MAXPRICE", mAXPRICE) :
                new ObjectParameter("MAXPRICE", typeof(string));
    
            var cATEGORYIDParameter = cATEGORYID != null ?
                new ObjectParameter("CATEGORYID", cATEGORYID) :
                new ObjectParameter("CATEGORYID", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("SEARCH_PRODUCT_MULTIPLE", sEARCHParameter, sTATUSParameter, mINPRICEParameter, mAXPRICEParameter, cATEGORYIDParameter);
        }
    
        public virtual int SEARCH_USERS(string nAME, string aDDRESS, string uSERNAME, string sTATUS, string eMAIL, string pHONE)
        {
            var nAMEParameter = nAME != null ?
                new ObjectParameter("NAME", nAME) :
                new ObjectParameter("NAME", typeof(string));
    
            var aDDRESSParameter = aDDRESS != null ?
                new ObjectParameter("ADDRESS", aDDRESS) :
                new ObjectParameter("ADDRESS", typeof(string));
    
            var uSERNAMEParameter = uSERNAME != null ?
                new ObjectParameter("USERNAME", uSERNAME) :
                new ObjectParameter("USERNAME", typeof(string));
    
            var sTATUSParameter = sTATUS != null ?
                new ObjectParameter("STATUS", sTATUS) :
                new ObjectParameter("STATUS", typeof(string));
    
            var eMAILParameter = eMAIL != null ?
                new ObjectParameter("EMAIL", eMAIL) :
                new ObjectParameter("EMAIL", typeof(string));
    
            var pHONEParameter = pHONE != null ?
                new ObjectParameter("PHONE", pHONE) :
                new ObjectParameter("PHONE", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("SEARCH_USERS", nAMEParameter, aDDRESSParameter, uSERNAMEParameter, sTATUSParameter, eMAILParameter, pHONEParameter);
        }
    
        public virtual ObjectResult<SortProductByCateID_Result> SortProductByCateID()
        {
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<SortProductByCateID_Result>("SortProductByCateID");
        }
    
        public virtual int sp_alterdiagram(string diagramname, Nullable<int> owner_id, Nullable<int> version, byte[] definition)
        {
            var diagramnameParameter = diagramname != null ?
                new ObjectParameter("diagramname", diagramname) :
                new ObjectParameter("diagramname", typeof(string));
    
            var owner_idParameter = owner_id.HasValue ?
                new ObjectParameter("owner_id", owner_id) :
                new ObjectParameter("owner_id", typeof(int));
    
            var versionParameter = version.HasValue ?
                new ObjectParameter("version", version) :
                new ObjectParameter("version", typeof(int));
    
            var definitionParameter = definition != null ?
                new ObjectParameter("definition", definition) :
                new ObjectParameter("definition", typeof(byte[]));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("sp_alterdiagram", diagramnameParameter, owner_idParameter, versionParameter, definitionParameter);
        }
    
        public virtual int sp_creatediagram(string diagramname, Nullable<int> owner_id, Nullable<int> version, byte[] definition)
        {
            var diagramnameParameter = diagramname != null ?
                new ObjectParameter("diagramname", diagramname) :
                new ObjectParameter("diagramname", typeof(string));
    
            var owner_idParameter = owner_id.HasValue ?
                new ObjectParameter("owner_id", owner_id) :
                new ObjectParameter("owner_id", typeof(int));
    
            var versionParameter = version.HasValue ?
                new ObjectParameter("version", version) :
                new ObjectParameter("version", typeof(int));
    
            var definitionParameter = definition != null ?
                new ObjectParameter("definition", definition) :
                new ObjectParameter("definition", typeof(byte[]));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("sp_creatediagram", diagramnameParameter, owner_idParameter, versionParameter, definitionParameter);
        }
    
        public virtual int sp_dropdiagram(string diagramname, Nullable<int> owner_id)
        {
            var diagramnameParameter = diagramname != null ?
                new ObjectParameter("diagramname", diagramname) :
                new ObjectParameter("diagramname", typeof(string));
    
            var owner_idParameter = owner_id.HasValue ?
                new ObjectParameter("owner_id", owner_id) :
                new ObjectParameter("owner_id", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("sp_dropdiagram", diagramnameParameter, owner_idParameter);
        }
    
        public virtual ObjectResult<sp_helpdiagramdefinition_Result> sp_helpdiagramdefinition(string diagramname, Nullable<int> owner_id)
        {
            var diagramnameParameter = diagramname != null ?
                new ObjectParameter("diagramname", diagramname) :
                new ObjectParameter("diagramname", typeof(string));
    
            var owner_idParameter = owner_id.HasValue ?
                new ObjectParameter("owner_id", owner_id) :
                new ObjectParameter("owner_id", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<sp_helpdiagramdefinition_Result>("sp_helpdiagramdefinition", diagramnameParameter, owner_idParameter);
        }
    
        public virtual ObjectResult<sp_helpdiagrams_Result> sp_helpdiagrams(string diagramname, Nullable<int> owner_id)
        {
            var diagramnameParameter = diagramname != null ?
                new ObjectParameter("diagramname", diagramname) :
                new ObjectParameter("diagramname", typeof(string));
    
            var owner_idParameter = owner_id.HasValue ?
                new ObjectParameter("owner_id", owner_id) :
                new ObjectParameter("owner_id", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<sp_helpdiagrams_Result>("sp_helpdiagrams", diagramnameParameter, owner_idParameter);
        }
    
        public virtual int sp_renamediagram(string diagramname, Nullable<int> owner_id, string new_diagramname)
        {
            var diagramnameParameter = diagramname != null ?
                new ObjectParameter("diagramname", diagramname) :
                new ObjectParameter("diagramname", typeof(string));
    
            var owner_idParameter = owner_id.HasValue ?
                new ObjectParameter("owner_id", owner_id) :
                new ObjectParameter("owner_id", typeof(int));
    
            var new_diagramnameParameter = new_diagramname != null ?
                new ObjectParameter("new_diagramname", new_diagramname) :
                new ObjectParameter("new_diagramname", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("sp_renamediagram", diagramnameParameter, owner_idParameter, new_diagramnameParameter);
        }
    
        public virtual int sp_upgraddiagrams()
        {
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("sp_upgraddiagrams");
        }
    
        public virtual ObjectResult<TopRatedProduct_Result> TopRatedProduct(Nullable<int> takeval)
        {
            var takevalParameter = takeval.HasValue ?
                new ObjectParameter("takeval", takeval) :
                new ObjectParameter("takeval", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<TopRatedProduct_Result>("TopRatedProduct", takevalParameter);
        }
    }
}
