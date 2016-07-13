using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using eciWEB2016.Models;
using System.Data;
using System.Data.Common;
using eciWEB2016.Controllers.DataControllers;
using Microsoft.Practices.EnterpriseLibrary.Common.Configuration;
using Microsoft.Practices.EnterpriseLibrary.Data;
using Microsoft.Practices.EnterpriseLibrary.Data.Sql;
using System.Web.Configuration;

using eciWEB2016.Models;

namespace eciWEB2016.Class
{
    public class AddContactInfo
    {
        public List<AdditionalContactInfoModel> GetAdditionalContactInfoModelesByDataSet(DataSet ds)
        {

            // Stores a list of all addresses belonging to the family member.
            List<AdditionalContactInfoModel> AdditionalContactInfoModelList = (from drRow in ds.Tables[0].AsEnumerable()
                                         select new AdditionalContactInfoModel()
                                         {
                                             additionalContactInfo = drRow.Field<string>("additionalContactInfo")

                                         }).ToList();
            return AdditionalContactInfoModelList;
        }
    }
}