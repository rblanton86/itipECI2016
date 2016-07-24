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
    public class TimeDetailModel
    {
        public int timeDetailID { get; set; }
        public int timeHeaderID { get; set; }
        public int clientID { get; set; }
        public decimal actualTime { get; set; }
        public string eciCode { get; set; }
        public string insuranceDesignation { get; set; }
        public string cptCode { get; set; }
        public decimal insuranceTime { get; set; }
        public string placeOfService { get; set; }
        public string tcm { get; set; }
        public string canceled { get; set; }
        public DateTime updDate { get; set; }
        public bool deleted { get; set; }

    }

    public class TimeHeaderModel
    {
        public int timeHeaderID { get; set; }
        public int staffID { get; set; }
        public string weekEnding { get; set; }
        public bool deleted { get; set; }
        public List<TimeDetailModel> TimeDetails { get; set; }
    }
}