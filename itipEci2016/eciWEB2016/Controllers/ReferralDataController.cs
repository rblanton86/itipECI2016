using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

using eciWEB2016.Models;
using eciWEB2016.Class;
using System.Data.Common;
using Microsoft.Practices.EnterpriseLibrary.Data.Sql;
using System.Web.Configuration;
using System.Data;
using System.Diagnostics;
using eciWEB2016.Controllers.DataControllers;

namespace eciWEB2016.Controllers
{
    public class ReferralDataController
    {
        public static SqlDatabase db;

        private ClientDataController clientDataController = new ClientDataController();

        private ClientController clientController = new ClientController();

        private AddressesDataController addressDataControler = new AddressesDataController();

        /// <summary>
        /// Creates a database connection if one has not been initiated.
        /// </summary>
        public ReferralDataController()
        {
            if (db == null)
            {
                db = new SqlDatabase(WebConfigurationManager.ConnectionStrings["eciConnectionString"].ToString());
            }
        }

        public Client InsertNewClient(Client newClient)
        {
            if (newClient.clientID == 0)
            {
                newClient = InsertClient(newClient);
            };

            for (int family = 0; family <= newClient.clientFamily.Count(); family++)
            {
                if (newClient.clientFamily[family].familyMemberID == 0)
                {
                    newClient.clientFamily[family] = InsertClientFamily(newClient.clientFamily[family], newClient.clientID);
                }
            };

            for (int referral = 0; referral <= newClient.clientReferrals.Count(); referral++)
            {
                newClient.clientReferrals[referral] = InsertClientReferral(newClient.clientReferrals[referral], newClient.clientID);
            };

            return newClient;
        }

        public Client InsertClient(Client newClient)
        {
            DbCommand ins_Client = db.GetStoredProcCommand("ins_Client");
            db.AddInParameter(ins_Client, "@raceID", DbType.Int32, newClient.raceID);
            db.AddInParameter(ins_Client, "@ethnicityID", DbType.Int32, newClient.ethnicityID);
            db.AddInParameter(ins_Client, "@clientStatusID", DbType.Int32, newClient.clientStatusID);
            db.AddInParameter(ins_Client, "@primaryLanguageID", DbType.Int32, newClient.primaryLanguageID);
            db.AddInParameter(ins_Client, "@schoolInfoID", DbType.Int32, newClient.schoolInfoID);
            db.AddInParameter(ins_Client, "@communicationPreferencesID", DbType.Int32, newClient.communicationPreferencesID);
            db.AddInParameter(ins_Client, "@sexID", DbType.Int32, newClient.sexID);
            db.AddInParameter(ins_Client, "@officeID", DbType.Int32, newClient.officeID);
            db.AddInParameter(ins_Client, "@firstName", DbType.String, newClient.firstName);
            db.AddInParameter(ins_Client, "@middleInitial", DbType.String, newClient.middleInitial);
            db.AddInParameter(ins_Client, "@lastName", DbType.String, newClient.lastName);
            db.AddInParameter(ins_Client, "@dob", DbType.Date, newClient.dob);
            db.AddInParameter(ins_Client, "@ssn", DbType.Int32, newClient.ssn);
            db.AddInParameter(ins_Client, "@referralSource", DbType.String, newClient.referralSource);
            db.AddInParameter(ins_Client, "@intakeDate", DbType.Date, (DateTime)System.Data.SqlTypes.SqlDateTime.Parse(DateTime.Now.ToString()));
            db.AddInParameter(ins_Client, "@ifspDate", DbType.Date, (DateTime)System.Data.SqlTypes.SqlDateTime.Parse(newClient.ifspDate.ToString()));
            db.AddInParameter(ins_Client, "@compSvcDate", DbType.Date, (DateTime)System.Data.SqlTypes.SqlDateTime.Parse(newClient.compSvcDate.ToString()));
            db.AddInParameter(ins_Client, "@serviceAreaException", DbType.Boolean, newClient.serviceAreaException);
            db.AddInParameter(ins_Client, "@tkidsCaseNumber", DbType.Int32, newClient.TKIDcaseNumber);
            db.AddInParameter(ins_Client, "@consentToRelease", DbType.Boolean, newClient.consentRelease);
            db.AddInParameter(ins_Client, "@eci", DbType.String, newClient.ECI);
            db.AddInParameter(ins_Client, "@accountingSystemID", DbType.String, newClient.accountingSystemID);

            db.AddOutParameter(ins_Client, "@success", DbType.Boolean, 1);
            db.AddOutParameter(ins_Client, "@clientID", DbType.Int32, sizeof(int));

            try
            {
                db.ExecuteNonQuery(ins_Client);

                newClient.clientID = Convert.ToInt32(db.GetParameterValue(ins_Client, "@clientID"));

                newClient.altID = StringTool.Truncate(newClient.lastName, 4).ToUpper() + StringTool.Truncate(newClient.firstName, 4).ToUpper() + newClient.clientID.ToString();

                ClientDataController clientDataController = new ClientDataController();
                bool success = clientDataController.UpdateClient(newClient);
            }
            catch (Exception e)
            {
                Debug.WriteLine("InsertClient failed, exception: {0}", e);
                throw;
            }

            return newClient;
        }

        /// <summary>
        /// Inserts a link between the created client and the selected staff member.
        /// </summary>
        /// <param name="newStaff">Staff Object</param>
        /// <returns>Staff object with additional staff information queries from database.</returns>
        public Staff InsertClientStaff(Staff newStaff, int clientID)
        {
            DbCommand ins_ClientStaff = db.GetStoredProcCommand("ins_ClientStaff");
            db.AddInParameter(ins_ClientStaff, "@clientID", DbType.Int32, clientID);
            db.AddInParameter(ins_ClientStaff, "@staffID", DbType.Int32, newStaff.staffID);

            try
            {
                DataSet ds = db.ExecuteDataSet(ins_ClientStaff);

                DataRow staffRow = ds.Tables[0].Rows[0];

                newStaff = new Staff()
                {
                    staffID = staffRow.Field<int>("staffID"),
                    staffTypeID = staffRow.Field<int>("staffTypeID"),
                    staffType = staffRow.Field<string>("staffType"),
                    addressesID = staffRow.Field<int>("adstaffRowessesID"),
                    memberTypeID = staffRow.Field<int>("memberTypeID"),
                    firstName = staffRow.Field<string>("firstName"),
                    lastName = staffRow.Field<string>("lastName"),
                    handicapped = staffRow.Field<bool>("handicapped"),
                    fullName = staffRow.Field<string>("firstName") + " " + staffRow.Field<string>("lastName"),
                    staffAltID = staffRow.Field<string>("staffAltID"),
                    sexID = staffRow.Field<int>("sexID"),
                    deleted = staffRow.Field<bool>("deleted"),
                    SSN = staffRow.Field<int>("ssn"),
                    DOB = staffRow.IsNull("dob") ? new DateTime(1900, 1, 1) : staffRow.Field<DateTime>("dob")
                };

                var staffContact = (from drRow in ds.Tables[1].AsEnumerable()
                                    select new AdditionalContactInfoModel()
                                    {
                                        additionalContactInfoID = drRow.Field<int>("additionalContactInfoID"),
                                        additionalContactInfo = drRow.Field<string>("additionalContactInfo"),
                                        additionalContactInfoTypeID = drRow.Field<int>("additionalContactInfoTypeID"),
                                        additionalContactInfoType = drRow.Field<string>("additionalContactInfoType")
                                    }).ToList();

                newStaff.staffContactList = staffContact;

                DataRow addressRow = ds.Tables[2].Rows[0];

                var address = new Address()
                {
                    addressesID = addressRow.Field<int>("addressesID"),
                    address1 = addressRow.Field<string>("address1"),
                    address2 = addressRow.Field<string>("address2"),
                    city = addressRow.Field<string>("city"),
                    state = addressRow.Field<string>("st"),
                    zip = addressRow.Field<int>("zip"),
                    mapsco = addressRow.Field<string>("maspco")
                };

                newStaff.staffAddress = address;

                // Currently not needed, as staff model doesn't contain a list of addresses.
                //var addressList = (from drRow in ds.Tables[2].AsEnumerable()
                //                       select new Address()
                //                       {

                //                       }).ToList();
            }
            catch (Exception e)
            {
                Debug.WriteLine("InsertClientStaff failed, exception: {0}", e);
                throw;
            }

            return newStaff;
        }

        public Referral InsertClientReferral(Referral createdReferral, int clientID)
        {
            //// Creates a call to the stored procedure with which each referral will be added.
            //DbCommand ins_Referral = db.GetStoredProcCommand("ins_Referral");
            //db.AddInParameter();

            return createdReferral;
        }

        public Family InsertClientFamily(Family createdFamily, int clientID)
        {
            // Creates a call to the stored procedure with which each family member will be added.
            DbCommand ins_FamilyMember = db.GetStoredProcCommand("ins_FamilyMember");

            // Adds in/out parameters.
            db.AddInParameter(ins_FamilyMember, "@familyMemberTypeID", DbType.Int32, createdFamily.familyMemberTypeID);
            db.AddInParameter(ins_FamilyMember, "@clientID", DbType.Int32, clientID);
            db.AddInParameter(ins_FamilyMember, "@firstName", DbType.String, createdFamily.firstName);
            db.AddInParameter(ins_FamilyMember, "@lastName", DbType.String, createdFamily.lastName);
            db.AddInParameter(ins_FamilyMember, "@isGuardian", DbType.Boolean, createdFamily.isGuardian);
            db.AddInParameter(ins_FamilyMember, "@sexID", DbType.Int32, createdFamily.sexID);
            db.AddInParameter(ins_FamilyMember, "@raceID", DbType.Int32, createdFamily.raceID);
            db.AddInParameter(ins_FamilyMember, "@occupation", DbType.String, createdFamily.occupation);
            db.AddInParameter(ins_FamilyMember, "@employer", DbType.String, createdFamily.employer);
            db.AddInParameter(ins_FamilyMember, "@dob", DbType.Date, createdFamily.dob);

            db.AddOutParameter(ins_FamilyMember, "@success", DbType.Boolean, 1);
            db.AddOutParameter(ins_FamilyMember, "@familyMemberID", DbType.Int32, sizeof(Int32));

            bool success;

            try
            {
                // Inserts the family member on the database and links to the patient.
                db.ExecuteNonQuery(ins_FamilyMember);

                // Returns the familyMemberID created on the database.
                success = Convert.ToBoolean(db.GetParameterValue(ins_FamilyMember, "@success"));
                createdFamily.familyMemberID = Convert.ToInt32(db.GetParameterValue(ins_FamilyMember, "@familyMemberID")); ;
            }
            catch (Exception e)
            {
                Debug.WriteLine("InsertClientFamily failed, exception: {0}.", e);
                success = false;
            }

            return createdFamily;
        }

        public ClientInsurance InsertClientInsurance(ClientInsurance createdInsurance, int clientID)
        {
            DbCommand ins_ClientInsurance = db.GetStoredProcCommand("ins_ClientInsurance");

            db.AddInParameter(ins_ClientInsurance, "@clientID", DbType.Int32, clientID);
            db.AddInParameter(ins_ClientInsurance, "@insuranceID", DbType.Int32, createdInsurance.insuranceID);
            db.AddInParameter(ins_ClientInsurance, "@insurancePolicyID", DbType.String, createdInsurance.insurancePolicyID);
            db.AddInParameter(ins_ClientInsurance, "@insurancePolicyName", DbType.String, createdInsurance.insuranceName);
            db.AddInParameter(ins_ClientInsurance, "@insuranceMedPreAuthNumber", DbType.Int32, createdInsurance.medPreAuthNumber);

            db.AddOutParameter(ins_ClientInsurance, "@success", DbType.Boolean, 1);
            db.AddOutParameter(ins_ClientInsurance, "@insuranceID", DbType.Int32, sizeof(int));

            bool success;
            try
            {
                db.ExecuteNonQuery(ins_ClientInsurance);
                success = Convert.ToBoolean(db.GetParameterValue(ins_ClientInsurance, "@success"));

                if (createdInsurance.insuranceAuthorization.Count > 0)
                {
                    createdInsurance = InsertInsuranceAuthorizations(createdInsurance, clientID);
                }
            }
            catch (Exception e)
            {
                Debug.WriteLine("InsertClientInsurance failed, exception: {0}.", e);
                success = false;
                throw;
            }

            return createdInsurance;
        }

        public ClientInsurance InsertInsuranceAuthorizations(ClientInsurance ins, int clientID)
        {
            for (int insAuth = 0; insAuth < ins.insuranceAuthorization.Count; insAuth++)
            {
                DbCommand ins_InsuranceAuthorization = db.GetStoredProcCommand("ins_InsuranceAuthorization");
                db.AddInParameter(ins_InsuranceAuthorization, "@clientID", DbType.Int32, clientID);
                db.AddInParameter(ins_InsuranceAuthorization, "@insuranceID", DbType.Int32, ins.insuranceID);
                db.AddInParameter(ins_InsuranceAuthorization, "@authorized_From", DbType.Boolean, ins.insuranceAuthorization[insAuth].authorizedFrom);
                db.AddInParameter(ins_InsuranceAuthorization, "@authorized_To", DbType.Boolean, ins.insuranceAuthorization[insAuth].authorizedTo);
                db.AddInParameter(ins_InsuranceAuthorization, "@insuranceAuthorizationType", DbType.String, ins.insuranceAuthorization[insAuth].insuranceAuthorizationType);

                db.AddOutParameter(ins_InsuranceAuthorization, "@success", DbType.Boolean, 1);
                db.AddOutParameter(ins_InsuranceAuthorization, "@insuranceAuthorizationID", DbType.Int32, sizeof(int));

                bool success;
                try
                {
                    db.ExecuteNonQuery(ins_InsuranceAuthorization);
                    success = Convert.ToBoolean(db.GetParameterValue(ins_InsuranceAuthorization, "@success"));
                    ins.insuranceAuthorization[insAuth].insuranceAuthID = Convert.ToInt32(db.GetParameterValue(ins_InsuranceAuthorization, "@insuranceAuthorizationID"));
                }
                catch (Exception e)
                {
                    Debug.WriteLine("InsertClientInsuranceAuthorization failed, exception: {0}.", e);
                    success = false;
                    throw;
                }
            }

            return ins;
        }

        public Physician InsertClientPhysician(Physician linkedPhysician, int clientID)
        {
            DbCommand ins_ClientPhysician = db.GetStoredProcCommand("ins_ClientPhysician");

            db.AddInParameter(ins_ClientPhysician, "@clientID", DbType.Int32, clientID);
            db.AddInParameter(ins_ClientPhysician, "@physicianID", DbType.Int32, linkedPhysician.physicianID);

            db.AddOutParameter(ins_ClientPhysician, "@physicianID", DbType.Boolean, 1);

            bool success;

            try
            {
                db.ExecuteNonQuery(ins_ClientPhysician);
                success = Convert.ToBoolean(db.GetParameterValue(ins_ClientPhysician, "@success"));
            }
            catch (Exception e)
            {
                Debug.WriteLine("InsertClientPhysician failed, exception: {0}.", e);
                success = false;
                throw;
            }


            return linkedPhysician;
        }

        public Diagnosis InsertClientDiagnosis(Diagnosis clientDiagnosis, int clientID)
        {
            DbCommand ins_ClientDiagnosis = db.GetStoredProcCommand("ins_ClientDiagnosis");
            db.AddInParameter(ins_ClientDiagnosis, "@clientID", DbType.Int32, clientID);
            db.AddInParameter(ins_ClientDiagnosis, "@diagnosisCodeID", DbType.Int32, clientDiagnosis.diagnosisCodeID);
            db.AddInParameter(ins_ClientDiagnosis, "@diagnosisTypeID", DbType.Int32, clientDiagnosis.diagnosisTypeID);
            db.AddInParameter(ins_ClientDiagnosis, "@diagnosis_From", DbType.DateTime, clientDiagnosis.diagnosisFrom);
            db.AddInParameter(ins_ClientDiagnosis, "@diagnosis_To", DbType.DateTime, clientDiagnosis.diagnosisTo);
            db.AddInParameter(ins_ClientDiagnosis, "@isPrimary", DbType.Boolean, clientDiagnosis.isPrimary);

            db.AddOutParameter(ins_ClientDiagnosis, "@success", DbType.Boolean, 1);
            db.AddOutParameter(ins_ClientDiagnosis, "@diagnosisID", DbType.Int32, sizeof(int));

            bool success;
            try
            {
                db.ExecuteNonQuery(ins_ClientDiagnosis);
                success = Convert.ToBoolean(db.GetParameterValue(ins_ClientDiagnosis, "@success"));
                clientDiagnosis.diagnosisID = Convert.ToInt32(db.GetParameterValue(ins_ClientDiagnosis, "@diagnosisID"));
            }
            catch (Exception e)
            {
                Debug.WriteLine("InsertClientDiagnosis failed, exception: {0}.", e);
                success = false;
                throw;
            }

            return clientDiagnosis;
        }

        public Comments InsertClientComments(Comments clientComments, int clientID, int memberTypeID)
        {
            DbCommand ins_ClientComments = db.GetStoredProcCommand("ins_ClientComments");
            db.AddInParameter(ins_ClientComments, "@memberID", DbType.Int32, clientID);
            db.AddInParameter(ins_ClientComments, "@memberTypeID", DbType.Int32, memberTypeID);
            db.AddInParameter(ins_ClientComments, "@comments", DbType.String, clientComments.comments);
            db.AddInParameter(ins_ClientComments, "@commentsTypeID", DbType.Int32, clientComments.commentsTypeID);

            db.AddOutParameter(ins_ClientComments, "@commentsID", DbType.Int32, sizeof(int));
            db.AddOutParameter(ins_ClientComments, "@success", DbType.Boolean, 1);

            bool success;
            try
            {
                db.ExecuteNonQuery(ins_ClientComments);

                clientComments.commentsID = Convert.ToInt32(db.GetParameterValue(ins_ClientComments, "@commentsID"));
                success = Convert.ToBoolean(db.GetParameterValue(ins_ClientComments, "@success"));
            }
            catch (Exception e)
            {
                Debug.WriteLine("InsertClientComments failed, exception: {0}.", e);
                success = false;
                throw;
            }
            return clientComments;
        }

        public static class StringTool
        {
            /// <summary>
            /// Get a substring of the first N characters.
            /// </summary>
            public static string Truncate(string source, int length)
            {
                if (source.Length > length)
                {
                    source = source.Substring(0, length);
                }
                return source;
            }
        }
    }
}