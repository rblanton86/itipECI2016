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
                               fullName = drRow.Field<string>("firstName") + " " + drRow.Field<string>("lastName"),
                               clientID = drRow.Field<int>("clientID"),
                               altID = drRow.Field<string>("altID")
                           }).ToList();

            return clients;
        }

        public Client GetClient(int thisClientID)
        {
            thisClientID = 1;

            // Creates empty client to assign values.
            Client currentClient = new Client();

            // Accesses stored proc on SQL server.
            DbCommand get_ClientByID = db.GetStoredProcCommand("get_ClientByID");

            // Assigns the clientID as a parameter to add in to the database command..
            db.AddInParameter(get_ClientByID, "clientID", DbType.Int32, thisClientID);

            // Executes the database command, returns values as a DataSet.
            DataSet clientDataSet = db.ExecuteDataSet(get_ClientByID);


            // Loads clientData into an Enumerable list.
            var thisClient = (from drRow in clientDataSet.Tables[0].AsEnumerable()
                             select new Client()
                             {
                                 clientID = drRow.Field<int>("clientID"),
                                 firstName = drRow.Field<string>("firstName"),
                                 lastName = drRow.Field<string>("lastName"),
                                 middleInitial = drRow.Field<string>("middleInitial"),
                                 fullName = drRow.Field<string>("firstName" + "lastName"),
                                 ssn = drRow.Field<int>("ssn"),
                                 referralSource = drRow.Field<string>("referralSource"),
                                 dob = drRow.Field<DateTime>("dob").Date,
                                 altID = drRow.Field<string>("altID"),
                                 deleted = drRow.Field<bool>("deleted")
                             });

            // Returns the currentClient with data assigned.
            return currentClient;
        }

        public bool UpdateClient(Client thisClient)
        {
            DbCommand upd_Clients = db.GetStoredProcCommand("upd_Clients");

            // db.AddInParameter(dbCommand, "@parameterName", DbType.TypeName, variableName);
            db.AddInParameter(upd_Clients, "@clientsID", DbType.Int32, thisClient.clientID);
            db.AddInParameter(upd_Clients, "@raceID", DbType.Int32, thisClient.raceID);
            db.AddInParameter(upd_Clients, "@ethnicityID", DbType.Int32, thisClient.ethnicityID);
            db.AddInParameter(upd_Clients, "@clientStatusID", DbType.Int32, thisClient.clientStatusID);
            db.AddInParameter(upd_Clients, "@diagnosisID", DbType.Int32, thisClient.diagnosisID);
            db.AddInParameter(upd_Clients, "@primaryLanguageID", DbType.Int32, thisClient.primaryLanguageID);
            db.AddInParameter(upd_Clients, "@schoolInfoID", DbType.Int32, thisClient.schoolInfoID);
            db.AddInParameter(upd_Clients, "@commentsID", DbType.Int32, thisClient.commentsID);
            db.AddInParameter(upd_Clients, "@insuranceAuthID", DbType.Int32, thisClient.insuranceAuthID);
            db.AddInParameter(upd_Clients, "@communicationPreferencesID", DbType.Int32, thisClient.communicationPreferencesID);
            db.AddInParameter(upd_Clients, "@firstName", DbType.String, thisClient.firstName);
            db.AddInParameter(upd_Clients, "@lastName", DbType.String, thisClient.lastName);
            db.AddInParameter(upd_Clients, "@dob", DbType.Date, thisClient.dob);
            db.AddInParameter(upd_Clients, "@ssn", DbType.Int32, thisClient.ssn);
            db.AddInParameter(upd_Clients, "@referralSource", DbType.String, thisClient.referralSource);

            db.ExecuteNonQuery(upd_Clients);

            DbCommand upd_Addresses = db.GetStoredProcCommand("upd_Addresses");

            db.AddInParameter(upd_Addresses, "@addressesID", DbType.Int32, thisClient.clientAddress.addressesID);
            db.AddInParameter(upd_Addresses, "@addressTypeID", DbType.Int32, thisClient.clientAddress.addressTypeID);
            db.AddInParameter(upd_Addresses, "@address1", DbType.String, thisClient.clientAddress.address1);
            db.AddInParameter(upd_Addresses, "@address2", DbType.String, thisClient.clientAddress.address2);
            db.AddInParameter(upd_Addresses, "@city", DbType.String, thisClient.clientAddress.city);
            db.AddInParameter(upd_Addresses, "@st", DbType.String, thisClient.clientAddress.state);
            db.AddInParameter(upd_Addresses, "@zip", DbType.Int32, thisClient.clientAddress.zip);

            db.ExecuteNonQuery(upd_Addresses);

            DbCommand upd_Family = db.GetStoredProcCommand("upd_Family");

            db.AddInParameter(upd_Family, "@familyMemberID", DbType.Int32, thisClient.clientFamily.familyMemberID);
            db.AddInParameter(upd_Family, "@familyMemberTypeID", DbType.Int32, thisClient.clientFamily.familyMemberTypeID);
            db.AddInParameter(upd_Family, "@firstName", DbType.String, thisClient.clientFamily.firstName);
            db.AddInParameter(upd_Family, "@lastName", DbType.String, thisClient.clientFamily.lastName);
            db.AddInParameter(upd_Family, "@isGuardian", DbType.Boolean, thisClient.clientFamily.isGuardian);

            db.ExecuteNonQuery(upd_Family);

            return true;
        }
    }
}