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
        [Required]
        public int clientID { get; set; }
        public int raceID { get; set; }
        public int ethnicityID { get; set; }
        public int clientStatusID { get; set; }
        public int primaryLanguageID { get; set; }
        public int schoolInfoID { get; set; }
        public int communicationPreferencesID { get; set; }
        public int sexID { get; set; }
        public int officeID { get; set; }
        public string altID { get; set; }
        public DateTime intakeDate { get; set; }
        [DataType(DataType.Date)]
        public DateTime ifspDate { get; set; }
        [DataType(DataType.Date)]
        public DateTime compSvcDate { get; set; }
        public string referralSource { get; set; }
        public string firstName { get; set; }
        public string middleInitial { get; set; }
        public string lastName { get; set; }
        public string fullName { get; set; }
        [DataType(DataType.Date)]
        public DateTime dob { get; set; }
        public int ageInMonths { get; set; }
        public int ssn { get; set; }
        public Address clientAddress { get; set; }
        public string additionalContactInfo { get; set; }
        public int additioalContactInfoType { get; set; }
        public int TKIDcaseNumber { get; set; }
        public bool consentRelease { get; set; }
        public bool serviceAreaException { get; set; }
        public bool ECI { get; set; }
        public int accountingSystemID { get; set; }
        public List<Insurance> clientInsurance { get; set; }
        public List<InsuranceAuthorization> clientInsAuths { get; set; }
        public List<Referral> clientReferral { get; set; }
        public List<Family> clientFamily { get; set; }
        public List<Staff> clientStaff { get; set; }
        public List<Diagnosis> clientDiagnosis { get; set; }
        public List<Comments> clientComments { get; set; }
        public List<Physician> clientPhysicians { get; set; }
        public bool deleted { get; set; }
    }
}