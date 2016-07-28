using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace eciWEB2016.Models
{
    /// <summary>
    /// InsuranceAuthorization object which contains properties suce as date of authorization and type of authorization.
    /// </summary>
    public class InsuranceAuthorization
    {
        public int insuranceAuthID { get; set; }
        public string insuranceAuthorizationType { get; set; }

        [DataType(DataType.Date)]
        public DateTime authorizedFrom { get; set; }

        [DataType(DataType.Date)]
        public DateTime authorizedTo { get; set; }
        public bool deleted { get; set; }
        public List<Comments> insuranceAuthComments { get; set; }
    }
}