using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace eciWEB2016.Models
{
    public class Address
    {
        [Display(Name = "Address ID")]
        public int addressesID { get; set; }
        [Display(Name = "Address Type")]
        public string addressType { get; set; }
        [Display(Name = "Address 1")]
        public string address1 { get; set; }
        [Display(Name = "Address 2")]
        public string address2 { get; set; }
        [Display(Name = "City")]
        public string city { get; set; }
        [Display(Name = "State")]
        public string state { get; set; }
        [Display(Name = "Zip Code")]
        public int zip { get; set; }
        [Display(Name = "County")]
        public string county { get; set; }
        [Display(Name = "MAPSCO")]
        public string mapsco { get; set; }
        [Display(Name = "Deleted")]
        public bool deleted { get; set; }

        public Address()
        {
            address1 = "";
            address2 = "";
            city = "";
            state = "";
            zip = 0;
            county = "";
            mapsco = "";
        }
    }
}