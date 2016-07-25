using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace eciWEB2016.Models
{
    public class OfficeModel
    {
        public int officeID { get; set; }
        public string officeName { get; set; }
    }

    public class SexModel
    {
        public int sexID { get; set; }
        public string Sex { get; set; }
    }

    public class RaceModel
    {
        public int raceID { get; set; }
        public string race { get; set; }
    }

    public class EthnicityModel
    {
        public int ethnicityID { get; set; }
        public string ethnicity { get; set; }
    }
    
    public class ClientStatusModel
    {
        public int clientStatusID { get; set; }
        public string clientStatus { get; set; }
    }

    public class CommunicationPreferencesModel
    {
        public int communicationPreferencesID { get; set; }
        public string communicationPreferences { get; set; }
    }

    public class ContactTypeModel
    {
        public int contactTypeID { get; set; }
        public string contactType { get; set; }
    }

    public class StateCodeModel
    {
        public string stateCodeID { get; set; }
        public string stateCode { get; set; }
    }

    public class FamilyMemberTypeModel
    {
        public int familyMemberTypeID { get; set; }
        public string familyMemberType { get; set; }
    }

    public class PrimaryLanguageModel
    {
        public int primaryLanguageID { get; set; }
        public string primaryLanguage { get; set; }
    }

    public class SchoolInfoModel
    {
        public int schoolInfoID { get; set; }
        public string schoolInfo { get; set; }
    }
}