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
using System.Web.Mvc;
using System.Globalization;

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

        public List<Client> GetListClients()
        {
            // Readies stored proc from server.
            DbCommand dbCommand = db.GetStoredProcCommand("get_AllClients");

            // Executes stored proc to return values into a DataSet.
            DataSet ds = db.ExecuteDataSet(dbCommand);

            // Takes values from DataSet and places results in a SelectList.
            // This select list is used for the search autocomplete boxes on the client_update page.
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

            // Executes the database command, returns values as a DataSet.
            using (get_ClientByID)
            {
                using(IDataReader clientReader = db.ExecuteReader(get_ClientByID))
                {
                    if (clientReader.Read())
                    {
                        int ordinal = clientReader.GetOrdinal("clientID");
                        currentClient.clientID = clientReader.IsDBNull(ordinal) ? 0 : clientReader.GetInt32(ordinal);

                        ordinal = clientReader.GetOrdinal("altID");
                        currentClient.altID = clientReader.IsDBNull(ordinal) ? " " : clientReader.GetString(ordinal);

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

                        ordinal = clientReader.GetOrdinal("officeName");
                        currentClient.office = clientReader.IsDBNull(ordinal) ? " " : clientReader.GetString(ordinal);

                        // Creates blank Client Address. Each client has only one address.
                        Address clientAddr = new Address();

                            ordinal = clientReader.GetOrdinal("address1");
                            clientAddr.address1 = clientReader.IsDBNull(ordinal) ? " " : clientReader.GetString(ordinal);

                            ordinal = clientReader.GetOrdinal("address2");
                            clientAddr.address2 = clientReader.IsDBNull(ordinal) ? " " : clientReader.GetString(ordinal);

                            ordinal = clientReader.GetOrdinal("city");
                            clientAddr.city = clientReader.IsDBNull(ordinal) ? " " : clientReader.GetString(ordinal);

                            ordinal = clientReader.GetOrdinal("st");
                            clientAddr.state = clientReader.IsDBNull(ordinal) ? " " : clientReader.GetString(ordinal);

                            ordinal = clientReader.GetOrdinal("zip");
                            clientAddr.zip = clientReader.IsDBNull(ordinal) ? 0 : clientReader.GetInt32(ordinal);

                            ordinal = clientReader.GetOrdinal("mapsco");
                            clientAddr.mapsco = clientReader.IsDBNull(ordinal) ? " " : clientReader.GetString(ordinal);

                        // Assigns obtained address into current client.
                        currentClient.clientAddress = clientAddr;
                    }
                    else
                    {
                        

                        int ordinal = clientReader.GetOrdinal("clientID");
                        currentClient.clientID = clientReader.IsDBNull(ordinal) ? 0 : clientReader.GetInt32(ordinal);
                    }
                }
            }

            // Accesses stored proc on SQL server.
            DbCommand get_DiagnosisByClientID = db.GetStoredProcCommand("get_DiagnosisByClientID");

            // Assigns the clientID as a parameter to add in to the database command.
            var diagnosisByClientIDParameter = get_DiagnosisByClientID.CreateParameter();
            diagnosisByClientIDParameter.ParameterName = "@clientID";
            diagnosisByClientIDParameter.Value = thisClientID;
            get_DiagnosisByClientID.Parameters.Add(diagnosisByClientIDParameter);

            // Executes the database command, returns values as a DataSet.
            DataSet dds = db.ExecuteDataSet(get_DiagnosisByClientID);

            // TODO: Jen - Finish all fields.
            List<Diagnosis> DiagnosisList = (from drRow in dds.Tables[0].AsEnumerable()
                                          select new Diagnosis()
                                          {
                                              isPrimary = drRow.Field<bool>("isPrimary"),
                                              diagnosisCode = drRow.Field<string>("diagnosisCode"),
                                              diagnosisDescription = drRow.Field<string>("diagnosis"),
                                              diagnosisType = drRow.Field<string>("diagnosisType"),
                                              diagnosisFrom = Convert.ToDateTime(drRow.Field<DateTime?>("diagnosis_From")),
                                              diagnosisTo = Convert.ToDateTime(drRow.Field<DateTime?>("diagnosis_To"))

                                          }).ToList();

            // Inserts the created list of diagnoses into the client.
            currentClient.clientDiagnosis = DiagnosisList;


            // Accesses stored proc on SQL server.
            DbCommand get_FamilyByClientID = db.GetStoredProcCommand("get_FamilyByClientID");

            // Assigns the clientID as a parameter to add in to the database command.
            var familyByClientIDParameter = get_FamilyByClientID.CreateParameter();
            familyByClientIDParameter.ParameterName = "@clientID";
            familyByClientIDParameter.Value = thisClientID;
            get_FamilyByClientID.Parameters.Add(familyByClientIDParameter);

            // Executes the database command, returns values as a DataSet.
            DataSet fds = db.ExecuteDataSet(get_FamilyByClientID);


            // TODO: Jen - Go to dbsolution and insert linking table values for LnkClientFamily so that you can return sample data here.
            // TODO: Jen - Go to dbsolution and insert linking table values for LnkFamilyAddresses so that you can return address data here.
            // TODO: Jen - Finish all fields.
            List<Family> FamilyList = (from drRow in fds.Tables[0].AsEnumerable()
                                             select new Family()
                                             {


                                             }).ToList();

            // Inserts the created list of family into the client.
            currentClient.clientFamily = FamilyList;


            // Accesses stored proc on SQL server.
            DbCommand get_PhysicianByClientID = db.GetStoredProcCommand("get_PhysicianByClientID");

            // Assigns the clientID as a parameter to add in to the database command.
            var physicianByClientIDParameter = get_PhysicianByClientID.CreateParameter();
            physicianByClientIDParameter.ParameterName = "@clientID";
            physicianByClientIDParameter.Value = thisClientID;
            get_PhysicianByClientID.Parameters.Add(physicianByClientIDParameter);

            // Executes the database command, returns values as a DataSet.
            DataSet pds = db.ExecuteDataSet(get_PhysicianByClientID);

            // TODO: Create Physician model, add List<Physician> to Client Model.
            // TODO: Create physician by ClientID stored procedure.
            // TODO: Jen - Finish all fields.
            List<Physician> PhysicianList = (from drRow in fds.Tables[0].AsEnumerable()
                                       select new Physician()
                                       {


                                       }).ToList();

            // Inserts the created list of physicians into the client.
            currentClient.clientPhysician = PhysicianList;


            // Accesses stored proc on SQL server.
            DbCommand get_StaffByClientID = db.GetStoredProcCommand("get_StaffByClientID");

            // Assigns the clientID as a parameter to add in to the database command.
            var staffByClientIDParameter = get_StaffByClientID.CreateParameter();
            staffByClientIDParameter.ParameterName = "@clientID";
            staffByClientIDParameter.Value = thisClientID;
            get_StaffByClientID.Parameters.Add(staffByClientIDParameter);

            // Executes the database command, returns values as a DataSet.
            DataSet sds = db.ExecuteDataSet(get_StaffByClientID);

            // TODO: Jen - Finish all fields.
            List<Staff> StaffList = (from drRow in fds.Tables[0].AsEnumerable()
                                             select new Staff()
                                             {


                                             }).ToList();

            // TODO: Create staff by ClientID stored procedure.
            // Inserts the created list of staff into the client.
            currentClient.clientStaff = StaffList;

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

            // TODO: Jen, find out what error is causing this and fix it.

            //db.AddInParameter(upd_Family, "@familyMemberID", DbType.Int32, thisClient.clientFamily.familyMemberID);
            //db.AddInParameter(upd_Family, "@familyMemberTypeID", DbType.Int32, thisClient.clientFamily.familyMemberTypeID);
            //db.AddInParameter(upd_Family, "@firstName", DbType.String, thisClient.clientFamily.firstName);
            //db.AddInParameter(upd_Family, "@lastName", DbType.String, thisClient.clientFamily.lastName);
            //db.AddInParameter(upd_Family, "@isGuardian", DbType.Boolean, thisClient.clientFamily.isGuardian);

            db.ExecuteNonQuery(upd_Family);

            return true;
        }
    }
}