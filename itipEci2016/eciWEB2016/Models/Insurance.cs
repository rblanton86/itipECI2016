using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace eciWEB2016.Models
{
    /// <summary>
    /// Insurance object, contains properties related to each insurance.
    /// </summary>
    public class Insurance
    {
        public int insuranceID { get; set; }
        public string insuranceName { get; set; }
        public string insurancePolicyID { get; set; }
        public int medPreAuthNumber { get; set; }
        public bool deleted { get; set; }
    }

    /// <summary>
    /// ClientInsurance object which contains an insurance object as well as a list of Insurance Authorizations.
    /// </summary>
    public class ClientInsurance : Insurance
    {
        public List<InsuranceAuthorization> insuranceAuthorization { get; set; }
        public ClientInsurance()
        {
            List<Insurance> insuranceAuthorizations = new List<Insurance>();
        }
    }
}