using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace eciWEB2016.Models
{
    public class Comments
    {
        public int commentsID { get; set; }
        public string comments { get; set; }
        public bool deleted { get; set; }
    }
}