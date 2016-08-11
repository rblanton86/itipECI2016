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

        //gets staff members time sheet headers from the database
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
                               deleted = drRow.Field<bool>("deleted"),
                               TimeDetails = new List<TimeDetailModel>()
                           }).ToList();

            return headers;

        }

        //gets staff member's time sheet details from the database
        public List<TimeDetailModel> GetTimeSheet(int timeHeaderID)
        {
            DbCommand dbCommand = db.GetStoredProcCommand("get_TimeDetail");
            db.AddInParameter(dbCommand, "timeHeaderID", DbType.Int32, timeHeaderID);
            // db.AddInParameter(dbCommand, "@parameterName", DbType.TypeName, variableName);

            DataSet ds = db.ExecuteDataSet(dbCommand);

            var details = (from drRow in ds.Tables[0].AsEnumerable()
                        select new TimeDetailModel()
                        {
                        actualTime = drRow.Field<decimal>("actualTime"),
                        insuranceTime = drRow.Field<decimal>("insuranceTime"),
                        placeOfService = drRow.Field<string>("placeOfService"),
                        canceled = drRow.Field<string>("canceled"),
                        deleted = drRow.Field<bool>("deleted")
                    }).ToList();

            return details;
        }


        //insert time header
        public string insertTimeHeader(TimeHeaderModel model)
        {
            try
            {

                DbCommand dbCommand = db.GetStoredProcCommand("ins_TimeHeader");
                db.AddInParameter(dbCommand, "staffID", DbType.Int32, model.staffID);
                db.AddInParameter(dbCommand, "weekEnding", DbType.String, model.weekEnding);

                db.ExecuteNonQuery(dbCommand);

                return "success";
            }
            catch
            {
                return "fail";
            }
        }


        public string insertTimeDetail(TimeDetailModel model)
        {
            try
            {

                DbCommand dbCommand = db.GetStoredProcCommand("ins_TimeDetails");
                db.AddInParameter(dbCommand, "timeHeaderID", DbType.Int32, model.timeHeaderID);
                db.AddInParameter(dbCommand, "actualTime", DbType.Decimal, model.actualTime);
                db.AddInParameter(dbCommand, "insuranceTime", DbType.Decimal, model.insuranceTime);
                db.AddInParameter(dbCommand, "placeOfService", DbType.String, model.placeOfService);
                db.AddInParameter(dbCommand, "canceled", DbType.Boolean, model.canceled);

                db.ExecuteNonQuery(dbCommand);

                return "success";
            }
            catch
            {
                return "fail";
            }
        }

    }
}