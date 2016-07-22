using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.Mvc;
using eciWEB2016.Models;
using Microsoft.Practices.EnterpriseLibrary.Data.Sql;

namespace eciWEB2016.Controllers.DataControllers
{
    public class DiagnosisDataController
    {
        public static SqlDatabase db;

        public DiagnosisDataController()
        {
            if (db == null)
            {
                db = new SqlDatabase(WebConfigurationManager.ConnectionStrings["eciConnectionString"].ToString());
            }
        }

        // GET: DiagnosisTypes
        public IEnumerable<DiagnosisTypes> GetDiagnosisTypes()
        {
            DbCommand get_diagnosisTypes = db.GetStoredProcCommand("get_diagnosisTypes");

            DataSet ds = db.ExecuteDataSet(get_diagnosisTypes);
        }
    }
}