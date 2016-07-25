using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using eciWEB2016.Controllers.DataControllers;

namespace eciWEB2016.Models
{
    public class Diagnosis
    {
        public int diagnosisID { get; set; }

        [Display(Name = "Diagnosis Code")]
        public int diagnosisCodeID { get; set; }
        public string diagnosisCode { get; set; } // Literal diagnosis code
        [Display(Name = "Diagnosis")]
        public string diagnosisDescription { get; set; } // Diagnosis description
        public int diagnosisTypeID { get; set; }
        public string diagnosisType { get; set; } // Diagnosis type (i.e. ICD9, ICD10)
        [Display(Name = "Diagnosis From")]
        public DateTime diagnosisFrom { get; set; } // Date of diagnosis
        [Display(Name = "Diagnosis To")]
        public DateTime diagnosisTo { get; set; } // Date diangosis end
        [Display(Name = "Diagnosis Type")]
        public bool isPrimary { get; set; } // Whether this diagnosis is primary
        public bool deleted { get; set; } // Whether this diagnosis is deleted
    }
}