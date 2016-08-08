using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace eciWEB2016.Models
{
    /// <summary>
    /// Family object which contains properties belonging to a family member or guardian.
    /// </summary>
    public class Family
    {
        public int familyMemberID { get; set; }
        public int memberTypeID { get; set; }
        public string memberType { get; set; }
        public int familyMemberTypeID { get; set; }
        [Display(Name = "Relationship")]
        public string familyMemberType { get; set; }
        [Display(Name = "First Name")]
        public string firstName { get; set; }
        [Display(Name = "Last Name")]
        public string lastName { get; set; }
        [DataType(DataType.Date)]
        [Display(Name = "Date of Birth")]
        public DateTime dob { get; set; }
        public int sexID { get; set; }
        public int raceID { get; set; }
        public bool isGuardian { get; set; }
        public string occupation { get; set; }
        public string employer { get; set; }
        public List<AdditionalContactInfoModel> familyContact { get; set; }
        public List<Address> familyAddressList { get; set; }
        public Address familyAddress { get; set; }

        /// <summary>
        /// Default constructor for a family member or guardian, initiates default values to prevent errors on views containing blank family members.
        /// </summary>
        public Family()
        {
            familyMemberID = 0;
            memberTypeID = 2;
            familyMemberTypeID = 1;
            familyMemberType = "";
            firstName = "";
            lastName = "";
            dob = (DateTime)System.Data.SqlTypes.SqlDateTime.MinValue;

            familyContact = new List<AdditionalContactInfoModel>();

            familyAddressList = new List<Address>();

            familyAddress = new Address();
        }
    }
}