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
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace eciWEB2016.Models
{
    public class Staff
    {
        public int staffID { get; set; }
        public string firstName { get; set; }
        public string lastName { get; set; }
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
    }
}