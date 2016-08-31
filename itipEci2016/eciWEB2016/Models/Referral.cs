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

        [Required]
        [Display(Name = "Referral Source")]
        public ReferralSource referralSource { get; set; }

        [Display(Name = "Secondary Referral Source")]
        public ReferralSource secondaryReferralSource { get; set; }

        [DataType(DataType.Date)]
        [Display(Name = "Referral Date")]
        [Required]
        [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}", ApplyFormatInEditMode = true)]
        public DateTime referralDate { get; set; }

        [DataType(DataType.Date)]
        [Display(Name = "Due Date")]
        [Required]
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

        [Required]
        [Display(Name = "Referral Reason")]
        public string referralReason { get; set; }

        [Display(Name = "Referral Comments")]
        public string referralComments { get; set; }

        [Display(Name = "Referral Outcome")]
        public string referralOutcome { get; set; }

        [Display(Name = "Re-Referral?")]
        public bool reReferral { get; set; }

        [Display(Name = "Location transferring from")]
        public string transferringLocation { get; set; }

        [Display(Name = "Referral Sent By Phone")]
        public bool sentByPhone { get; set; }

        [Display(Name = "Referral Sent By Fax")]
        public bool sentByFax { get; set; }

        // Bools in place to trigger if referral has been inserted.
        public bool insertReferralMainComplete { get; set; }
        public bool insertReferralDetailsComplete { get; set; }

        public Referral()
        {
            insertReferralDetailsComplete = false;
            insertReferralMainComplete = false;
        }
    }

    /// <summary>
    /// Referral source object which cotains a list of properties related to each referral source such as their name and contact information.
    /// </summary>
    public class ReferralSource
    {
        public int referralSourceID { get; set; }
        public int referralSourceTypeID { get; set; }
        public string referralSourceType { get; set; }

        [Required]
        [Display(Name = "Referral Name")]
        public string referralSourceName { get; set; }

        public List<AdditionalContactInfoModel> referralSourceContact { get; set; }

        public List<Address> referralSourceAddr { get; set; }
    }
}