/***********************************************************************************************************
Description: 
	Physician Model
Author: 
	Tyrell Powers-Crane
Date: 
	7.14.2016
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
    /// <summary>
    /// Physician object which contains basic properties of each physician suce as title and first and last name.
    /// </summary>
    public class Physician
    {
        [Required]
        public int physicianID { get; set; }
        public string title { get; set; }
        public string firstName { get; set; }
        public string lastName { get; set; }
        public string fullName { get; set; }
        public List<Address> physicianAddrs { get; set; }
        public List<AdditionalContactInfoModel> physicianContacts { get; set; }
    }
}