using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace eciWEB2016.Models
{
    public class ReferralViewModel
    {
        public Referral referral { get; set; }
        public Client client { get; set; }

        public ReferralViewModel()
        {
            referral = new Referral();
            client = new Client();
        }
    }
}