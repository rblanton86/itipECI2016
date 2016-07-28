using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace eciWEB2016.Models
{
    /// <summary>
    /// Referral source object which cotains a list of properties related to each referral source such as their name and contact information.
    /// </summary>
    public class ReferralSource
    {
        [Required]
        public int referralSourceID { get; set; }
        public int referralSourceTypeID { get; set; }
        public string referralSourceType { get; set; }
        public string referralSourceName { get; set; }
        public List<AdditionalContactInfoModel> referralSourceContact { get; set; }
        public List<Address> referralSourceAddr { get; set; }
    }
}