﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace eciWEB2016.Models
{
    public class Family
    {
        [Required]
        public int familyMemberID { get; set; }
        public string familyMemberType { get; set; }
        public string firstName { get; set; }
        public string lastName { get; set; }
        public DateTime dob { get; set; }
        public string sex { get; set; }
        public string race { get; set; }
        public bool isGuardian { get; set; }
        public string occupation { get; set; }
        public string employer { get; set; }
        public List<AdditionalContactInfoModel> familyContact { get; set; }
        public List<Address> familyAddrs { get; set; }
    }
}