/***********************************************************************************************************
Description:
	Referral Model
Author: 
	Jennifer M. Graves
Date: 
	06-21/2016
Change History:
	
************************************************************************************************************/

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace eciWEB2016.Models
{
    public class Referral
    {
        public string clientID { get; set; }
        public int referralSourceID { get; set; }
        public string referralSource { get; set; }
        public string referralSourceType { get; set; }
        public int secondaryReferralSourceID { get; set; }
        public string secondaryReferralSource { get; set; }
        public string secondaryReferralSourceType { get; set; }
        public int referralSourceTypeID { get; set; }
        public int additionalContactInfoID { get; set; }
        public string additionalContactInfo { get; set; }
        public char office { get; set; }
        public int referralDate { get; set; }
        public int dueDate { get; set; }
        public string intakeCoordinator { get; set; }
        public string serviceCoordinator { get; set; }
        public bool reReferral { get; set; }
        public int prevReferralDate { get; set; }
        public string referralReason { get; set; }
        public string referralComments { get; set; }
        public char referralOutcome { get; set; }
        public int referralOutcomeDate { get; set; }
        public bool otherFAtoITIPFA { get; set; }
        public bool ITIPcomptoITIPFA { get; set; }
        public bool ITIPFAtoITIPcomp { get; set; }
        public bool fromOtherECI { get; set; }
        public bool POA { get; set; }
        public string agencyFrom { get; set; }
        public string ECIReferredTo { get; set; }
        public int ECIReferredDate { get; set; }
        public bool referralFax { get; set; }
        public bool referralPhone { get; set; }
    }
}