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
using System.Data.SqlClient;

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
            // Creates empty client to assign values.
            Client currentClient = new Client();

            // Accesses stored proc on SQL server.
            DbCommand get_ClientByID = db.GetStoredProcCommand("get_ClientByID");

            // Assigns the clientID as a parameter to add in to the database command..
            var clientIDParameter = get_ClientByID.CreateParameter();
            clientIDParameter.ParameterName = "@clientID";
            clientIDParameter.Value = thisClientID;
            get_ClientByID.Parameters.Add(clientIDParameter);

            //// Executes the database command, returns values as a DataSet.
            using (get_ClientByID)
            {
                using(IDataReader clientReader = db.ExecuteReader(get_ClientByID))
                {
                    if (clientReader.Read())
                    {
                        int ordinal = clientReader.GetOrdinal("clientID");
                        currentClient.clientID = clientReader.IsDBNull(ordinal) ? 0 : clientReader.GetInt32(ordinal);

                        ordinal = clientReader.GetOrdinal("firstName");
                        currentClient.firstName = clientReader.IsDBNull(ordinal) ? " " : clientReader.GetString(ordinal);

                        ordinal = clientReader.GetOrdinal("lastName");
                        currentClient.lastName = clientReader.IsDBNull(ordinal) ? " " : clientReader.GetString(ordinal);

                        currentClient.fullName = currentClient.firstName + " " + currentClient.lastName;

                        ordinal = clientReader.GetOrdinal("race");
                        currentClient.race = clientReader.IsDBNull(ordinal) ? " " : clientReader.GetString(ordinal);

                        ordinal = clientReader.GetOrdinal("ethnicity");
                        currentClient.ethnicity = clientReader.IsDBNull(ordinal) ? " " : clientReader.GetString(ordinal);

                        ordinal = clientReader.GetOrdinal("clientStatus");
                        currentClient.clientStatus = clientReader.IsDBNull(ordinal) ? " " : clientReader.GetString(ordinal);

                        ordinal = clientReader.GetOrdinal("sex");
                        currentClient.sex = clientReader.IsDBNull(ordinal) ? "F" : clientReader.GetString(ordinal);

                        ordinal = clientReader.GetOrdinal("dob");
                        currentClient.dob = clientReader.IsDBNull(ordinal) ? DateTime.Now : clientReader.GetDateTime(ordinal);

                        // Does the math to convert client's current age in months.
                        DateTime now = DateTime.Now;
                        TimeSpan timeSpan = now - currentClient.dob;
                        double ts = timeSpan.TotalDays;
                        double diff = (ts / 30);
                        currentClient.ageInMonths = Convert.ToInt32(diff);

                    }
                    else
                    {
                        return null;
                    }

                    //TODO: Jen - Go to sql and wrap null values to return a string with empty spaces.
                    //TODO: Jen - Continue this.
                    //TODO: Create unit tests to test this.
                }
            }

            return currentClient;
        }

        public bool UpdateClient(Client thisClient)
        {
            DbCommand upd_Clients = db.GetStoredProcCommand("upd_Clients");

            // db.AddInParameter(dbCommand, "@parameterName", DbType.TypeName, variableName);
            db.AddInParameter(upd_Clients, "@clientsID", DbType.Int32, thisClient.clientID);
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