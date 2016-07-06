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
    public class TimeSheetDataController
    {
        public static SqlDatabase db;

        public TimeSheetDataController()
        {
            if (db == null)
            {
                db = new SqlDatabase(WebConfigurationManager.ConnectionStrings["eciConnectionString"].ToString());
            }
        }

        public List<TimeHeaderModel> GetTimeHeaders(int staffID)
        {
            DbCommand dbCommand = db.GetStoredProcCommand("get_TimeHeader");
            db.AddInParameter(dbCommand, "staffID", DbType.Int32, staffID);
            // db.AddInParameter(dbCommand, "@parameterName", DbType.TypeName, variableName);

            DataSet ds = db.ExecuteDataSet(dbCommand);

            var headers = (from drRow in ds.Tables[0].AsEnumerable()
                           select new TimeHeaderModel()
                           {
                               timeHeaderID = drRow.Field<int>("timeHeaderID"),
                               staffID = drRow.Field<int>("staffID"),
                               weekEnding = drRow.Field<string>("weekEnding"),
                               deleted = drRow.Field<bool>("deleted")
                           }).ToList();

            return headers;

        }
    }
}