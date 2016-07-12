using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace eciWEB2016.Models
{
	public class Insurance
	{
        public int insuranceID { get; set; }
        public string insuranceName { get; set; }
        public string insurancePolicyID { get; set; }
        public int medPreAuthNumber { get; set; }
        public bool deleted { get; set; }
	}
}