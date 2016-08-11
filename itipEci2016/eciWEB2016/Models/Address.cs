using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace eciWEB2016.Models
{
    /// <summary>
    /// Address object which contains properties relating to any kind of address.
    /// </summary>
    public class Address
    {
        public int addressesID { get; set; }
        public string addressesType { get; set; }
        public int addressTypeID { get; set; }
        [Display(Name = "Address 1")]
        [Required(ErrorMessage = "Please enter an address.")]
        public string address1 { get; set; }
        [Display(Name = "Address 2")]
        public string address2 { get; set; }
        [Display(Name = "City")]
        [Required(ErrorMessage = "Please enter a city.")]
        public string city { get; set; }
        [Display(Name = "State")]
        [Required(ErrorMessage = "Please enter a state.")]
        public string state { get; set; }
        [Display(Name = "Zip Code")]
        [Required(ErrorMessage = "Please enter a zip code.")]
        public int zip { get; set; }
        [Display(Name = "County")]
        [Required]
        public string county { get; set; }
        [Display(Name = "Mapsco")]
        public string mapsco { get; set; }
        public bool deleted { get; set; }

        /// <summary>
        /// Default constructor for Address object, contains empty values and prevents errors on initial pageviews with blank address objects.
        /// </summary>
        public Address()
        {
            addressTypeID = 1;
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