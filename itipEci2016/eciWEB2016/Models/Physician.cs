using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace eciWEB2016.Models
{
    public class Physician
    {
        string title { get; set; }
        string firstName { get; set; }
        string lastName { get; set; }
        List<Address> physicianAddrs { get; set; }
        List<AdditionalContactInfoModel> phycisianContacts { get; set; }
    }
}