/***********************************************************************************************************
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
        public virtual string staffID { get; set; }
        public string firstName { get; set; }
        public string lastName { get; set; }
        public string fullName { get; set; }
        public string staffAltID { get; set; }
        public bool deleted { get; set; }
        public int phone { get; set; }
        public string addressesID { get; set; }
        public string address1 { get; set; }
        public string address2 { get; set; }
        public string city { get; set; }
        public string state { get; set; }
        public string zip { get; set; }
        public string memberType { get; set; }
        public string staffType { get; set; }
        public int staffTypeID { get; set; }

        //TODO: add staff middle initital
       //TODO: add staff dob 
       //TODO: add staff ssn
       //TODO: add staff home, cell, work...remove phone....probably aci table
    }
}