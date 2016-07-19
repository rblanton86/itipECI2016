using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Configuration;
using System.Data;
using System.Data.Common;
using Microsoft.Practices.EnterpriseLibrary.Data.Sql;

using eciWEB2016.Models;
using eciWEB2016.Class;

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

            // Accesses stored proc on SQL server.
            DbCommand get_ClientByID = db.GetStoredProcCommand("get_ClientByID");
            db.AddInParameter(get_ClientByID, "clientID", DbType.Int32, thisClientID);

            // Stores client into a dataset.
            DataSet ds = db.ExecuteDataSet(get_ClientByID);

            // Takes values from DataSet and places results in a SelectList.
            // This select list is used for the search autocomplete boxes on the client_update page.
            DataRow dr = ds.Tables[0].Rows[0];

            // Creates current client and inputs values from dataset.
            Client currentClient = new Client()
            {
                clientID = thisClientID,
                altID = dr.Field<string>("altID"),
                firstName = dr.Field<string>("firstName"),
                lastName = dr.Field<string>("lastName"),
                fullName = dr.Field<string>("firstName")  + " " + dr.Field<string>("lastName"),
                raceID = dr.Field<int>("raceID"),
                ethnicityID = dr.Field<int>("ethnicityID"),
                clientStatusID = dr.Field<int>("clientStatusID"),
                sexID = dr.Field<int>("sexID"),
                dob = dr.Field<DateTime>("dob"),
                officeID = dr.Field<int>("officeID")
            };

            // Does the math to convert client's current age in months.
            DateTime now = DateTime.Now;
            TimeSpan timeSpan = now - currentClient.dob;
            double ts = timeSpan.TotalDays;
            double diff = (ts / 30);
            currentClient.ageInMonths = Convert.ToInt32(diff);

            // Creates blank Client Address. Each client has only one address.
            Addresses clientAddr = new Addresses();

            // Assigns obtained address into current client.
            currentClient.clientAddress = clientAddr.GetAddressByDataSet(ds);

            // Calls method to return client's diagnosis list.
            currentClient.clientDiagnosis = GetClientDiagnosis(thisClientID);

            // Calls method to return client's family as a list.
            currentClient.clientFamily = GetClientFamily(thisClientID);

            // Calls method to return client's physicians as a list.
            currentClient.clientPhysicians = GetClientPhysicians(thisClientID);

            // Calls method to return client's staff as a list.
            currentClient.clientStaff = GetClientStaff(thisClientID);

            // Calls method to return client's Insurances as a list.
            currentClient.clientInsurance = GetClientInsurance(thisClientID);

            // Calls method to return client's Insurance Authorizations as a list.
            currentClient.clientInsAuths = GetClientInsuranceAuths(thisClientID);

            // Calls method to return client's Comments.
            currentClient.clientComments = GetClientComments(thisClientID);

            return currentClient;
        }

        public List<Diagnosis> GetClientDiagnosis(int thisClientID)
        {
            // Accesses stored proc on SQL server.
            DbCommand get_DiagnosisByClientID = db.GetStoredProcCommand("get_DiagnosisByClientID");
            db.AddInParameter(get_DiagnosisByClientID, "clientID", DbType.Int32, thisClientID);

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
                                                 diagnosisFrom = drRow.Field<DateTime>("diagnosis_From"),
                                                 diagnosisTo = drRow.Field<DateTime>("diagnosis_To")

                                             }).ToList();

            // Inserts the created list of diagnoses into the client.
            return DiagnosisList;
        }

        public List<Family> GetClientFamily(int thisClientID)
        {
            // Accesses stored proc on SQL server.
            DbCommand get_FamilyByClientID = db.GetStoredProcCommand("get_FamilyByClientID");
            db.AddInParameter(get_FamilyByClientID, "clientID", DbType.Int32, thisClientID);

            // Executes the database command, returns values as a DataSet.
            DataSet fds = db.ExecuteDataSet(get_FamilyByClientID);

            // TODO: Jen - Finish all fields.
            List<Family> FamilyList = (from drRow in fds.Tables[0].AsEnumerable()
                                       select new Family
                                       {
                                           familyMemberID = drRow.Field<int>("familyMemberID"),
                                           firstName = drRow.Field<string>(""),
                                           lastName = drRow.Field<string>(""),
                                           familyMemberType = drRow.Field<string>(""),
                                           dob = Convert.ToDateTime(drRow.Field<DateTime?>("")),
                                           sex = drRow.Field<string>(""),
                                           race = drRow.Field<string>(""),
                                           isGuardian = drRow.Field<bool>(""),
                                           occupation = drRow.Field<string>(""),
                                           employer = drRow.Field<string>("")
                                       }).ToList();

            return FamilyList;
        }

        public List<Physician> GetClientPhysicians(int thisClientID)
        {
            // Accesses stored proc on SQL server.
            DbCommand get_PhysicianByClientID = db.GetStoredProcCommand("get_PhysicianByClientID");
            db.AddInParameter(get_PhysicianByClientID, "clientID", DbType.Int32, thisClientID);

            // Executes the database command, returns values as a DataSet.
            DataSet pds = db.ExecuteDataSet(get_PhysicianByClientID);

            // TODO: Jen - Finish all fields.
            List<Physician> PhysicianList = (from drRow in pds.Tables[0].AsEnumerable()
                                             select new Physician()
                                             { 

                                             }).ToList();

            return PhysicianList;
        }

        public List<Staff> GetClientStaff(int thisClientID)
        {
            // Accesses stored proc on SQL server.
            DbCommand get_StaffByClientID = db.GetStoredProcCommand("get_StaffByClientID");
            db.AddInParameter(get_StaffByClientID, "clientID", DbType.Int32, thisClientID);

            // Executes the database command, returns values as a DataSet.
            DataSet sds = db.ExecuteDataSet(get_StaffByClientID);

            // TODO: Jen - Finish all fields.
            List<Staff> StaffList = (from drRow in sds.Tables[0].AsEnumerable()
                                     select new Staff()
                                     {


                                     }).ToList();

            return StaffList;
        }

        public List<Insurance> GetClientInsurance(int thisClientID)
        {
            // Accesses stored proc on SQL server.
            DbCommand get_InsuranceByClientID = db.GetStoredProcCommand("get_InsuranceByClientID");
            db.AddInParameter(get_InsuranceByClientID, "clientID", DbType.Int32, thisClientID);

            // Executes the database command, returns values as a DataSet.
            DataSet ids = db.ExecuteDataSet(get_InsuranceByClientID);

            // TODO: Jen - Finish all fields.
            List<Insurance> InsuranceList = (from drRow in ids.Tables[0].AsEnumerable()
                                             select new Insurance()
                                             {


                                             }).ToList();

            return InsuranceList;
        }

        public List<InsuranceAuthorization> GetClientInsuranceAuths(int thisClientID)
        {
            // Accesses stored proc on SQL server.
            DbCommand get_InsAuthsByClientID = db.GetStoredProcCommand("get_InsAuthByClientID");
            db.AddInParameter(get_InsAuthsByClientID, "clientID", DbType.Int32, thisClientID);

            // Executes the database command, returns values as a DataSet.
            DataSet iads = db.ExecuteDataSet(get_InsAuthsByClientID);

            // TODO: Jen - Finish all fields.
            List<InsuranceAuthorization> InsAuthList = (from drRow in iads.Tables[0].AsEnumerable()
                                                        select new InsuranceAuthorization()
                                                        {


                                                        }).ToList();

            return InsAuthList;
        }

        public List<Comments> GetClientComments(int thisClientID)
        {
            // Accesses stored proc on SQL server.
            DbCommand get_CommentsByClientID = db.GetStoredProcCommand("get_CommentsByClientID");
            db.AddInParameter(get_CommentsByClientID, "clientID", DbType.Int32, thisClientID);

            // Executes the database command, returns values as a DataSet.
            DataSet cds = db.ExecuteDataSet(get_CommentsByClientID);

            // TODO: Jen - Finish all fields.
            List<Comments> CommentsList = (from drRow in cds.Tables[0].AsEnumerable()
                                           select new Comments()
                                           {
                                               
                                           }).ToList();

            // Inserts the created list of comments into the client.
            return CommentsList;
        }

        public bool UpdateClient(Client thisClient)
        {
                DbCommand upd_Clients = db.GetStoredProcCommand("upd_Clients");

                db.AddInParameter(upd_Clients, "@clientsID", DbType.Int32, thisClient.clientID);
                db.AddInParameter(upd_Clients, "@raceID", DbType.Int32, thisClient.raceID);
                db.AddInParameter(upd_Clients, "@ethnicityID", DbType.Int32, thisClient.ethnicityID);
                db.AddInParameter(upd_Clients, "@clientStatusID", DbType.Int32, thisClient.clientStatusID);
                db.AddInParameter(upd_Clients, "@primaryLanguageID", DbType.Int32, thisClient.primaryLanguageID);
                db.AddInParameter(upd_Clients, "@schoolInfoID", DbType.Int32, thisClient.schoolInfoID);
                db.AddInParameter(upd_Clients, "@communicationPreferencesID", DbType.Int32, thisClient.communicationPreferencesID);
                db.AddInParameter(upd_Clients, "@sexID", DbType.Int32, thisClient.sexID);
                db.AddInParameter(upd_Clients, "@officeID", DbType.Int32, thisClient.officeID);
                db.AddInParameter(upd_Clients, "@altID", DbType.String, thisClient.altID);
                db.AddInParameter(upd_Clients, "@firstName", DbType.String, thisClient.firstName);
                db.AddInParameter(upd_Clients, "@middleInitial", DbType.String, thisClient.middleInitial);
                db.AddInParameter(upd_Clients, "@lastName", DbType.String, thisClient.lastName);
                db.AddInParameter(upd_Clients, "@dob", DbType.Date, thisClient.dob == null ? (object)DBNull.Value : (object)thisClient.dob);
                db.AddInParameter(upd_Clients, "@ssn", DbType.Int32, thisClient.ssn);
                db.AddInParameter(upd_Clients, "@referralSource", DbType.String, thisClient.referralSource);
                db.AddInParameter(upd_Clients, "@intakeDate", DbType.DateTime, thisClient.intakeDate == null ? (object)DBNull.Value : (object)thisClient.intakeDate);
                db.AddInParameter(upd_Clients, "@ifspDate", DbType.Date, thisClient.ifspDate == null ? (object)DBNull.Value : (object)thisClient.ifspDate);
                db.AddInParameter(upd_Clients, "@compSvcDate", DbType.Date, thisClient.compSvcDate == null ? (object)DBNull.Value : (object)thisClient.compSvcDate);
                db.AddInParameter(upd_Clients, "@serviceAreaException", DbType.Boolean, thisClient.serviceAreaException);
                db.AddInParameter(upd_Clients, "@tkidsCaseNumber", DbType.Int32, thisClient.TKIDcaseNumber);
                db.AddInParameter(upd_Clients, "@consentToRelease", DbType.Boolean, thisClient.consentRelease);
                db.AddInParameter(upd_Clients, "@eci", DbType.Boolean, thisClient.ECI);
                db.AddInParameter(upd_Clients, "@accountingSystemID", DbType.Int32, thisClient.accountingSystemID);

            try
            {
                db.ExecuteNonQuery(upd_Clients);

                thisClient = UpdateClientAddress(thisClient);

                return true;
            }
            catch
            {
                return false;
            }
        }

        public Client UpdateClientAddress(Client thisClient)
        {
                DbCommand upd_Addresses = db.GetStoredProcCommand("upd_Addresses");

                db.AddInParameter(upd_Addresses, "@addressesID", DbType.Int32, thisClient.clientAddress.addressesID);
                db.AddInParameter(upd_Addresses, "@address1", DbType.String, thisClient.clientAddress.address1);
                db.AddInParameter(upd_Addresses, "@address2", DbType.String, thisClient.clientAddress.address2);
                db.AddInParameter(upd_Addresses, "@city", DbType.String, thisClient.clientAddress.city);
                db.AddInParameter(upd_Addresses, "@st", DbType.String, thisClient.clientAddress.state);
                db.AddInParameter(upd_Addresses, "@zip", DbType.Int32, thisClient.clientAddress.zip);

            try
            {
                db.ExecuteNonQuery(upd_Addresses);

                return thisClient;
            }
            catch
            {
                return thisClient;
            }
        }

        public bool InsertClient(Client thisClient)
        {
                DbCommand ins_Client = db.GetStoredProcCommand("ins_Client");

                db.AddInParameter(ins_Client, "@firstName", DbType.String, thisClient.firstName);
                db.AddInParameter(ins_Client, "@lastName", DbType.String, thisClient.lastName);
                db.AddInParameter(ins_Client, "@dob", DbType.Date, thisClient.dob);
                db.AddInParameter(ins_Client, "@ssn", DbType.Int32, thisClient.ssn);
                db.AddInParameter(ins_Client, "@referralSource", DbType.String, thisClient.referralSource);

            try
            {
                db.ExecuteNonQuery(ins_Client);

                thisClient = InsertClientAddress(thisClient);

                return true;
            }
            catch
            {
                return false;
            }
        }

        public Client InsertClientAddress(Client thisClient)
        {
            try
            {
                DbCommand ins_Addresses = db.GetStoredProcCommand("ins_Addresses");

                db.AddInParameter(ins_Addresses, "@addressTypeID", DbType.Int32, thisClient.clientAddress.addressType);
                db.AddInParameter(ins_Addresses, "@address1", DbType.String, thisClient.clientAddress.address1);
                db.AddInParameter(ins_Addresses, "@address2", DbType.String, thisClient.clientAddress.address2);
                db.AddInParameter(ins_Addresses, "@city", DbType.String, thisClient.clientAddress.city);
                db.AddInParameter(ins_Addresses, "@st", DbType.String, thisClient.clientAddress.state);
                db.AddInParameter(ins_Addresses, "@zip", DbType.Int32, thisClient.clientAddress.zip);
                db.AddInParameter(ins_Addresses, "@mapsco", DbType.String, thisClient.clientAddress.mapsco);

                db.ExecuteNonQuery(ins_Addresses);

                return thisClient;
            }
            catch
            {
                return thisClient;
            }
        }

        public bool DeleteClient(Client thisClient)
        {
            DbCommand del_ClientByID = db.GetStoredProcCommand("del_ClientByID");

            db.AddInParameter(del_ClientByID, "@clientID", DbType.String, thisClient.clientID);

            try
            {
                db.ExecuteNonQuery(del_ClientByID);

                thisClient = InsertClientAddress(thisClient);

                return true;
            }
            catch
            {
                return false;
            }
        }
    }
}