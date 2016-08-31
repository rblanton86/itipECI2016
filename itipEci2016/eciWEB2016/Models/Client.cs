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
    /// <summary>
    /// Client object which contains properties belonging to the client.
    /// </summary>
    public class Client
    {

        // Set by values in the database.
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
        [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}", ApplyFormatInEditMode = true)]
        public DateTime intakeDate { get; set; }

        [DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}", ApplyFormatInEditMode = true)]
        [Display(Name = "IFSP Date")]
        public DateTime ifspDate { get; set; }

        [DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}", ApplyFormatInEditMode = true)]
        [Display(Name = "CompSvc Date")]
        public DateTime compSvcDate { get; set; }

        [Display(Name = "Referral Source")]
        public string referralSource { get; set; }

        [Display(Name = "Agency From")]
        public string agencyFrom { get; set; }

        [Display(Name = "First Name")]
        [Required]
        public string firstName { get; set; }

        [Display(Name = "Middle Initial")]
        public string middleInitial { get; set; }

        [Display(Name = "Last Name")]
        [Required]
        public string lastName { get; set; }

        [Display(Name = "Full Name")]
        public string fullName { get; set; }

        [DataType(DataType.Date)]
        [Display(Name = "Date Of Birth")]
        [Required]
        [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}", ApplyFormatInEditMode = true)]
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
        public string ECIReferredTo { get; set; }

        [DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}", ApplyFormatInEditMode = true)]
        [Display(Name = "ECI Referred Date")]
        public DateTime ECIReferredDate { get; set; }

        public List<ClientInsurance> clientInsurance { get; set; }


        public List<Family> clientFamily { get; set; }
        public Family guardian { get; set; }


        public List<Staff> clientStaff { get; set; }
        public bool interpreterNeeded { get; set; }

        [Display(Name = "Case Manager")]
        public Staff caseManager { get; set; }

        [Display(Name = "Case Manager")]
        public int caseManagerID { get; set; }

        [Display(Name = "Intake Coordinator")]
        public Staff intakeCoordinator { get; set; }

        [Display(Name = "Intake Coordinator")]
        public int intakeCoordinatorID { get; set; }

        [Display(Name = "Service Coordinator")]
        public Staff serviceCoordinator { get; set; }

        [Display(Name = "Service Coordinator")]
        public int serviceCoordinatorID { get; set; }



        [Display(Name = "Diagnosis")]
        public List<Diagnosis> clientDiagnosis { get; set; }



        [Display(Name = "Comments")]
        public List<Comments> clientComments { get; set; }



        [Display(Name = "Physician")]
        public List<Physician> clientPhysicians { get; set; }
        public List<Referral> clientReferrals { get; set; }



        [Display(Name = "Deleted")]
        public bool deleted { get; set; }



        // Checks for inserting newly referred patient.
        public bool insertReferralComplete { get; set; }
        public bool insertFamilyComplete { get; set; }
        public bool insertClientDetailsComplete { get; set; }
        public bool insertClientComplete { get; set; }


        /// <summary>
        /// Default constructor for client, so no null values are returned on initial views.
        /// </summary>
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

            // Referral
            referralSource = "";
            agencyFrom = "";

            // Demographics
            firstName = "";
            middleInitial = "";
            lastName = "";
            fullName = "";
            ageInMonths = 0;
            ssn = 0;

            // Address
            clientAddress = new Address();

            // Contact
            phone = new AdditionalContactInfoModel();

            clientDiagnosis = new List<Diagnosis>();

            clientFamily = new List<Family>();
            guardian = new Family();

            clientPhysicians = new List<Physician>();

            clientStaff = new List<Staff>();
            intakeCoordinator = new Models.Staff();
            serviceCoordinator = new Staff();
            caseManager = new Staff();

            clientInsurance = new List<ClientInsurance>();

            clientComments = new List<Comments>();

            clientReferrals = new List<Referral>();

            caseManager = new Staff();

            insertClientComplete = false;
            insertClientDetailsComplete = false;
            insertFamilyComplete = false;
            insertReferralComplete = false;
        }
    }
}