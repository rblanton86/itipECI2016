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
        // Creates database connection.
        public static SqlDatabase db;

        public ClientDataController()
        {
            if (db == null)
            {
                db = new SqlDatabase(WebConfigurationManager.ConnectionStrings["eciConnectionString"].ToString());
            }
        }

        // Gets Client list for view.
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

        /************************************************************************** CREATE ********************************************************/
        public Client InsertClient(Client thisClient)
        {

            DbCommand ins_Client = db.GetStoredProcCommand("ins_Client");

            db.AddInParameter(ins_Client, "@clientsID", DbType.Int32, thisClient.clientID);
            db.AddInParameter(ins_Client, "@raceID", DbType.Int32, thisClient.raceID);
            db.AddInParameter(ins_Client, "@ethnicityID", DbType.Int32, thisClient.ethnicityID);
            db.AddInParameter(ins_Client, "@clientStatusID", DbType.Int32, thisClient.clientStatusID);
            db.AddInParameter(ins_Client, "@primaryLanguageID", DbType.Int32, thisClient.primaryLanguageID);
            db.AddInParameter(ins_Client, "@schoolInfoID", DbType.Int32, thisClient.schoolInfoID);
            db.AddInParameter(ins_Client, "@communicationPreferencesID", DbType.Int32, thisClient.communicationPreferencesID);
            db.AddInParameter(ins_Client, "@sexID", DbType.Int32, thisClient.sexID);
            db.AddInParameter(ins_Client, "@officeID", DbType.Int32, thisClient.officeID);
            db.AddInParameter(ins_Client, "@altID", DbType.String, thisClient.altID);
            db.AddInParameter(ins_Client, "@firstName", DbType.String, thisClient.firstName);
            db.AddInParameter(ins_Client, "@middleInitial", DbType.String, thisClient.middleInitial);
            db.AddInParameter(ins_Client, "@lastName", DbType.String, thisClient.lastName);
            db.AddInParameter(ins_Client, "@dob", DbType.Date, thisClient.dob);
            db.AddInParameter(ins_Client, "@ssn", DbType.Int32, thisClient.ssn);
            db.AddInParameter(ins_Client, "@referralSource", DbType.String, thisClient.referralSource);
            db.AddInParameter(ins_Client, "@intakeDate", DbType.DateTime, thisClient.intakeDate);
            db.AddInParameter(ins_Client, "@ifspDate", DbType.Date, thisClient.ifspDate);
            db.AddInParameter(ins_Client, "@compSvcDate", DbType.Date, thisClient.compSvcDate);
            db.AddInParameter(ins_Client, "@serviceAreaException", DbType.Boolean, thisClient.serviceAreaException);
            db.AddInParameter(ins_Client, "@tkidsCaseNumber", DbType.Int32, thisClient.TKIDcaseNumber);
            db.AddInParameter(ins_Client, "@consentToRelease", DbType.Boolean, thisClient.consentRelease);
            db.AddInParameter(ins_Client, "@eci", DbType.Boolean, thisClient.ECI);
            db.AddInParameter(ins_Client, "@accountingSystemID", DbType.String, thisClient.accountingSystemID);
            db.AddOutParameter(ins_Client, "@success", DbType.Boolean, 1);
            db.AddOutParameter(ins_Client, "@clientID", DbType.Int32, sizeof(int));

            try
            {
                db.ExecuteNonQuery(ins_Client);

                thisClient.clientID = Convert.ToInt32(db.GetParameterValue(ins_Client, "@clientID"));
                bool success = Convert.ToBoolean(db.GetParameterValue(ins_Client, "@success"));

                thisClient = InsertClientAddress(thisClient);

                thisClient.altID = thisClient.lastName.Substring(0, 4) + thisClient.firstName.Substring(0, 4) + thisClient.clientID;

                UpdateClient(thisClient);

                return thisClient;
            }
            catch
            {
                return thisClient;
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

        public Client InsertClientFamily(Client thisClient)
        {
            foreach (var fam in thisClient.clientFamily)
            {
                // Creates a call to the stored procedure with which each family member will be added.
                DbCommand ins_FamilyMember = db.GetStoredProcCommand("ins_FamilyMember");

                // Adds in/out parameters.
                db.AddInParameter(ins_FamilyMember, "@familyMemberTypeID", DbType.Int32, fam.familyMemberTypeID);
                db.AddInParameter(ins_FamilyMember, "@firstName", DbType.String, fam.firstName);
                db.AddInParameter(ins_FamilyMember, "@lastName", DbType.String, fam.lastName);
                db.AddInParameter(ins_FamilyMember, "@isGuardian", DbType.Boolean, fam.isGuardian);
                db.AddInParameter(ins_FamilyMember, "@sexID", DbType.Int32, fam.sexID);
                db.AddInParameter(ins_FamilyMember, "@raceID", DbType.Int32, fam.raceID);
                db.AddInParameter(ins_FamilyMember, "@occupation", DbType.String, fam.occupation);
                db.AddInParameter(ins_FamilyMember, "@employer", DbType.String, fam.employer);
                db.AddInParameter(ins_FamilyMember, "@dob", DbType.Date, fam.dob);

                db.AddOutParameter(ins_FamilyMember, "@success", DbType.Boolean, 1);
                db.AddOutParameter(ins_FamilyMember, "@famlyMemberID", DbType.Int32, sizeof(Int32));

                bool success;

                try
                {
                    // Inserts the family member on the database and links to the patient.
                    db.ExecuteNonQuery(ins_FamilyMember);

                    // Returns the familyMemberID created on the database.
                    success = Convert.ToBoolean(db.GetParameterValue(ins_FamilyMember, "@success"));
                    fam.familyMemberID = Convert.ToInt32(db.GetParameterValue(ins_FamilyMember, "@familyMemberID"));

                    // Adds the updated family member to the list of family on the client object.
                    thisClient.clientFamily.Add(fam);
                }
                catch
                {
                    success = false;
                }
            }

            return thisClient;
        }

        public Client InsertClientInsurance(Client thisClient)
        {
            foreach (var ins in thisClient.clientInsurance)
            {
                DbCommand ins_ClientInsurance = db.GetStoredProcCommand("ins_ClientInsurance");

                db.AddInParameter(ins_ClientInsurance, "@clientID", DbType.Int32, thisClient.clientID);
                db.AddInParameter(ins_ClientInsurance, "@insuranceID", DbType.Int32, ins.insuranceID);
                db.AddInParameter(ins_ClientInsurance, "@insurancePolicyID", DbType.String, ins.insurancePolicyID);
                db.AddInParameter(ins_ClientInsurance, "@insurancePolicyName", DbType.String, ins.insuranceName);
                db.AddInParameter(ins_ClientInsurance, "@insuranceMedPreAuthNumber", DbType.Int32, ins.medPreAuthNumber);
                db.AddOutParameter(ins_ClientInsurance, "@success", DbType.Boolean, 1);

                bool success;
                try
                {
                    db.ExecuteNonQuery(ins_ClientInsurance);
                    success = Convert.ToBoolean(db.GetParameterValue(ins_ClientInsurance, "@success"));
                }
                catch
                {
                    success = false;
                }
            }

            return thisClient;
        }

        public Client InsertClientInsAuth(Client thisClient)
        {
            // TODO: Add insert logic here.

            return thisClient;
        }

        public Client InsertClientStaff(Client thisClient)
        {
            foreach(var staff in thisClient.clientStaff)
            {
                DbCommand ins_ClientStaff = db.GetStoredProcCommand("ins_ClientStaff");

                db.AddInParameter(ins_ClientStaff, "@clientID", DbType.Int32, thisClient.clientID);
                db.AddInParameter(ins_ClientStaff, "@staffID", DbType.Int32, staff.staffID);
                db.AddOutParameter(ins_ClientStaff, "@success", DbType.Boolean, 1);

                bool success;

                try
                {
                    db.ExecuteNonQuery(ins_ClientStaff);
                    success = Convert.ToBoolean(db.GetParameterValue(ins_ClientStaff, "@success"));
                }
                catch
                {
                    success = false;
                }
            }

            return thisClient;
        }

        public Client InsertClientPhysician(Client thisClient)
        {
            foreach(var md in thisClient.clientPhysicians)
            {
                DbCommand ins_ClientPhysician = db.GetStoredProcCommand("ins_ClientPhysician");

                db.AddInParameter(ins_ClientPhysician, "@clientID", DbType.Int32, thisClient.clientID);
                db.AddInParameter(ins_ClientPhysician, "@physicianID", DbType.Int32, md.physicianID);
                db.AddOutParameter(ins_ClientPhysician, "@physicianID", DbType.Boolean, 1);

                bool success;

                try
                {
                    db.ExecuteNonQuery(ins_ClientPhysician);
                    success = Convert.ToBoolean(db.GetParameterValue(ins_ClientPhysician, "@success"));
                }
                catch
                {
                    success = false;
                }
            }
            

            return thisClient;
        }

        /************************************************************************** READ ********************************************************/
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
                fullName = dr.Field<string>("firstName") + " " + dr.Field<string>("lastName"),
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

            // Calls method to return client's Insurances as a list, as wwell as all auths tied to this client.
            currentClient.clientInsurance = GetClientInsurance(currentClient);

            // Calls method to return client's Comments.
            currentClient.clientComments = GetClientComments(thisClientID);

            // Calls method to return client's phone number.
            currentClient.phone = GetClientAdditionalContactInfo(currentClient);

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
                                           firstName = drRow.Field<string>("firstName"),
                                           lastName = drRow.Field<string>("lastName"),
                                           familyMemberType = drRow.Field<string>("familyMemberType"),
                                           dob = Convert.ToDateTime(drRow.Field<DateTime?>("dob")),
                                           sexID = drRow.Field<int>("sexID"),
                                           raceID = drRow.Field<int>("raceID"),
                                           isGuardian = drRow.Field<bool>("isGuardian"),
                                           occupation = drRow.Field<string>("occupation"),
                                           employer = drRow.Field<string>("employer")
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
                                                 physicianID = drRow.Field<int>("physicianID"),
                                                 firstName = drRow.Field<string>("firstName"),
                                                 lastName = drRow.Field<string>("lastName"),
                                                 title = drRow.Field<string>("title")
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
                                         staffAltID = drRow.Field<string>("staffAltID"),
                                         staffTypeID = drRow.Field<int>("staffTypeID"),
                                         staffType = drRow.Field<string>("staffType"),
                                         fullName = drRow.Field<string>("fullName")
                                     }).ToList();

            return StaffList;
        }

        public List<ClientInsurance> GetClientInsurance(Client thisClient)
        {
            // Accesses stored proc on SQL server.
            DbCommand get_InsuranceByClientID = db.GetStoredProcCommand("get_InsuranceByClientID");
            db.AddInParameter(get_InsuranceByClientID, "clientID", DbType.Int32, thisClient.clientID);

            // Executes the database command, returns values as a DataSet.
            DataSet ids = db.ExecuteDataSet(get_InsuranceByClientID);

            // Obtains a list of patient's insurance.
            List<ClientInsurance> InsuranceList = (from drRow in ids.Tables[0].AsEnumerable()
                                             select new ClientInsurance()
                                             {
                                                 insuranceID = drRow.Field<int>("insuranceID"),
                                                 insurancePolicyID = drRow.Field<string>("insurancePolicyID"),
                                                 insuranceName = drRow.Field<string>("insuranceName"),
                                                 medPreAuthNumber = drRow.Field<int>("medPreAuthNumber")
                                             }).ToList();

            thisClient.clientInsurance = InsuranceList;
            thisClient = GetClientInsuranceAuths(thisClient);

            return InsuranceList;
        }

        public Client GetClientInsuranceAuths(Client currentClient)
        {
            foreach (var insurance in currentClient.clientInsurance)
            {
                // Accesses stored proc on SQL server.
                DbCommand get_InsAuthsByClientID = db.GetStoredProcCommand("get_InsAuthByClientID");
                db.AddInParameter(get_InsAuthsByClientID, "clientID", DbType.Int32, currentClient.clientID);
                db.AddInParameter(get_InsAuthsByClientID, "insuranceID", DbType.Int32, insurance.insuranceID);

                // Executes the database command, returns values as a DataSet.
                DataSet iads = db.ExecuteDataSet(get_InsAuthsByClientID);

                // TODO: Jen - Finish all fields.
                var authorizations = (from drRow in iads.Tables[0].AsEnumerable()
                                      select new InsuranceAuthorization()
                                      {
                                          insuranceAuthorizationType = drRow.Field<string>("insuranceAuthorizationType"),
                                          insuranceAuthID = drRow.Field<int>("insuranceAuthID"),
                                          authorizedFrom = drRow.Field<DateTime>("authorized_From"),
                                          authorizedTo = drRow.Field<DateTime>("authorized_To")
                                      }).ToList();

                // TODO: Does this return the auths to the currentClient model or no?
                insurance.insuranceAuthorization.AddRange(authorizations);
            }

            return currentClient;
        }

        public List<Comments> GetClientComments(int thisClientID)
        {
            // Accesses stored proc on SQL server.
            DbCommand get_CommentsByClientID = db.GetStoredProcCommand("get_CommentsByClientID");
            db.AddInParameter(get_CommentsByClientID, "clientID", DbType.Int32, thisClientID);

            List<Comments> CommentsList = new List<Comments>();

            // Executes the database command, returns values as a DataSet.
            try
            {
                DataSet cds = db.ExecuteDataSet(get_CommentsByClientID);

                // TODO: Jen - Finish all fields.
                CommentsList = (from drRow in cds.Tables[0].AsEnumerable()
                                select new Comments()
                                {
                                    commentsID = drRow.Field<int>("commentsID"),
                                    comments = drRow.Field<string>("comments")
                                }).ToList();

                // Inserts the created list of comments into the client.
                return CommentsList;
            }
            catch
            {
                return CommentsList;
            }
        }

        public AdditionalContactInfoModel GetClientAdditionalContactInfo(Client thisClient)
        {

            DbCommand get_AdditionalContactInfo = db.GetStoredProcCommand("get_AdditionalContactInfo");
            db.AddInParameter(get_AdditionalContactInfo, "memberID", DbType.Int32, thisClient.clientID);
            db.AddInParameter(get_AdditionalContactInfo, "memberTypeID", DbType.Int32, thisClient.memberTypeID);
            db.AddOutParameter(get_AdditionalContactInfo, "additionalContactInfoID", DbType.Int32, sizeof(int));
            db.AddOutParameter(get_AdditionalContactInfo, "additionalContactInfo", DbType.String, 255);
            db.AddOutParameter(get_AdditionalContactInfo, "additionalContactInfoTypeID", DbType.Int32, sizeof(int));
            db.AddOutParameter(get_AdditionalContactInfo, "additionalContactInfoType", DbType.String, 25);
            db.AddOutParameter(get_AdditionalContactInfo, "memberType", DbType.String, 25);
            db.AddOutParameter(get_AdditionalContactInfo, "success", DbType.Boolean, 1);

            db.ExecuteNonQuery(get_AdditionalContactInfo);

            bool success = Convert.ToBoolean(db.GetParameterValue(get_AdditionalContactInfo, "@success"));

            AdditionalContactInfoModel contactInfo = new AdditionalContactInfoModel();
            if (success == true)
            {
                contactInfo.additionalContactInfoID = Convert.ToInt32(db.GetParameterValue(get_AdditionalContactInfo, "@additionalContactInfoID"));
                contactInfo.additionalContactInfo = Convert.ToString(db.GetParameterValue(get_AdditionalContactInfo, "@additionalContactInfo"));
                contactInfo.additionalContactInfoTypeID = Convert.ToInt32(db.GetParameterValue(get_AdditionalContactInfo, "@additionalContactInfoTypeID"));
                contactInfo.additionalContactInfoType = Convert.ToString(db.GetParameterValue(get_AdditionalContactInfo, "@additionalContactInfoType"));
                contactInfo.memberType = Convert.ToString(db.GetParameterValue(get_AdditionalContactInfo, "@memberType"));
            }

            return contactInfo;
        }

        /************************************************************************** UPDATE ********************************************************/
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
            db.AddInParameter(upd_Clients, "@dob", DbType.Date, thisClient.dob);
            db.AddInParameter(upd_Clients, "@ssn", DbType.Int32, thisClient.ssn);
            db.AddInParameter(upd_Clients, "@referralSource", DbType.String, thisClient.referralSource);
            db.AddInParameter(upd_Clients, "@intakeDate", DbType.DateTime, thisClient.intakeDate);
            db.AddInParameter(upd_Clients, "@ifspDate", DbType.Date, thisClient.ifspDate);
            db.AddInParameter(upd_Clients, "@compSvcDate", DbType.Date, thisClient.compSvcDate);
            db.AddInParameter(upd_Clients, "@serviceAreaException", DbType.Boolean, thisClient.serviceAreaException);
            db.AddInParameter(upd_Clients, "@tkidsCaseNumber", DbType.Int32, thisClient.TKIDcaseNumber);
            db.AddInParameter(upd_Clients, "@consentToRelease", DbType.Boolean, thisClient.consentRelease);
            db.AddInParameter(upd_Clients, "@eci", DbType.Boolean, thisClient.ECI);
            db.AddInParameter(upd_Clients, "@accountingSystemID", DbType.String, thisClient.accountingSystemID);

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

        /************************************************************************** DELETE ********************************************************/
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