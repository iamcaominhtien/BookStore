//------------------------------------------------------------------------------
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
    using System.Collections.Generic;
    using System.ComponentModel;

    public partial class ManagerGroup
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public ManagerGroup()
        {
            this.Managers = new HashSet<Manager>();
            this.MappingRoles = new HashSet<MappingRole>();
        }
    
        public long ID { get; set; }

        [DisplayName("T�n nh�m")]
        public string Name { get; set; }

        [DisplayName("Ghi ch�")]
        public string Note { get; set; }
        public Nullable<System.DateTime> CreatedDate { get; set; }

        [DisplayName("T�n nh�m")]
        public Nullable<bool> Status { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Manager> Managers { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<MappingRole> MappingRoles { get; set; }
    }
}
