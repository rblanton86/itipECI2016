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

        public bool UpdateClient(Client thisClient)
        {
            DbCommand dbCommand = db.GetStoredProcCommand("upd_Clients");

            // db.AddInParameter(dbCommand, "@parameterName", DbType.TypeName, variableName);
            db.AddInParameter(dbCommand, "@clientsID", DbType.Int32, thisClient.clientID);
            db.AddInParameter(dbCommand, "@raceID", DbType.Int32, thisClient.raceID);
            db.AddInParameter(dbCommand, "@ethnicityID", DbType.Int32, thisClient.ethnicityID);
            db.AddInParameter(dbCommand, "@clientStatusID", DbType.Int32, thisClient.clientStatusID);
            db.AddInParameter(dbCommand, "@diagnosisID", DbType.Int32, thisClient.diagnosisID);
            db.AddInParameter(dbCommand, "@primaryLanguageID", DbType.Int32, thisClient.primaryLanguageID);
            db.AddInParameter(dbCommand, "@schoolInfoID", DbType.Int32, thisClient.schoolInfoID);
            db.AddInParameter(dbCommand, "@commentsID", DbType.Int32, thisClient.commentsID);
            db.AddInParameter(dbCommand, "@insuranceAuthID", DbType.Int32, thisClient.insuranceAuthID);
            db.AddInParameter(dbCommand, "@communicationPreferencesID", DbType.Int32, thisClient.communicationPreferencesID);
            db.AddInParameter(dbCommand, "@firstName", DbType.String, thisClient.firstName);
            db.AddInParameter(dbCommand, "@lastName", DbType.String, thisClient.lastName);
            db.AddInParameter(dbCommand, "@dob", DbType.Date, thisClient.dob);
            db.AddInParameter(dbCommand, "@ssn", DbType.Int32, thisClient.ssn);
            db.AddInParameter(dbCommand, "@referralSource", DbType.String, thisClient.referralSource);

            db.ExecuteNonQuery(dbCommand);

            dbCommand = db.GetStoredProcCommand("upd_Addresses");

            db.AddInParameter(dbCommand, "@addressesID", DbType.Int32, thisClient.clientAddress.addressesID);
            db.AddInParameter(dbCommand, "@addressTypeID", DbType.Int32, thisClient.clientAddress.addressTypeID);
            db.AddInParameter(dbCommand, "@address1", DbType.String, thisClient.clientAddress.address1);
            db.AddInParameter(dbCommand, "@address2", DbType.String, thisClient.clientAddress.address2);
            db.AddInParameter(dbCommand, "@city", DbType.String, thisClient.clientAddress.city);
            db.AddInParameter(dbCommand, "@st", DbType.String, thisClient.clientAddress.state);
            db.AddInParameter(dbCommand, "@zip", DbType.Int32, thisClient.clientAddress.zip);

            db.ExecuteNonQuery(dbCommand);

            dbCommand = db.GetStoredProcCommand("upd_FamilyMember");

            return true;
        }
    }
}