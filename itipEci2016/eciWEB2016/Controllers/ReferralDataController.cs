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
using System.Web.Mvc;

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

        public List<ReferralSource> GetAllReferralSources()
        {
            DbCommand dbCommand = db.GetStoredProcCommand("get_ReferralSource");

            DataSet ds = db.ExecuteDataSet(dbCommand);

            var referralSource = (from drRow in ds.Tables[0].AsEnumerable()
                                  select new ReferralSource()
                                  {
                                      referralSourceID = drRow.Field<int>("referralSourceID"),
                                      referralSourceName = drRow.Field<string>("referralSource"),
                                      referralSourceType = drRow.Field<string>("referralSourceType")

                                  }).ToList();

            return referralSource;
        }

        public ReferralSource GetReferralSourceDetails(ReferralSource thisReferralSource)
        {
            return thisReferralSource;
        }

        public bool UpdateReferralSource(ReferralSource thisReferralSource)
        {
            DbCommand dbCommand = db.GetStoredProcCommand("upd_ReferralSource");

            // db.AddInParameter(dbCommand, "@parameterName", DbType.TypeName, variableName);

            //db.AddInParameter(dbCommand, "@referralSourceID", DbType.Int32, thisReferralSource.referralSourceID);
            //db.AddInParameter(dbCommand, "@additionalContactInfoID", DbType.Int32, thisReferralSource.additionalContactInfoID);
            //db.AddInParameter(dbCommand, "@referralSourceTypeID", DbType.Int32, thisReferralSource.referralSourceTypeID);
            //db.AddInParameter(dbCommand, "@addressesID", DbType.Int32, thisReferralSource.referralSourceAddress.addressesID);
            //db.AddInParameter(dbCommand, "@referralSource", DbType.String, thisReferralSource.referralSource);

            return true;
        }
    }
}