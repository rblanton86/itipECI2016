using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Configuration;
using System.Data;
using System.Data.Common;
using System.Text;
using System.Xml;

using Microsoft.Practices.EnterpriseLibrary.Common.Configuration;
using Microsoft.Practices.EnterpriseLibrary.Data;
using Microsoft.Practices.EnterpriseLibrary.Data.Sql;

using eciWEB2016.Models;

namespace eciWEB2016.Controllers.DataControllers
{
    public class ReferralDataController
    {
        public static SqlDatabase db;

        public ReferralDataController()
        {
            if (db == null)
            {
                db = new SqlDatabase(WebConfigurationManager.ConnectionStrings["eciConnectionString"].ToString());
            }
        }

        public List<Referral> GetAllReferralSources()
        {
            DbCommand dbCommand = db.GetStoredProcCommand("get_ReferralSource");

            DataSet ds = db.ExecuteDataSet(dbCommand);

            var referralSource = (from drRow in ds.Tables[0].AsEnumerable()
                           select new Referral()
                           {
                               referralSource = drRow.Field<string>("referralSource"),
                               referralSourceType = drRow.Field<string>("referralSourceType")
                           }).ToList();

            return referralSource;
        }
    }
}