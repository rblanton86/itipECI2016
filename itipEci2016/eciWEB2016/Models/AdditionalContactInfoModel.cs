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
        public int additionalContactInfoID { get; set; }
        public int memberTypeID { get; set; }
        public int additionalContactInfoTypeID { get; set; }
        public string additionalContactInfo { get; set; }
        public bool deleted { get; set; }
    }
}