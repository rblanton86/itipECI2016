using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace eciWEB2016.Models
{
    public class Diagnosis
    {
        public string diagnosisCode { get; set; } // Literal diagnosis code
        public string diagnosisDescription { get; set; } // Diagnosis description
        public string diagnosisType { get; set; } // Diagnosis type (i.e. ICD9, ICD10)
        public DateTime diagnosisFrom { get; set; } // Date of diagnosis
        public DateTime diagnosisTo { get; set; } // Date diangosis end
        public bool isPrimary { get; set; } // Whether this diagnosis is primary
        public bool deleted { get; set; } // Whether this diagnosis is deleted
    }
}