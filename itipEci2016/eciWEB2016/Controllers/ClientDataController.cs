using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Configuration;
using System.Data;
using System.Data.Common;
using Microsoft.Practices.EnterpriseLibrary.Data.Sql;

using eciWEB2016.Models;
using eciWEB2016.Class;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Web.Mvc;

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

        private AddressesDataController addressesDataController = new AddressesDataController();

        // Gets Client list for view.
        public List<Client> GetListClients()
        {
            // Readies stored proc from server.
            DbCommand get_AllClients = db.GetStoredProcCommand("get_AllClients");

            // Executes stored proc to return values into a DataSet.
            DataSet ds = db.ExecuteDataSet(get_AllClients);

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

        public SelectList GetOfficeList()
        {
            DbCommand get_AllOffice = db.GetStoredProcCommand("get_AllOffice");

            DataSet ds = db.ExecuteDataSet(get_AllOffice);

            var selectList = (from drRow in ds.Tables[0].AsEnumerable()
                              select new SelectListItem()
                              {
                                  Text = drRow.Field<string>("officeName"),
                                  Value = drRow.Field<int>("officeID").ToString()

                              }).ToList();

            return new SelectList(selectList, "Value", "Text");
        }

        public SelectList GetSexList()
        {
            DbCommand get_AllSex = db.GetStoredProcCommand("get_AllSex");

            DataSet ds = db.ExecuteDataSet(get_AllSex);

            var selectList = (from drRow in ds.Tables[0].AsEnumerable()
                              select new SelectListItem()
                              {
                                  Text = drRow.Field<string>("sex"),
                                  Value = drRow.Field<int>("sexID").ToString()

                              }).ToList();

            return new SelectList(selectList, "Value", "Text");
        }

        public SelectList GetRaceList()
        {
            DbCommand get_AllRace = db.GetStoredProcCommand("get_AllRace");

            DataSet ds = db.ExecuteDataSet(get_AllRace);

            var selectList = (from drRow in ds.Tables[0].AsEnumerable()
                              select new SelectListItem()
                              {
                                  Text = drRow.Field<string>("race"),
                                  Value = drRow.Field<int>("raceID").ToString()

                              }).ToList();

            return new SelectList(selectList, "Value", "Text");
        }


        public SelectList GetEthnicityList()
        {
            DbCommand get_AllEthnicity = db.GetStoredProcCommand("get_AllEthnicity");

            DataSet ds = db.ExecuteDataSet(get_AllEthnicity);

            var selectList = (from drRow in ds.Tables[0].AsEnumerable()
                              select new SelectListItem()
                              {
                                  Text = drRow.Field<string>("ethnicity"),
                                  Value = drRow.Field<int>("ethnicityID").ToString()

                              }).ToList();

            return new SelectList(selectList, "Value", "Text");
        }

        public SelectList GetClientStatusList()
        {
            DbCommand get_AllStatus = db.GetStoredProcCommand("get_AllStatus");

            DataSet ds = db.ExecuteDataSet(get_AllStatus);

            var selectList = (from drRow in ds.Tables[0].AsEnumerable()
                              select new SelectListItem()
                              {
                                  Text = drRow.Field<string>("clientStatus"),
                                  Value = drRow.Field<int>("clientStatusID").ToString()

                              }).ToList();

            return new SelectList(selectList, "Value", "Text");
        }

        public SelectList GetCommunicationPreferencesList()
        {
            DbCommand get_AllCommunicationPreferences = db.GetStoredProcCommand("get_AllCommunicationPreferences");

            DataSet ds = db.ExecuteDataSet(get_AllCommunicationPreferences);

            var selectList = (from drRow in ds.Tables[0].AsEnumerable()
                              select new SelectListItem()
                              {
                                  Text = drRow.Field<string>("communicationPreferences"),
                                  Value = drRow.Field<int>("communicationPreferencesID").ToString()

                              }).ToList();

            return new SelectList(selectList, "Value", "Text");
        }

        public SelectList GetContactTypeList()
        {
            DbCommand get_AllAdditionalContactInfoType = db.GetStoredProcCommand("get_AllAdditionalContactInfoType");

            DataSet ds = db.ExecuteDataSet(get_AllAdditionalContactInfoType);

            var selectList = (from drRow in ds.Tables[0].AsEnumerable()
                              select new SelectListItem()
                              {
                                  Text = drRow.Field<string>("additionalContactInfoType"),
                                  Value = drRow.Field<int>("additionalContactInfoTypeID").ToString()

                              }).ToList();

            return new SelectList(selectList, "Value", "Text");
        }

        public SelectList GetStateCodeList()
        {
            var states = new List<SelectListItem> {
                    new SelectListItem { Value = "AL", Text = "Alabama" },
                    new SelectListItem { Value = "AK", Text = "Alaska" },
                    new SelectListItem { Value = "AZ", Text = "Arizona" },
                    new SelectListItem { Value = "AR", Text = "Arkansas" },
                    new SelectListItem { Value = "CA", Text = "California" },
                    new SelectListItem { Value = "CO", Text = "Colorado" },
                    new SelectListItem { Value = "CT", Text = "Connecticut" },
                    new SelectListItem { Value = "DE", Text = "Delaware" },
                    new SelectListItem { Value = "FL", Text = "Florida" },
                    new SelectListItem { Value = "GA", Text = "Georgia" },
                    new SelectListItem { Value = "HI", Text = "Hawaii" },
                    new SelectListItem { Value = "ID", Text = "Idaho" },
                    new SelectListItem { Value = "IL", Text = "Illinois" },
                    new SelectListItem { Value = "IN", Text = "Indiana" },
                    new SelectListItem { Value = "IA", Text = "Iowa" },
                    new SelectListItem { Value = "KS", Text = "Kansas" },
                    new SelectListItem { Value = "KY", Text = "Kentucky" },
                    new SelectListItem { Value = "LA", Text = "Louisiana" },
                    new SelectListItem { Value = "ME", Text = "Maine" },
                    new SelectListItem { Value = "MD", Text = "Maryland" },
                    new SelectListItem { Value = "MA", Text = "Massachusetts" },
                    new SelectListItem { Value = "MI", Text = "Michigan" },
                    new SelectListItem { Value = "MN", Text = "Minnesota" },
                    new SelectListItem { Value = "MS", Text = "Mississippi" },
                    new SelectListItem { Value = "MO", Text = "Missouri" },
                    new SelectListItem { Value = "MT", Text = "Montana" },
                    new SelectListItem { Value = "NC", Text = "North Carolina" },
                    new SelectListItem { Value = "ND", Text = "North Dakota" },
                    new SelectListItem { Value = "NE", Text = "Nebraska" },
                    new SelectListItem { Value = "NV", Text = "Nevada" },
                    new SelectListItem { Value = "NH", Text = "New Hampshire" },
                    new SelectListItem { Value = "NJ", Text = "New Jersey" },
                    new SelectListItem { Value = "NM", Text = "New Mexico" },
                    new SelectListItem { Value = "NY", Text = "New York" },
                    new SelectListItem { Value = "OH", Text = "Ohio" },
                    new SelectListItem { Value = "OK", Text = "Oklahoma" },
                    new SelectListItem { Value = "OR", Text = "Oregon" },
                    new SelectListItem { Value = "PA", Text = "Pennsylvania" },
                    new SelectListItem { Value = "RI", Text = "Rhode Island" },
                    new SelectListItem { Value = "SC", Text = "South Carolina" },
                    new SelectListItem { Value = "SD", Text = "South Dakota" },
                    new SelectListItem { Value = "TN", Text = "Tennessee" },
                    new SelectListItem { Value = "TX", Text = "Texas" },
                    new SelectListItem { Value = "UT", Text = "Utah" },
                    new SelectListItem { Value = "VT", Text = "Vermont" },
                    new SelectListItem { Value = "VA", Text = "Virginia" },
                    new SelectListItem { Value = "WA", Text = "Washington" },
                    new SelectListItem { Value = "WV", Text = "West Virginia" },
                    new SelectListItem { Value = "WI", Text = "Wisconsin" },
                    new SelectListItem { Value = "WY", Text = "Wyoming" }
                };
            var stateCodeList = new SelectList(states, "Value", "Text");
            return stateCodeList;
        }

        public SelectList GetFamilyMemberTypeList()
        {
            DbCommand get_AllFamilyMemberTypes = db.GetStoredProcCommand("get_AllFamilyMemberTypes");

            DataSet ds = db.ExecuteDataSet(get_AllFamilyMemberTypes);

            var selectList = (from drRow in ds.Tables[0].AsEnumerable()
                              select new SelectListItem()
                              {
                                  Text = drRow.Field<string>("familyMemberType"),
                                  Value = drRow.Field<int>("familyMemberTypeID").ToString()

                              }).ToList();

            return new SelectList(selectList, "Value", "Text");
        }

        /// <summary>
        /// Queries the database for a list of all languages defined on the database.
        /// </summary>
        /// <returns>SelectList of all languages defined on the database.</returns>
        public SelectList GetPrimaryLanguageList()
        {
            DbCommand get_AllPrimaryLanguages = db.GetStoredProcCommand("get_AllPrimaryLanguages");

            List<SelectListItem> languageList = new List<SelectListItem>();

            try
            {
                DataSet ds = db.ExecuteDataSet(get_AllPrimaryLanguages);

                var selectList = (from drRow in ds.Tables[0].AsEnumerable()
                                  select new SelectListItem()
                                  {
                                      Text = drRow.Field<string>("PrimaryLanguage"),
                                      Value = drRow.Field<int>("PrimaryLanguageID").ToString()

                                  }).ToList();

                languageList = selectList;
            }
            catch (Exception e)
            {
                Debug.WriteLine("GetPrimaryLanguageList failed, exception: {0}.", e);
                throw;
            }

            return new SelectList(languageList, "Value", "Text");
        }

        public SelectList GetSchoolInfoList()
        {
            DbCommand get_AllSchoolInfo = db.GetStoredProcCommand("get_AllSchoolInfo");

            DataSet ds = db.ExecuteDataSet(get_AllSchoolInfo);

            var selectList = (from drRow in ds.Tables[0].AsEnumerable()
                              select new SelectListItem()
                              {
                                  Text = drRow.Field<string>("isd"),
                                  Value = drRow.Field<int>("schoolInfoID").ToString()

                              }).ToList();

            return new SelectList(selectList, "Value", "Text");
        }


        /************************************************************************** CREATE ********************************************************/


        /************************************************************************** READ ********************************************************/
        public Client GetClient(int selectedClientID)
        {

            // Accesses stored proc on SQL server.
            DbCommand get_ClientByID = db.GetStoredProcCommand("get_ClientByID");
            db.AddInParameter(get_ClientByID, "clientID", DbType.Int32, selectedClientID);

            // Stores client into a dataset.
            DataSet ds = db.ExecuteDataSet(get_ClientByID);

            // Takes values from DataSet and places results in a SelectList.
            // This select list is used for the search autocomplete boxes on the client_update page.
            DataRow dr = ds.Tables[0].Rows[0];

            // Creates current client and inputs values from dataset.
            var selectedClient = new Client()
            {
                clientID = selectedClientID,
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
            var now = DateTime.Now;
            TimeSpan timeSpan = now - selectedClient.dob;
            double ts = timeSpan.TotalDays;
            double diff = (ts / 30);
            selectedClient.ageInMonths = Convert.ToInt32(diff);

            // Assigns obtained address into current client.
            Addresses selectAddress = new Addresses();
            selectedClient.clientAddress = selectAddress.GetAddressByDataSet(ds);

            // Calls method to return client's diagnosis list.
            selectedClient = GetClientDiagnosis(selectedClient);

            // Calls method to return client's family as a list.
            selectedClient = GetClientFamily(selectedClient);

            // Calls method to return client's physicians as a list.
            selectedClient = GetClientPhysicians(selectedClient);

            // Calls method to return client's staff as a list.
            selectedClient = GetClientStaff(selectedClient);

            // Calls method to return client's Insurances as a list, as wwell as all auths tied to this client.
            selectedClient = GetClientInsurance(selectedClient);

            // Calls method to return client's Comments.
            selectedClient = GetClientComments(selectedClient);

            // Calls method to return client's phone number.
            selectedClient = GetClientAdditionalContactInfo(selectedClient);

            return selectedClient;
        }

        public Client GetClientDiagnosis(Client selectedClient)
        {
            // Accesses stored proc on SQL server.
            DbCommand get_DiagnosisByClientID = db.GetStoredProcCommand("get_DiagnosisByClientID");
            db.AddInParameter(get_DiagnosisByClientID, "clientID", DbType.Int32, selectedClient.clientID);

            // Executes the database command, returns values as a DataSet.
            DataSet dds = db.ExecuteDataSet(get_DiagnosisByClientID);

            // Selects diagnosis information into client object.
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
            selectedClient.clientDiagnosis.AddRange(DiagnosisList);

            return selectedClient;
        }

        public Client GetClientFamily(Client selectedClient)
        {
            // Accesses stored proc on SQL server.
            DbCommand get_FamilyByClientID = db.GetStoredProcCommand("get_FamilyByClientID");
            db.AddInParameter(get_FamilyByClientID, "clientID", DbType.Int32, selectedClient.clientID);

            // Executes the database command, returns values as a DataSet.
            DataSet fds = db.ExecuteDataSet(get_FamilyByClientID);

            // TODO: Selects family information into client object
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

            // Adds the list to the current client's current family list.
            selectedClient.clientFamily.AddRange(FamilyList);

            return selectedClient;
        }

        public Client GetClientPhysicians(Client selectedClient)
        {
            // Accesses stored proc on SQL server.
            DbCommand get_PhysicianByClientID = db.GetStoredProcCommand("get_PhysicianByClientID");
            db.AddInParameter(get_PhysicianByClientID, "clientID", DbType.Int32, selectedClient.clientID);

            // Executes the database command, returns values as a DataSet.
            DataSet pds = db.ExecuteDataSet(get_PhysicianByClientID);

            // Obtains a list of physician's belonging to the patient and adds to a list of physicians.
            List<Physician> PhysicianList = (from drRow in pds.Tables[0].AsEnumerable()
                                             select new Physician()
                                             {
                                                 physicianID = drRow.Field<int>("physicianID"),
                                                 firstName = drRow.Field<string>("firstName"),
                                                 lastName = drRow.Field<string>("lastName"),
                                                 title = drRow.Field<string>("title")
                                             }).ToList();

            // Adds the list of the client's physicians to the client Object.
            selectedClient.clientPhysicians.AddRange(PhysicianList);

            return selectedClient;
        }

        public Client GetClientStaff(Client selectedClient)
        {
            // Accesses stored proc on SQL server.
            DbCommand get_StaffByClientID = db.GetStoredProcCommand("get_StaffByClientID");
            db.AddInParameter(get_StaffByClientID, "clientID", DbType.Int32, selectedClient.clientID);

            // Executes the database command, returns values as a DataSet.
            DataSet sds = db.ExecuteDataSet(get_StaffByClientID);

            // Selects staff informaiton into staff list.
            List<Staff> StaffList = (from drRow in sds.Tables[0].AsEnumerable()
                                     select new Staff()
                                     {
                                         staffAltID = drRow.Field<string>("staffAltID"),
                                         staffTypeID = drRow.Field<int>("staffTypeID"),
                                         staffType = drRow.Field<string>("staffType"),
                                         fullName = drRow.Field<string>("fullName")
                                     }).ToList();

            // Adds the created staff list to the current client object.
            selectedClient.clientStaff.AddRange(StaffList);

            // Selects the client's caseManager into a variable.
            selectedClient.caseManager = selectedClient.clientStaff.Find(staff => staff.staffTypeID == 1);

            return selectedClient;
        }

        public Client GetClientInsurance(Client selectedClient)
        {
            // Accesses stored proc on SQL server.
            DbCommand get_InsuranceByClientID = db.GetStoredProcCommand("get_InsuranceByClientID");
            db.AddInParameter(get_InsuranceByClientID, "clientID", DbType.Int32, selectedClient.clientID);

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

            selectedClient.clientInsurance.AddRange(InsuranceList);
            selectedClient = GetClientInsuranceAuths(selectedClient);

            return selectedClient;
        }

        public Client GetClientInsuranceAuths(Client selectedClient)
        {
            foreach (var insurance in selectedClient.clientInsurance)
            {
                // Accesses stored proc on SQL server.
                DbCommand get_InsAuthsByClientID = db.GetStoredProcCommand("get_InsAuthByClientID");
                db.AddInParameter(get_InsAuthsByClientID, "clientID", DbType.Int32, selectedClient.clientID);
                db.AddInParameter(get_InsAuthsByClientID, "insuranceID", DbType.Int32, insurance.insuranceID);

                // Executes the database command, returns values as a DataSet.
                DataSet iads = db.ExecuteDataSet(get_InsAuthsByClientID);

                // Selects InsuranceAuthorization information into an InsuranceAuthorization list.
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

            return selectedClient;
        }

        public Client GetClientComments(Client selectedClient)
        {
            // Accesses stored proc on SQL server.
            DbCommand get_CommentsByClientID = db.GetStoredProcCommand("get_CommentsByClientID");
            db.AddInParameter(get_CommentsByClientID, "clientID", DbType.Int32, selectedClient.clientID);

            List<Comments> CommentsList = new List<Comments>();

            // Executes the database command, returns values as a DataSet.
            try
            {
                DataSet cds = db.ExecuteDataSet(get_CommentsByClientID);

                // Selects all comments into list of comments.
                CommentsList = (from drRow in cds.Tables[0].AsEnumerable()
                                select new Comments()
                                {
                                    commentsID = drRow.Field<int>("commentsID"),
                                    comments = drRow.Field<string>("comments")
                                }).ToList();

                // Inserts the created list of comments into the client.
                selectedClient.clientComments.AddRange(CommentsList);
            }
            catch (Exception e)
            {
                Debug.WriteLine("GetClientComments failed, exception: {0}", e);
            }

            return selectedClient;
        }

        public Client GetClientAdditionalContactInfo(Client selectedClient)
        {

            DbCommand get_AdditionalContactInfoByMemberID = db.GetStoredProcCommand("get_AdditionalContactInfoByMemberID");
            db.AddInParameter(get_AdditionalContactInfoByMemberID, "memberID", DbType.Int32, selectedClient.clientID);
            db.AddInParameter(get_AdditionalContactInfoByMemberID, "memberTypeID", DbType.Int32, selectedClient.memberTypeID);
            db.AddOutParameter(get_AdditionalContactInfoByMemberID, "additionalContactInfoID", DbType.Int32, sizeof(int));
            db.AddOutParameter(get_AdditionalContactInfoByMemberID, "additionalContactInfo", DbType.String, 255);
            db.AddOutParameter(get_AdditionalContactInfoByMemberID, "additionalContactInfoTypeID", DbType.Int32, sizeof(int));
            db.AddOutParameter(get_AdditionalContactInfoByMemberID, "additionalContactInfoType", DbType.String, 25);
            db.AddOutParameter(get_AdditionalContactInfoByMemberID, "memberType", DbType.String, 25);
            db.AddOutParameter(get_AdditionalContactInfoByMemberID, "success", DbType.Boolean, 1);

            try
            {
                db.ExecuteNonQuery(get_AdditionalContactInfoByMemberID);

                bool success = Convert.ToBoolean(db.GetParameterValue(get_AdditionalContactInfoByMemberID, "@success"));

                AdditionalContactInfoModel contactInfo = new AdditionalContactInfoModel();

                if (contactInfo.additionalContactInfoID != 0)
                {
                    contactInfo.additionalContactInfoID = Convert.ToInt32(db.GetParameterValue(get_AdditionalContactInfoByMemberID, "@additionalContactInfoID"));
                    contactInfo.additionalContactInfo = Convert.ToString(db.GetParameterValue(get_AdditionalContactInfoByMemberID, "@additionalContactInfo"));
                    contactInfo.additionalContactInfoTypeID = Convert.ToInt32(db.GetParameterValue(get_AdditionalContactInfoByMemberID, "@additionalContactInfoTypeID"));
                    contactInfo.additionalContactInfoType = Convert.ToString(db.GetParameterValue(get_AdditionalContactInfoByMemberID, "@additionalContactInfoType"));
                    contactInfo.memberType = Convert.ToString(db.GetParameterValue(get_AdditionalContactInfoByMemberID, "@memberType"));
                }

                selectedClient.phone = contactInfo;
            }
            catch (Exception e)
            {
                Debug.WriteLine("GetClientAdditionalContactInfo did not complete, exception: {0}", e);
            }

            return selectedClient;
        }

        /************************************************************************** UPDATE ********************************************************/
        public bool UpdateClient(Client currentClient)
        {
            // Updates the current client's full name in case it was changed.
            currentClient.fullName = currentClient.firstName + " " + currentClient.lastName;

            DbCommand upd_Clients = db.GetStoredProcCommand("upd_Clients");

            db.AddInParameter(upd_Clients, "@clientsID", DbType.Int32, currentClient.clientID);
            db.AddInParameter(upd_Clients, "@raceID", DbType.Int32, currentClient.raceID);
            db.AddInParameter(upd_Clients, "@ethnicityID", DbType.Int32, currentClient.ethnicityID);
            db.AddInParameter(upd_Clients, "@clientStatusID", DbType.Int32, currentClient.clientStatusID);
            db.AddInParameter(upd_Clients, "@primaryLanguageID", DbType.Int32, currentClient.primaryLanguageID);
            db.AddInParameter(upd_Clients, "@schoolInfoID", DbType.Int32, currentClient.schoolInfoID);
            db.AddInParameter(upd_Clients, "@communicationPreferencesID", DbType.Int32, currentClient.communicationPreferencesID);
            db.AddInParameter(upd_Clients, "@sexID", DbType.Int32, currentClient.sexID);
            db.AddInParameter(upd_Clients, "@officeID", DbType.Int32, currentClient.officeID);
            db.AddInParameter(upd_Clients, "@altID", DbType.String, currentClient.altID);
            db.AddInParameter(upd_Clients, "@firstName", DbType.String, currentClient.firstName);
            db.AddInParameter(upd_Clients, "@middleInitial", DbType.String, currentClient.middleInitial);
            db.AddInParameter(upd_Clients, "@lastName", DbType.String, currentClient.lastName);
            db.AddInParameter(upd_Clients, "@dob", DbType.Date, currentClient.dob);
            db.AddInParameter(upd_Clients, "@ssn", DbType.Int32, currentClient.ssn);
            db.AddInParameter(upd_Clients, "@referralSource", DbType.String, currentClient.referralSource);
            db.AddInParameter(upd_Clients, "@intakeDate", DbType.DateTime, currentClient.intakeDate);
            db.AddInParameter(upd_Clients, "@ifspDate", DbType.Date, currentClient.ifspDate);
            db.AddInParameter(upd_Clients, "@compSvcDate", DbType.Date, currentClient.compSvcDate);
            db.AddInParameter(upd_Clients, "@serviceAreaException", DbType.Boolean, currentClient.serviceAreaException);
            db.AddInParameter(upd_Clients, "@tkidsCaseNumber", DbType.Int32, currentClient.TKIDcaseNumber);
            db.AddInParameter(upd_Clients, "@consentToRelease", DbType.Boolean, currentClient.consentRelease);
            db.AddInParameter(upd_Clients, "@eci", DbType.Boolean, currentClient.ECI);
            db.AddInParameter(upd_Clients, "@accountingSystemID", DbType.String, currentClient.accountingSystemID);

            try
            {
                db.ExecuteNonQuery(upd_Clients);

                currentClient = UpdateClientAddress(currentClient);

                return true;
            }
            catch (Exception e)
            {
                Debug.WriteLine("UpdateClient failed, exception: {0}", e);
                return false;
                throw;
            }
        }

        public Client UpdateClientAddress(Client currentClient)
        {
            if(currentClient.clientAddress.addressesID != 0)
            {
                DbCommand upd_Addresses = db.GetStoredProcCommand("upd_Addresses");
                db.AddInParameter(upd_Addresses, "@memberID", DbType.Int32, currentClient.clientID);
                db.AddInParameter(upd_Addresses, "@memberTypeID", DbType.Int32, currentClient.memberTypeID);
                db.AddInParameter(upd_Addresses, "@addressesID", DbType.Int32, currentClient.clientAddress.addressesID);
                db.AddInParameter(upd_Addresses, "@addressesTypeID", DbType.Int32, currentClient.clientAddress.addressTypeID);
                db.AddInParameter(upd_Addresses, "@address1", DbType.String, currentClient.clientAddress.address1);
                db.AddInParameter(upd_Addresses, "@address2", DbType.String, currentClient.clientAddress.address2);
                db.AddInParameter(upd_Addresses, "@city", DbType.String, currentClient.clientAddress.city);
                db.AddInParameter(upd_Addresses, "@st", DbType.String, currentClient.clientAddress.state);
                db.AddInParameter(upd_Addresses, "@county", DbType.String, currentClient.clientAddress.county);
                db.AddInParameter(upd_Addresses, "@zip", DbType.Int32, currentClient.clientAddress.zip);

                try
                {
                    db.ExecuteNonQuery(upd_Addresses);
                }
                catch (Exception e)
                {
                    Debug.WriteLine("UpdateClientAddress failed, exception: {0}", e);
                    throw;
                }
            }
            else
            {
                ReferralDataController referralDataController = new ReferralDataController();
                currentClient.clientAddress = addressesDataController.InsertAddress(currentClient.clientAddress, currentClient.clientID, 1);
            }

            return currentClient;
        }

        public Client UpdateClientFamily(Client currentClient)
        {
            foreach (var family in currentClient.clientFamily)
            {
                DbCommand upd_FamilyMember = db.GetStoredProcCommand("upd_FamilyMember");

                db.AddInParameter(upd_FamilyMember, "@famlyMemberID", DbType.Int32, family.familyMemberID);
                db.AddInParameter(upd_FamilyMember, "@familyMemberTypeID", DbType.Int32, family.familyMemberTypeID);
                db.AddInParameter(upd_FamilyMember, "@firstName", DbType.String, family.firstName);
                db.AddInParameter(upd_FamilyMember, "@lastName", DbType.String, family.lastName);

                try
                {
                    db.ExecuteNonQuery(upd_FamilyMember);
                }
                catch (Exception e)
                {
                    Debug.WriteLine("UpdateClientFamily failed, exception: {0}", e);
                    throw;
                }

                for (int c = 0; c < family.familyContact.Count; c++)
                {
                    if (Convert.ToInt32(family.familyContact[c].additionalContactInfoID) == 0)
                    {
                        AdditionalContactInfo contact = new AdditionalContactInfo();
                        family.familyContact[c] = contact.InsertAdditionalContactInformation(family.familyContact[c], family.familyMemberID, family.memberTypeID);
                    }
                    else
                    {
                        AdditionalContactInfo contact = new AdditionalContactInfo();
                        family.familyContact[c] = contact.UpdateAdditionalContactInformation(family.familyContact[c], family.familyMemberID, family.memberTypeID);
                    }
                }
            }

            return currentClient;
        }

        public Client UpdateClientInsurance(Client currentClient)
        {
            for (var upd = 0; upd < currentClient.clientInsurance.Count; upd++)
            {
                DbCommand upd_ClientInsurance = db.GetStoredProcCommand("upd_ClientInsurance");

                db.AddInParameter(upd_ClientInsurance, "@clientID", DbType.Int32, currentClient.clientID);
                db.AddInParameter(upd_ClientInsurance, "@insuranceID", DbType.Int32, currentClient.clientInsurance[upd].insuranceID);
                db.AddInParameter(upd_ClientInsurance, "@insuranceID", DbType.Int32, currentClient.clientInsurance[upd].insuranceID);
                db.AddInParameter(upd_ClientInsurance, "@insurancePolicyID", DbType.String, currentClient.clientInsurance[upd].insurancePolicyID);
                db.AddInParameter(upd_ClientInsurance, "@insurancePolicyName", DbType.String, currentClient.clientInsurance[upd].insuranceName);
                db.AddInParameter(upd_ClientInsurance, "@insuranceMedPreAuthNumber", DbType.Int32, currentClient.clientInsurance[upd].medPreAuthNumber);

                db.AddOutParameter(upd_ClientInsurance, "@success", DbType.Boolean, 1);

                bool success;
                try
                {
                    db.ExecuteNonQuery(upd_ClientInsurance);
                    success = Convert.ToBoolean(db.GetParameterValue(upd_ClientInsurance, "@success"));

                    if (currentClient.clientInsurance[upd].insuranceAuthorization.Count > 0)
                    {
                        currentClient.clientInsurance[upd] = UpdateInsuranceAuthorizations(currentClient.clientInsurance[upd], currentClient);
                    }
                }
                catch (Exception e)
                {
                    Debug.WriteLine("UpdateClientInsurance failed, exception: {0}.", e);
                    success = false;
                    throw;
                }
            }

            return currentClient;
        }

        public ClientInsurance UpdateInsuranceAuthorizations(ClientInsurance upd, Client currentClient)
        {
            for (int updAuth = 0; updAuth < upd.insuranceAuthorization.Count; updAuth++)
            {
                DbCommand upd_InsuranceAuthorization = db.GetStoredProcCommand("upd_InsuranceAuthorization");
                db.AddInParameter(upd_InsuranceAuthorization, "@clientID", DbType.Int32, currentClient.clientID);
                db.AddInParameter(upd_InsuranceAuthorization, "@insuranceID", DbType.Int32, upd.insuranceID);
                db.AddInParameter(upd_InsuranceAuthorization, "@authorized_From", DbType.Boolean, upd.insuranceAuthorization[updAuth].authorizedFrom);
                db.AddInParameter(upd_InsuranceAuthorization, "@authorized_To", DbType.Boolean, upd.insuranceAuthorization[updAuth].authorizedTo);
                db.AddInParameter(upd_InsuranceAuthorization, "@insuranceAuthorizationType", DbType.String, upd.insuranceAuthorization[updAuth].insuranceAuthorizationType);

                db.AddOutParameter(upd_InsuranceAuthorization, "@success", DbType.Boolean, 1);

                bool success;
                try
                {
                    db.ExecuteNonQuery(upd_InsuranceAuthorization);
                    success = Convert.ToBoolean(db.GetParameterValue(upd_InsuranceAuthorization, "@success"));
                }
                catch (Exception e)
                {
                    Debug.WriteLine("UpdateClientInsuranceAuthorizations failed, exception: {0}.", e);
                    success = false;
                    throw;
                }
            }

            return upd;
        }

        public Client UpdateClientStaff(Client currentClient)
        {
            foreach (var staff in currentClient.clientStaff)
            {
                DbCommand upd_ClientStaff = db.GetStoredProcCommand("upd_ClientStaff");

                db.AddInParameter(upd_ClientStaff, "@clientID", DbType.Int32, currentClient.clientID);
                db.AddInParameter(upd_ClientStaff, "@staffID", DbType.Int32, staff.staffID);
                db.AddOutParameter(upd_ClientStaff, "@success", DbType.Boolean, 1);

                bool success;

                try
                {
                    db.ExecuteNonQuery(upd_ClientStaff);
                    success = Convert.ToBoolean(db.GetParameterValue(upd_ClientStaff, "@success"));
                }
                catch (Exception e)
                {
                    Debug.WriteLine("UpdateClientStaff failed, exception: {0}.", e);
                    success = false;
                    throw;
                }
            }

            return currentClient;
        }

        public Client UpdateClientPhysician(Client currentClient)
        {
            foreach (var md in currentClient.clientPhysicians)
            {
                DbCommand upd_ClientPhysician = db.GetStoredProcCommand("upd_ClientPhysician");

                db.AddInParameter(upd_ClientPhysician, "@clientID", DbType.Int32, currentClient.clientID);
                db.AddInParameter(upd_ClientPhysician, "@physicianID", DbType.Int32, md.physicianID);
                db.AddOutParameter(upd_ClientPhysician, "@physicianID", DbType.Boolean, 1);

                bool success;

                try
                {
                    db.ExecuteNonQuery(upd_ClientPhysician);
                    success = Convert.ToBoolean(db.GetParameterValue(upd_ClientPhysician, "@success"));
                }
                catch (Exception e)
                {
                    Debug.WriteLine("UpdateClientPhysician failed, exception: {0}.", e);
                    success = false;
                    throw;
                }
            }


            return currentClient;
        }

        public Client UpdateClientDiagnosis(Client currentClient)
        {
            foreach (var diagnosis in currentClient.clientDiagnosis)
            {
                DbCommand upd_ClientDiagnosis = db.GetStoredProcCommand("upd_ClientDiagnosis");
                db.AddInParameter(upd_ClientDiagnosis, "@clientID", DbType.Int32, currentClient.clientID);
                db.AddInParameter(upd_ClientDiagnosis, "@diagnosisCodeID", DbType.Int32, diagnosis.diagnosisCodeID);
                db.AddInParameter(upd_ClientDiagnosis, "@diagnosisTypeID", DbType.Int32, diagnosis.diagnosisTypeID);
                db.AddInParameter(upd_ClientDiagnosis, "@diagnosis_From", DbType.DateTime, diagnosis.diagnosisFrom);
                db.AddInParameter(upd_ClientDiagnosis, "@diagnosis_To", DbType.DateTime, diagnosis.diagnosisTo);
                db.AddInParameter(upd_ClientDiagnosis, "@isPrimary", DbType.Boolean, diagnosis.isPrimary);
                db.AddOutParameter(upd_ClientDiagnosis, "@success", DbType.Boolean, 1);

                bool success;
                try
                {
                    db.ExecuteNonQuery(upd_ClientDiagnosis);
                    success = Convert.ToBoolean(db.GetParameterValue(upd_ClientDiagnosis, "@success"));
                }
                catch (Exception e)
                {
                    Debug.WriteLine("UpdateClientDiagnosis failed, exception: {0}.", e);
                    success = false;
                    throw;
                }
            }

            return currentClient;
        }

        public Client UpdateClientComments(Client currentClient)
        {
            foreach (var comment in currentClient.clientComments)
            {
                DbCommand upd_ClientComments = db.GetStoredProcCommand("upd_ClientComments");
                db.AddInParameter(upd_ClientComments, "@memberID", DbType.Int32, currentClient.clientID);
                db.AddInParameter(upd_ClientComments, "@memberTypeID", DbType.Int32, currentClient.memberTypeID);
                db.AddInParameter(upd_ClientComments, "@comments", DbType.String, comment.comments);
                db.AddInParameter(upd_ClientComments, "@commentsTypeID", DbType.Int32, comment.commentsTypeID);
                db.AddOutParameter(upd_ClientComments, "@commentsID", DbType.Int32, sizeof(int));
                db.AddOutParameter(upd_ClientComments, "@success", DbType.Boolean, 1);

                bool success;
                try
                {
                    db.ExecuteNonQuery(upd_ClientComments);

                    comment.commentsID = Convert.ToInt32(db.GetParameterValue(upd_ClientComments, "@commentsID"));
                    success = Convert.ToBoolean(db.GetParameterValue(upd_ClientComments, "@success"));
                }
                catch (Exception e)
                {
                    Debug.WriteLine("UpdateClientComments failed, exception: {0}.", e);
                    success = false;
                    throw;
                }
            }
            return currentClient;
        }

        /************************************************************************** DELETE ********************************************************/
        public bool DeleteClient(Client removingClient)
        {
            DbCommand del_ClientByID = db.GetStoredProcCommand("del_ClientByID");

            db.AddInParameter(del_ClientByID, "@clientID", DbType.String, removingClient.clientID);

            db.AddOutParameter(del_ClientByID, "@success", DbType.Boolean, 1);

            bool success;
            try
            {
                db.ExecuteNonQuery(del_ClientByID);
                success = Convert.ToBoolean(db.GetParameterValue(del_ClientByID, "@success"));
            }
            catch (Exception e)
            {
                Debug.WriteLine("DeleteClient failed, exception: {0}.", e);
                success = false;
                throw;
            }

            return success;
        }

        public bool DeleteClientAddress(Client removingClient)
        {
            DbCommand del_Addresses = db.GetStoredProcCommand("del_Addresses");

            db.AddInParameter(del_Addresses, "@addressesID", DbType.Int32, removingClient.clientAddress.addressesID);

            db.AddOutParameter(del_Addresses, "@success", DbType.Boolean, 1);

            bool success;
            try
            {
                db.ExecuteNonQuery(del_Addresses);
                success = Convert.ToBoolean(db.GetParameterValue(del_Addresses, "@success"));
            }
            catch (Exception e)
            {
                Debug.WriteLine("DeleteClientAddress failed, exception: {0}", e);
                success = false;
                throw;
            }

            return success;
        }

        public bool DeleteClientFamily(Family removingFamily)
        {
            DbCommand del_FamilyMember = db.GetStoredProcCommand("del_FamilyMember");

            db.AddInParameter(del_FamilyMember, "@familyMemberID", DbType.Int32, removingFamily.familyMemberID);

            db.AddOutParameter(del_FamilyMember, "@success", DbType.Boolean, 1);

            bool success;
            try
            {
                db.ExecuteNonQuery(del_FamilyMember);

                for (int c = 0; c <= removingFamily.familyContact.Count; c++)
                {
                    if (Convert.ToInt32(removingFamily.familyContact[c].additionalContactInfoID) != 0)
                    {
                        AdditionalContactInfo contact = new AdditionalContactInfo();
                        success = contact.DeleteAdditionalContactInformation(removingFamily.familyContact[c]);
                    }
                }

                success = Convert.ToBoolean(db.GetParameterValue(del_FamilyMember, "@success"));
            }
            catch (Exception e)
            {
                Debug.WriteLine("DeleteClientFamily failed, exception: {0}", e);
                success = false;
                throw;
            }

            return success;
        }

        public bool DeleteClientInsurance(ClientInsurance removingInsurance, Client currentClient)
        {
            DbCommand del_ClientInsurance = db.GetStoredProcCommand("del_ClientInsurance");

            db.AddInParameter(del_ClientInsurance, "@insuranceID", DbType.Int32, removingInsurance.insuranceID);
            db.AddInParameter(del_ClientInsurance, "@clientInsurance", DbType.Int32, currentClient.clientID);

            db.AddOutParameter(del_ClientInsurance, "@success", DbType.Boolean, 1);

            bool success;
            try
            {
                db.ExecuteNonQuery(del_ClientInsurance);
                success = Convert.ToBoolean(db.GetParameterValue(del_ClientInsurance, "@success"));

                if (removingInsurance.insuranceAuthorization.Count > 0)
                {
                    foreach (var insAuth in removingInsurance.insuranceAuthorization)
                    {
                        success = DeleteInsuranceAuthorizations(insAuth);
                    }
                }
            }
            catch (Exception e)
            {
                Debug.WriteLine("DeleteClientInsurance failed, exception: {0}.", e);
                success = false;
                throw;
            }

            return success;
        }

        public bool DeleteInsuranceAuthorizations(InsuranceAuthorization removingInsAuth)
        {
            DbCommand del_InsuranceAuthorization = db.GetStoredProcCommand("del_InsuranceAuthorization");

            db.AddInParameter(del_InsuranceAuthorization, "@insuranceAuthID", DbType.Int32, removingInsAuth.insuranceAuthID);

            db.AddOutParameter(del_InsuranceAuthorization, "@success", DbType.Boolean, 1);

            bool success;
            try
            {
                db.ExecuteNonQuery(del_InsuranceAuthorization);
                success = Convert.ToBoolean(db.GetParameterValue(del_InsuranceAuthorization, "@success"));
            }
            catch (Exception e)
            {
                Debug.WriteLine("DeleteClientInsuranceAuthorizations failed, exception: {0}.", e);
                success = false;
                throw;
            }

            return success;
        }

        public bool DeleteClientStaff(Staff removingStaff, Client currentClient)
        {
            DbCommand del_ClientStaff = db.GetStoredProcCommand("del_ClientStaff");

            db.AddInParameter(del_ClientStaff, "@staffID", DbType.Int32, removingStaff.staffID);
            db.AddInParameter(del_ClientStaff, "@clientID", DbType.Int32, currentClient.clientID);

            db.AddOutParameter(del_ClientStaff, "@success", DbType.Boolean, 1);

            bool success;
            try
            {
                db.ExecuteNonQuery(del_ClientStaff);
                success = Convert.ToBoolean(db.GetParameterValue(del_ClientStaff, "@success"));
            }
            catch (Exception e)
            {
                Debug.WriteLine("DeleteClientStaff failed, exception: {0}.", e);
                success = false;
                throw;
            }

            return success;
        }

        public bool DeleteClientPhysician(Physician removingPhysician, Client currentClient)
        {
            DbCommand del_ClientPhysician = db.GetStoredProcCommand("del_ClientPhysician");

            db.AddInParameter(del_ClientPhysician, "@physicianID", DbType.Int32, removingPhysician.physicianID);
            db.AddInParameter(del_ClientPhysician, "@clientID", DbType.Int32, currentClient.clientID);
            db.AddOutParameter(del_ClientPhysician, "@physicianID", DbType.Boolean, 1);

            bool success;
            try
            {
                db.ExecuteNonQuery(del_ClientPhysician);
                success = Convert.ToBoolean(db.GetParameterValue(del_ClientPhysician, "@success"));
            }
            catch (Exception e)
            {
                Debug.WriteLine("DeleteClientPhysician failed, exception: {0}.", e);
                success = false;
                throw;
            }


            return success;
        }

        public bool DeleteClientDiagnosis(Diagnosis removingDiagnosis, Client currentClient)
        {
            DbCommand del_ClientDiagnosis = db.GetStoredProcCommand("del_ClientDiagnosis");
            db.AddInParameter(del_ClientDiagnosis, "@diagnosisID", DbType.Int32, removingDiagnosis.diagnosisID);
            db.AddInParameter(del_ClientDiagnosis, "@diagnosisID", DbType.Int32, currentClient.clientID);

            db.AddOutParameter(del_ClientDiagnosis, "@success", DbType.Boolean, 1);

            bool success;
            try
            {
                db.ExecuteNonQuery(del_ClientDiagnosis);
                success = Convert.ToBoolean(db.GetParameterValue(del_ClientDiagnosis, "@success"));
            }
            catch (Exception e)
            {
                Debug.WriteLine("DeleteClientDiagnosis failed, exception: {0}.", e);
                success = false;
                throw;
            }

            return success;
        }

        public bool DeleteClientComment(Comments removingComment, Client currentClient)
        {
            DbCommand del_Comments = db.GetStoredProcCommand("del_ClientComments");
            db.AddInParameter(del_Comments, "@commentsID", DbType.Int32, removingComment.commentsID);
            db.AddInParameter(del_Comments, "@clientID", DbType.Int32, currentClient.clientID);

            db.AddOutParameter(del_Comments, "@success", DbType.Boolean, 1);

            bool success;
            try
            {
                db.ExecuteNonQuery(del_Comments);

                success = Convert.ToBoolean(db.GetParameterValue(del_Comments, "@success"));
            }
            catch (Exception e)
            {
                Debug.WriteLine("DeleteClientComments failed, exception: {0}.", e);
                success = false;
                throw;
            }

            return success;
        }
    }
}