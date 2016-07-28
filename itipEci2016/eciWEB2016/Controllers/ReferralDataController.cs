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

        public Client InsertClientAddress(Client newClient)
        {
            DbCommand ins_Address = db.GetStoredProcCommand("ins_Addresses");
            db.AddInParameter(ins_Address, "@addressTypeID", DbType.Int32, newClient.clientAddress.addressTypeID);
            db.AddInParameter(ins_Address, "@address1", DbType.String, newClient.clientAddress.address1);
            db.AddInParameter(ins_Address, "@address2", DbType.String, newClient.clientAddress.address2);
            db.AddInParameter(ins_Address, "@city", DbType.String, newClient.clientAddress.city);
            db.AddInParameter(ins_Address, "@st", DbType.String, newClient.clientAddress.state);
            db.AddInParameter(ins_Address, "@zip", DbType.Int32, newClient.clientAddress.zip);
            db.AddInParameter(ins_Address, "@mapsco", DbType.String, newClient.clientAddress.mapsco);
            db.AddInParameter(ins_Address, "@deleted", DbType.Int32, 0);

            db.AddOutParameter(ins_Address, "@addressID", DbType.Int32, sizeof(int));

            try
            {
                db.ExecuteNonQuery(ins_Address);

                newClient.clientAddress.addressesID = Convert.ToInt32(db.GetParameterValue(ins_Address, "@addressID"));
            }
            catch (Exception e)
            {
                Debug.WriteLine("InsertClientAddress failed, exception: {0}", e);
                throw;
            }


            return newClient;
        }

        public Client InsertClient(Client newClient)
        {
            if (newClient.clientAddress.addressesID == 0)
            {
                newClient = InsertClientAddress(newClient);
            }

            DbCommand ins_Client = db.GetStoredProcCommand("ins_Client");
            db.AddInParameter(ins_Client, "@raceID", DbType.Int32, newClient.raceID);
            db.AddInParameter(ins_Client, "@ethnicityID", DbType.Int32, newClient.ethnicityID);
            db.AddInParameter(ins_Client, "@clientStatusID", DbType.Int32, newClient.clientStatusID);
            db.AddInParameter(ins_Client, "@primaryLanguageID", DbType.Int32, newClient.primaryLanguageID);
            db.AddInParameter(ins_Client, "@schoolInfoID", DbType.Int32, newClient.schoolInfoID);
            db.AddInParameter(ins_Client, "@communicationPreferencesID", DbType.Int32, newClient.communicationPreferencesID);
            db.AddInParameter(ins_Client, "@sexID", DbType.Int32, newClient.sexID);
            db.AddInParameter(ins_Client, "@officeID", DbType.Int32, newClient.officeID);
            db.AddInParameter(ins_Client, "@addressesID", DbType.Int32, newClient.clientAddress.addressesID);
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