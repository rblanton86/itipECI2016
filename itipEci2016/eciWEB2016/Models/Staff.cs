﻿/***********************************************************************************************************
Description: 
	Staff Model
Author: 
	Jennifer M. Graves
Date: 
	06-21-2016
Change History:
	
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
        [Required]
        public int staffID { get; set; }
        public string firstName { get; set; }
        public string lastName { get; set; }
        public string middleInitial { get; set; }
        public string fullName { get; set; }
        public string staffAltID { get; set; }
        public bool deleted { get; set; }
        public int additionalContactInfoID { get; set; }
        public string additionalContactInfo { get; set; }
        public int addressesID { get; set; }
        public string address1 { get; set; }
        public string address2 { get; set; }
        public string addressType { get; set; }
        public string city { get; set; }
        public string state { get; set; }
        public int zip { get; set; }
        public string county { get; set; }
        public string mapsco { get; set; }
        public bool addrDeleted { get; set; }
        public Address staffAddress { get; set; }
        public AdditionalContactInfoModel staffContact { get; set; }
        public string memberType { get; set; }
        public string staffType { get; set; }
        public int staffTypeID { get; set; }
        public DateTime DOB { get; set; }
        public int SSN { get; set; }
        public bool handicapped { get; set; }

        
       //TODO: add staff home, cell, work...remove phone....probably aci table
    }
}