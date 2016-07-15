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
    public class Physician
    {
        [Required]
        int physicianID { get; set; }
        string title { get; set; }
        string firstName { get; set; }
        string lastName { get; set; }
        List<Address> physicianAddrs { get; set; }
        List<AdditionalContactInfoModel> physicianContacts { get; set; }
    }
}