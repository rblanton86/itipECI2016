/***********************************************************************************************************
Description: 
	Client Model
Author: 
	Jennifer M. Graves
Date: 
	06-21-2016
Change History:
	
************************************************************************************************************/
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace eciWEB2016.Models
{
    public class Client
    {
        public int clientID { get; set; }
        public string altID { get; set; }
        public int raceID { get; set; }
        public int sexID { get; set; }
        public int ethnicityID { get; set; }
        public int clientStatusID { get; set; }
        public int diagnosisID { get; set; }
        public int primaryLanguageID { get; set; }
        public int schoolInfoID { get; set; }
        public int commentsID { get; set; }
        public int insuranceAuthID { get; set; }
        public int communicationPreferencesID { get; set; }
        public string referralSource { get; set; }
        public string firstName { get; set; }
        public string lastName { get; set; }
        public string middleInitial { get; set; }
        [DataType(DataType.Date)]
        public DateTime dob { get; set; }
        public int ssn { get; set; }
        public string race { get; set; }
        public string ethnicity { get; set; }
        public string sex { get; set; }
        public Address clientAddress { get; set; }
        public string additionalContactInfo { get; set; }
        public int additioalContactInfoType { get; set; }
        public string clientStatus { get; set; }
        public string language { get; set; }
        public string ISD { get; set; }
        public int TKIDcaseNumber { get; set; }
        public bool consentRelease { get; set; }
        public string ECI { get; set; }
        public int accountingSystemID { get; set; }
        public Insurance clientInsruance { get; set; }
        public Referral clientReferral { get; set; }
        public Family clientFamily { get; set; }
        public Staff clientStaff { get; set; }
    }
}