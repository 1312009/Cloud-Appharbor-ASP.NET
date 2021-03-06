﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace WebAPI.Data
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    using System.Data.Entity.Core.Objects;
    using System.Linq;
    
    public partial class FOODEntities : DbContext
    {
        public FOODEntities()
            : base("name=FOODEntities")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public virtual DbSet<ACCOUNT> ACCOUNTs { get; set; }
        public virtual DbSet<ACCOUNT_ROLE> ACCOUNT_ROLE { get; set; }
        public virtual DbSet<COMMENT> COMMENTs { get; set; }
        public virtual DbSet<EXTERNALACCOUNT> EXTERNALACCOUNTs { get; set; }
        public virtual DbSet<FOOD> FOODs { get; set; }
        public virtual DbSet<FOODORDER> FOODORDERs { get; set; }
        public virtual DbSet<LIST_ROLE> LIST_ROLE { get; set; }
        public virtual DbSet<TYPEFOOD> TYPEFOODs { get; set; }
    
        public virtual ObjectResult<usp_LoaiMonAn_Result> usp_LoaiMonAn(Nullable<int> tYPE)
        {
            var tYPEParameter = tYPE.HasValue ?
                new ObjectParameter("TYPE", tYPE) :
                new ObjectParameter("TYPE", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<usp_LoaiMonAn_Result>("usp_LoaiMonAn", tYPEParameter);
        }
    
        public virtual int usp_ThemMonAn(string name, string decription, Nullable<int> issale, Nullable<int> idtype, string img, Nullable<double> price, Nullable<int> nUMBER)
        {
            var nameParameter = name != null ?
                new ObjectParameter("name", name) :
                new ObjectParameter("name", typeof(string));
    
            var decriptionParameter = decription != null ?
                new ObjectParameter("decription", decription) :
                new ObjectParameter("decription", typeof(string));
    
            var issaleParameter = issale.HasValue ?
                new ObjectParameter("issale", issale) :
                new ObjectParameter("issale", typeof(int));
    
            var idtypeParameter = idtype.HasValue ?
                new ObjectParameter("idtype", idtype) :
                new ObjectParameter("idtype", typeof(int));
    
            var imgParameter = img != null ?
                new ObjectParameter("img", img) :
                new ObjectParameter("img", typeof(string));
    
            var priceParameter = price.HasValue ?
                new ObjectParameter("price", price) :
                new ObjectParameter("price", typeof(double));
    
            var nUMBERParameter = nUMBER.HasValue ?
                new ObjectParameter("NUMBER", nUMBER) :
                new ObjectParameter("NUMBER", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("usp_ThemMonAn", nameParameter, decriptionParameter, issaleParameter, idtypeParameter, imgParameter, priceParameter, nUMBERParameter);
        }
    
        public virtual ObjectResult<usp_TimKiemMonAn_Result> usp_TimKiemMonAn(string tT, Nullable<int> row, Nullable<int> count)
        {
            var tTParameter = tT != null ?
                new ObjectParameter("TT", tT) :
                new ObjectParameter("TT", typeof(string));
    
            var rowParameter = row.HasValue ?
                new ObjectParameter("row", row) :
                new ObjectParameter("row", typeof(int));
    
            var countParameter = count.HasValue ?
                new ObjectParameter("count", count) :
                new ObjectParameter("count", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<usp_TimKiemMonAn_Result>("usp_TimKiemMonAn", tTParameter, rowParameter, countParameter);
        }
    
        public virtual ObjectResult<usp_TopMonAnThich_Result> usp_TopMonAnThich()
        {
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<usp_TopMonAnThich_Result>("usp_TopMonAnThich");
        }
    
        public virtual int usp_XoaMonAn(Nullable<int> id)
        {
            var idParameter = id.HasValue ?
                new ObjectParameter("id", id) :
                new ObjectParameter("id", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("usp_XoaMonAn", idParameter);
        }
    }
}
