using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace eciWEB2016.Models
{
    public class Family
    {
        public int familyMemberID { get; set; }
        public int familyMemberTypeID { get; set; }
        public string firstName { get; set; }
        public string lastName { get; set; }
        public DateTime dob { get; set; }
        public int sexID { get; set; }
        public int raceID { get; set; }
        public Address familyAddress { get; set; }
        public bool isGuardian { get; set; }
        public string occupation { get; set; }
        public string employer { get; set; }
        public List<AdditionalContactInfoModel> familyContact { get; set; }
    }
}