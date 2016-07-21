using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace eciWEB2016.Models
{
    public class Address
    {
        public int addressesID { get; set; }
        public string addressesType { get; set; }
        public int addressTypeID { get; set; }
        public string address1 { get; set; }
        public string address2 { get; set; }
        public string city { get; set; }
        public string state { get; set; }
        public int zip { get; set; }
        public string county { get; set; }
        public string mapsco { get; set; }
        public bool deleted { get; set; }
    }
}