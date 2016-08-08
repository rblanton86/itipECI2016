using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace eciWEB2016.Models
{
    /// <summary>
    /// Referral holds properties of the referral object, where client is referred to program.
    /// </summary>
    public class Referral
    {
        [Display(Name = "Referral Source")]
        public ReferralSource referralSource { get; set; }
        [Display(Name = "Secondary Referral Source")]
        public ReferralSource secondaryReferralSource { get; set; }
        [DataType(DataType.Date)]
        [Display(Name = "Referral Date")]
        [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}", ApplyFormatInEditMode = true)]
        public DateTime referralDate { get; set; }
        [DataType(DataType.Date)]
        [Display(Name = "Due Date")]
        [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}", ApplyFormatInEditMode = true)]
        public DateTime referralDueDate { get; set; }
        [DataType(DataType.Date)]
        [Display(Name = "Previous Referral Date")]
        [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}", ApplyFormatInEditMode = true)]
        public DateTime prevReferralDate { get; set; }
        [DataType(DataType.Date)]
        [Display(Name = "Referral Outcome Date")]
        [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}", ApplyFormatInEditMode = true)]
        public DateTime referralOutcomeDate { get; set; }
        [Display(Name = "Referral Reason")]
        public string referralReason { get; set; }
        [Display(Name = "Referral Comments")]
        public string referralComments { get; set; }
        [Display(Name = "Referral Outcome")]
        public string referralOutcome { get; set; }
        public bool reReferral { get; set; }
        public string transferringLocation { get; set; }
        public bool sentByPhone { get; set; }
        public bool sentByFax { get; set; }
    }

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