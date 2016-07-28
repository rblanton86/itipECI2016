/***********************************************************************************************************
Description: 
	Staff Model
Author: 
	Jennifer M. Graves
Date: 
	06-21-2016
Change History:
	07/28/2016: JMG - Added List<AdditionalContactInfo>.
************************************************************************************************************/

using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.ComponentModel.DataAnnotations;
using eciWEB2016.Controllers.DataControllers;

namespace eciWEB2016.Models
{
    public class Staff
    {

        public Staff()
        {
            firstName = "";
            lastName = "";
            middleInitial = "";
            fullName = "";
            staffAltID = "";
            deleted = false;
            sexID = 1;
            status = 1;
            addressesID = 1;
            memberType = "";
            memberTypeID = 3;
            staffTypeID = 1;
            DOB = (DateTime)System.Data.SqlTypes.SqlDateTime.MinValue;
            SSN = 1;
            handicapped = false;
            staffAddress = new Address();
            staffContact = new AdditionalContactInfoModel();
            staffContactList = new List<AdditionalContactInfoModel>();

        }
        [Required]
        public int staffID { get; set; }
        public string firstName { get; set; }
        public string lastName { get; set; }
        public string middleInitial { get; set; }
        public string fullName { get; set; }
        public string staffAltID { get; set; }
        public bool deleted { get; set; }
        public int sexID { get; set; }
        public int addressesID { get; set; }
        public Address staffAddress { get; set; }
        public AdditionalContactInfoModel staffContact { get; set; }
        public string memberType { get; set; }
        public int memberTypeID { get; set; }
        public string staffType { get; set; }
        public int staffTypeID { get; set; }
        [DataType(DataType.Date)]
        public DateTime DOB { get; set; }
        public int SSN { get; set; }
        public bool handicapped { get; set; }
        public int status { get; set; }
        public List<TimeHeaderModel> timeHeaders { get; set; }
        public List<AdditionalContactInfoModel> staffContactList { get; set; }

        
       //TODO: add staff home, cell, work...remove phone....probably aci table
    }
}