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
    public class ClientDataController
    {
        public static SqlDatabase db;

        public ClientDataController()
        {
            if(db == null)
            {
                db = new SqlDatabase(WebConfigurationManager.ConnectionStrings["eciConnectionString"].ToString());
            }
        }

        public List<Client> GetAllClients()
        {
            DbCommand dbCommand = db.GetStoredProcCommand("get_AllClients");

            // db.AddInParameter(dbCommand, "@parameterName", DbType.TypeName, variableName);

            DataSet ds = db.ExecuteDataSet(dbCommand);

            var clients = (from drRow in ds.Tables[0].AsEnumerable()
                           select new Client()
                           {
                               firstName = drRow.Field<string>("firstName"),
                               lastName = drRow.Field<string>("lastName"),
                               clientID = drRow.Field<int>("clientID"),
                               altID = drRow.Field<string>("altID")
                           }).ToList();

            return clients;


        }
    }
}