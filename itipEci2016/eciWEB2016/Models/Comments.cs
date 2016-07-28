using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace eciWEB2016.Models
{
    /// <summary>
    /// Comments object which contains properties related to each comment object.
    /// </summary>
    public class Comments
    {
        public int commentsID { get; set; }
        public int commentsTypeID { get; set; }
        public string commentsType { get; set; }
        public string comments { get; set; }
        public bool deleted { get; set; }
    }
}