using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace eciWEB2016.Models
{
    public class Diagnosis
    {
        public string diagnosisType { get; set; }
        public string diagnosisCode { get; set; }
        public string diagnosis { get; set; }
        public DateTime diagnosisFrom { get; set; }
        public DateTime diagnosisTo { get; set; }
        public bool deleted { get; set; }
    }
}