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

        // Set by values in the database.
        [Required]
        public int clientID { get; set; }
        public int memberTypeID { get; set; }
        [Display(Name = "Race")]
        public int raceID { get; set; }
        [Display(Name = "Ethnicity")]
        public int ethnicityID { get; set; }
        [Display(Name = "Client Status")]
        public int clientStatusID { get; set; }
        [Display(Name = "Primary Language")]
        public int primaryLanguageID { get; set; }
        [Display(Name = "ISD")]
        public int schoolInfoID { get; set; }
        [Display(Name = "Communication Preference")]
        public int communicationPreferencesID { get; set; }
        [Display(Name = "Sex")]
        public int sexID { get; set; }
        [Display(Name = "Office")]
        public int officeID { get; set; }
        [Display(Name = "AltID")]
        public string altID { get; set; }
        [Display(Name = "Accounting System ID")]
        public string accountingSystemID { get; set; }
        [Display(Name = "TKIDs Case Number")]
        public int TKIDcaseNumber { get; set; }

        [DataType(DataType.Date)]
        [Display(Name = "Intake Date")]
        public DateTime intakeDate { get; set; }
        [DataType(DataType.Date)]
        [Display(Name = "IFSP Date")]
        public DateTime ifspDate { get; set; }
        [DataType(DataType.Date)]
        [Display(Name = "CompSvc Date")]
        public DateTime compSvcDate { get; set; }

        [Display(Name = "Referral Source")]
        public string referralSource { get; set; }
        [Display(Name = "Agency From")]
        public string agencyFrom { get; set; }
        [Display(Name = "Re Referral")]
        public bool reReferral { get; set; }

        [Display(Name = "First Name")]
        public string firstName { get; set; }
        [Display(Name = "Middle Initial")]
        public string middleInitial { get; set; }
        [Display(Name = "Last Name")]
        public string lastName { get; set; }
        [Display(Name = "Full Name")]
        public string fullName { get; set; }
        [DataType(DataType.Date)]
        [Display(Name = "Date Of Birth")]
        public DateTime dob { get; set; }
        [Display(Name = "Age (In Months)")]
        public int ageInMonths { get; set; }
        [Display(Name = "Social Security Number")]
        public int ssn { get; set; }

        [Display(Name = "Client Address")]
        public Address clientAddress { get; set; }
        [Display(Name = "Client Phone")]
        public AdditionalContactInfoModel phone { get; set; }

        [Display(Name = "Consent To Release")]
        public bool consentRelease { get; set; }
        [Display(Name = "Service Area Exception")]
        public bool serviceAreaException { get; set; }
        [Display(Name = "ECI")]
        public bool ECI { get; set; }
        [Display(Name = "Referral Reason")]
        public string referralReason { get; set; }
        [Display(Name = "Referral Comments")]
        public string referralComments { get; set; }
        [Display(Name = "Referral Outcome")]
        public string referralOutcome { get; set; }
        [Display(Name = "Other FA to ITIPFA")]
        public bool otherFAtoITIPFA { get; set; }
        [Display(Name = "ITIP Comp to ITIPFA")]
        public bool ITIPcomptoITIPFA { get; set; }
        [Display(Name = "ITIPFA to ITIPComp")]
        public bool ITIPFAtoITIPcomp { get; set; }
        [Display(Name = "From Other ECI")]
        public bool fromOtherECI { get; set; }
        [Display(Name = "Point of Access")]
        public bool pointOfAccess { get; set; }
        [DataType(DataType.Date)]
        [Display(Name = "ECI Referred To")]
        public DateTime ECIReferredTo { get; set; }
        [DataType(DataType.Date)]
        [Display(Name = "ECI Referred Date")]
        public DateTime ECIReferredDate { get; set; }
        [DataType(DataType.Date)]
        [Display(Name = "Referral Date")]
        public DateTime referralDate { get; set; }
        [DataType(DataType.Date)]
        [Display(Name = "Referral Due Date")]
        public DateTime referralDueDate { get; set; }
        [DataType(DataType.Date)]
        [Display(Name = "Previous Referral Date")]
        public DateTime prevReferralDate { get; set; }
        [DataType(DataType.Date)]
        [Display(Name = "Referral Outcome Date")]
        public DateTime referralOutcomeDate { get; set; }
        [Display(Name = "Insurance")]
        public List<ClientInsurance> clientInsurance { get; set; }
        [Display(Name = "Insurance Authorization")]
        public List<Family> clientFamily { get; set; }
        [Display(Name = "Staff")]
        public List<Staff> clientStaff { get; set; }
        [Display(Name = "Case Manager")]
        public Staff caseManager { get; set; }
        [Display(Name = "Diagnosis")]
        public List<Diagnosis> clientDiagnosis { get; set; }
        [Display(Name = "Comments")]
        public List<Comments> clientComments { get; set; }
        [Display(Name = "Physician")]
        public List<Physician> clientPhysicians { get; set; }
        [Display(Name = "Deleted")]
        public bool deleted { get; set; }

        // Default constructor for client, so no null values are returned.
        public Client()
        {
            raceID = 1;
            ethnicityID = 1;
            clientStatusID = 1;
            primaryLanguageID = 1;
            schoolInfoID = 1;
            communicationPreferencesID = 1;
            sexID = 1;
            officeID = 1;
            memberTypeID = 1;
            altID = "";
            accountingSystemID = "";
            TKIDcaseNumber = 0;

            // Dates
            intakeDate = (DateTime)System.Data.SqlTypes.SqlDateTime.MinValue;
            ifspDate = (DateTime)System.Data.SqlTypes.SqlDateTime.MinValue;
            compSvcDate = (DateTime)System.Data.SqlTypes.SqlDateTime.MinValue;

            // Referral
            referralSource = "";
            agencyFrom = "";
            reReferral = false;

            // Demographics
            firstName = "";
            middleInitial = "";
            lastName = "";
            fullName = "";
            dob = (DateTime)System.Data.SqlTypes.SqlDateTime.MinValue;
            ageInMonths = 0;
            ssn = 0;

            // Address
            clientAddress = new Address();

            // Contact
            phone = new AdditionalContactInfoModel();

            clientDiagnosis = new List<Diagnosis>();

            clientFamily = new List<Family>();

            clientPhysicians = new List<Physician>();

            clientStaff = new List<Staff>();

            clientInsurance = new List<ClientInsurance>();

            clientComments = new List<Comments>();

            caseManager = new Staff();
        }
    }
}