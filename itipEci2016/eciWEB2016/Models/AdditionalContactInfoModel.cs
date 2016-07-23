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
    public class AdditionalContactInfoModel
    {
        public AdditionalContactInfoModel()
        {
            additionalContactInfoID = 0;
            memberTypeID = 0;
            memberType = "";
            additionalContactInfoTypeID = 1;
            additionalContactInfoType = "";
            additionalContactInfo = "";
        }
        
        public int additionalContactInfoID { get; set; }
        public int memberTypeID { get; set; }
        public string memberType { get; set; }
        public int additionalContactInfoTypeID { get; set; }
        [Display(Name = "Contact Type")]
        public string additionalContactInfoType { get; set; }
        public string additionalContactInfo { get; set; }
        public bool deleted { get; set; }
    }
}