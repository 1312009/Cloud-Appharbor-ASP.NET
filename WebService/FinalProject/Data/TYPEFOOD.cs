//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace FinalProject.Data
{
    using System;
    using System.Collections.Generic;
    
    public partial class TYPEFOOD
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public TYPEFOOD()
        {
            this.FOODs = new HashSet<FOOD>();
        }
    
        public int ID { get; set; }
        public string NAME { get; set; }
        public Nullable<System.TimeSpan> TIMESTART { get; set; }
        public Nullable<System.TimeSpan> TIMEEND { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<FOOD> FOODs { get; set; }
    }
}
