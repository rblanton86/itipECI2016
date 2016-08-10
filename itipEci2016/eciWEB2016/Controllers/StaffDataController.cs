/***********************************************************************************************************
Description: Data Controller for Staff Controller
	 
Author: 
	Tyrell Powers-Crane 
Date: 
	6.29.2016
Change History:
	7.12.2016 -tpc- Added Update and Insert Methods
************************************************************************************************************/
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.Mvc;
using System.Configuration;
using System.Data;
using System.Data.Common;
using System.Text;
using System.Xml;

using Microsoft.Practices.EnterpriseLibrary.Common.Configuration;
using Microsoft.Practices.EnterpriseLibrary.Data;
using Microsoft.Practices.EnterpriseLibrary.Data.Sql;

using eciWEB2016.Models;
using eciWEB2016.Class;

namespace eciWEB2016.Controllers.DataControllers
{
    public class StaffDataController
    {
        public static SqlDatabase db;

        public StaffDataController()
        {
            if (db == null)
            {
                db = new SqlDatabase(WebConfigurationManager.ConnectionStrings["eciConnectionString"].ToString());
            }
        }

/************************************************************ GET METHODS ********************************************************/

        public DataSet GetAllStaff()
        {
            DbCommand dbCommand = db.GetStoredProcCommand("get_AllStaff");

            // db.AddInParameter(dbCommand, "@parameterName", DbType.TypeName, variableName);

            DataSet ds = db.ExecuteDataSet(dbCommand);

            return ds;
        }

        //gets info to populate member type
        public SelectList GetMemberTypeList()
        {
            DbCommand dbCommand = db.GetStoredProcCommand("get_AllMemberType");

            DataSet ds = db.ExecuteDataSet(dbCommand);

            var selectList = (from drRow in ds.Tables[0].AsEnumerable()
                              select new SelectListItem()
                              {
                                  Text = drRow.Field<string>("memberType"),
                                  Value = drRow.Field<int>("memberTypeID").ToString()

                              }).ToList();

            return new SelectList(selectList, "Value", "Text");
        }
            
            //gets info to populate contact info type 
            public SelectList GetContactTypeList()
        {
            DbCommand dbCommand = db.GetStoredProcCommand("get_AllAdditionalContactInfoType");

            DataSet ds = db.ExecuteDataSet(dbCommand);

            var selectList = (from drRow in ds.Tables[0].AsEnumerable()
                              select new SelectListItem()
                              {
                                  Text = drRow.Field<string>("additionalContactInfoType"),
                                  Value = drRow.Field<int>("additionalContactInfoTypeID").ToString()

                              }).ToList();

            return new SelectList(selectList, "Value", "Text");
        }

        //populates a dropdown of addresstype
        public SelectList GetAddressTypeList()
        {
            DbCommand dbCommand = db.GetStoredProcCommand("get_AllAddressTypes");

            DataSet ds = db.ExecuteDataSet(dbCommand);

            var selectList = (from drRow in ds.Tables[0].AsEnumerable()
                              select new SelectListItem()
                              {
                                  Text = drRow.Field<string>("addressesType"),
                                  Value = drRow.Field<int>("addressesTypeID").ToString()

                              }).ToList();

            return new SelectList(selectList, "Value", "Text");
        }

        public SelectList GetStatusList()
        {
            DbCommand dbCommand = db.GetStoredProcCommand("get_AllStatus");

            DataSet ds = db.ExecuteDataSet(dbCommand);

            var selectList = (from drRow in ds.Tables[0].AsEnumerable()
                              select new SelectListItem()
                              {
                                  Text = drRow.Field<string>("clientStatus"),
                                  Value = drRow.Field<int>("clientStatusID").ToString()

                              }).ToList();

            return new SelectList(selectList, "Value", "Text");
        }

        //populates a dropdown of stafftype
        public SelectList GetStaffTypeList()
        {
            DbCommand dbCommand = db.GetStoredProcCommand("get_StaffType");

            DataSet ds = db.ExecuteDataSet(dbCommand);

            var selectList = (from drRow in ds.Tables[0].AsEnumerable()
                              select new SelectListItem()
                              {
                                  Text = drRow.Field<string>("staffType"),
                                  Value = drRow.Field<int>("staffTypeID").ToString()

                              }).ToList();

            return new SelectList(selectList, "Value", "Text");
        }

        //populates a dropdown list of staff members
        public SelectList GetStaffDropDown()
        {
            DbCommand dbCommand = db.GetStoredProcCommand("get_AllStaff");

            DataSet ds = db.ExecuteDataSet(dbCommand);

            var selectList = (from drRow in ds.Tables[0].AsEnumerable()
                              select new SelectListItem()
                              {
                                  Text = drRow.Field<string>("firstName") + " " + drRow.Field<string>("lastName"),
                                  Value = drRow.Field<int>("staffID").ToString()
                              }).ToList();

            return new SelectList(selectList, "Value", "Text");
        }

        public Staff GetStaffMember(int staffID)
        {

            DbCommand dbCommand = db.GetStoredProcCommand("get_StaffByID");
            db.AddInParameter(dbCommand, "staffID", DbType.Int32, staffID);
            // db.AddInParameter(dbCommand, "@parameterName", DbType.TypeName, variableName);

            DataSet ds = db.ExecuteDataSet(dbCommand);

            DataRow dr = ds.Tables[0].Rows[0];

            Staff currentStaff = new Staff()
            {

                staffID = dr.Field<int>("staffID"),
                staffTypeID = dr.Field<int>("staffTypeID"),
                staffType = dr.Field<string>("staffType"),
                addressesID = dr.Field<int>("addressesID"),
                memberTypeID = dr.Field<int>("memberTypeID"),
                firstName = dr.Field<string>("firstName"),
                lastName = dr.Field<string>("lastName"),
                handicapped = dr.Field<bool>("handicapped"),
                fullName = dr.Field<string>("firstName") + " " + dr.Field<string>("lastName"),
                staffAltID = dr.Field<string>("staffAltID"),
                sexID = dr.Field<int>("sexID"),
                deleted = dr.Field<bool>("deleted"),
                SSN = dr.Field<int>("ssn"),
                DOB = dr.IsNull("dob") ? new DateTime(1900,1,1) : dr.Field<DateTime>("dob"),             
            };

            Address thisAddress = new Address()
            {
                addressesID = dr.Field<int>("addressesID"),
                addressTypeID = dr.Field<int>("addressesTypeID"),
                address1 = dr.Field<string>("address1"),
                address2 = dr.Field<string>("address2"),
                city = dr.Field<string>("city"),
                state = dr.Field<string>("st"),
                zip = dr.Field<int>("zip"),
                mapsco = dr.Field<string>("mapsco"),
                addressesType = dr.Field<string>("addressesType")
            };

            AdditionalContactInfoModel thisContact = new AdditionalContactInfoModel()
            {
                additionalContactInfoID = dr.Field<int>("additionalContactInfoID"),
                additionalContactInfo = dr.Field<string>("additionalContactInfo"),
                additionalContactInfoTypeID = dr.Field<int>("additionalContactInfoTypeID"),
                additionalContactInfoType = dr.Field<string>("additionalContactInfoType"),
            };

            //var timeHeaderList = (from drRow in ds.Tables[0].AsEnumerable()
            //                  select new TimeHeaderModel()
            //                  {
            //                      weekEnding = drRow.Field<string>("weekEnding")

            //                  }).ToList();

            

            currentStaff.staffAddress = thisAddress;
            currentStaff.staffContact = thisContact;
            


            //Addresses addr = new Addresses();
            //currentStaff.staffAddress = addr.GetAddressByDataSet(ds);

            return currentStaff;
        }

/********************************************************** UPDATE METHODS ***********************************************************/

        //update Staff Member
        public bool staffUpdate(Staff thisStaff, Address staffAddress, AdditionalContactInfoModel staffContact)
        {
            try
            {

                //Update Staff
                DbCommand upd_Staff = db.GetStoredProcCommand("upd_Staff");

                // db.AddInParameter(dbCommand, "@parameterName", DbType.TypeName, variableName);

                db.AddInParameter(upd_Staff, "@staffID", DbType.String, thisStaff.staffID);
                db.AddInParameter(upd_Staff, "@firstName", DbType.String, thisStaff.firstName);
                db.AddInParameter(upd_Staff, "@lastName", DbType.String, thisStaff.lastName);
                db.AddInParameter(upd_Staff, "@handicapped", DbType.Boolean, 0);
                db.AddInParameter(upd_Staff, "@staffAltID", DbType.String, thisStaff.staffAltID);
                db.AddInParameter(upd_Staff, "@deleted", DbType.Boolean, thisStaff.deleted);
                db.AddInParameter(upd_Staff, "@staffSSN", DbType.Int32, thisStaff.SSN);

                db.ExecuteNonQuery(upd_Staff);

                //update Staff's Addresses
                DbCommand upd_Addresses = db.GetStoredProcCommand("upd_Addresses");

                db.AddInParameter(upd_Addresses, "@memberID", DbType.Int32, thisStaff.staffID);
                db.AddInParameter(upd_Addresses, "@memberTypeID", DbType.Int32, thisStaff.memberTypeID);
                db.AddInParameter(upd_Addresses, "@addressesID", DbType.Int32, staffAddress.addressesID);
                db.AddInParameter(upd_Addresses, "@addressTypeID", DbType.Int32, staffAddress.addressesType);
                db.AddInParameter(upd_Addresses, "@address1", DbType.String, staffAddress.address1);
                db.AddInParameter(upd_Addresses, "@address2", DbType.String, staffAddress.address2);
                db.AddInParameter(upd_Addresses, "@city", DbType.String, staffAddress.city);
                db.AddInParameter(upd_Addresses, "@st", DbType.String, staffAddress.state);
                db.AddInParameter(upd_Addresses, "@zip", DbType.Int32, staffAddress.zip);
                db.AddInParameter(upd_Addresses, "@county", DbType.String, "");
                db.AddInParameter(upd_Addresses, "@deleted", DbType.Boolean, staffAddress.deleted);

                db.ExecuteNonQuery(upd_Addresses);

                //update Staff's Additional Contact Info
                DbCommand upd_AdditionalContactInfo = db.GetStoredProcCommand("upd_AdditionalContactInfo");

                db.AddInParameter(upd_AdditionalContactInfo, "@additionalContactInfoID", DbType.Int32, staffContact.additionalContactInfoID);
                db.AddInParameter(upd_AdditionalContactInfo, "@additionalContactInfo", DbType.String, staffContact.additionalContactInfo);
                db.AddInParameter(upd_AdditionalContactInfo, "@additionalContactInfoTypeID", DbType.Int32, staffContact.additionalContactInfoTypeID);
                db.AddInParameter(upd_AdditionalContactInfo, "@deleted", DbType.Boolean, staffContact.deleted);

                db.ExecuteNonQuery(upd_AdditionalContactInfo);

                return true;
            }
            catch
            {
                return false;
            }
        }

/*********************************************************** INSERT METHODS *******************************************************/


        public bool InsertStaff(Staff thisStaff, Address thisAddress, AdditionalContactInfoModel staffContact)
        {
            try
            {

                int addressID;
                string staffAltID;
                int staffID;
                string shortFirst;
                string shortLast;

                shortFirst = StringTool.Truncate(thisStaff.firstName, 4);
                shortLast = StringTool.Truncate(thisStaff.lastName, 4);

                //insert Staff's Addresses
                DbCommand ins_Addresses = db.GetStoredProcCommand("ins_Addresses");
                db.AddInParameter(ins_Addresses, "@memberID", DbType.Int32, thisStaff.staffID);
                db.AddInParameter(ins_Addresses, "@memberTypeID", DbType.Int32, thisStaff.memberTypeID);
                db.AddInParameter(ins_Addresses, "@addressTypeID", DbType.Int32, thisAddress.addressTypeID);
                db.AddInParameter(ins_Addresses, "@address1", DbType.String, thisAddress.address1);
                db.AddInParameter(ins_Addresses, "@address2", DbType.String, thisAddress.address2);
                db.AddInParameter(ins_Addresses, "@city", DbType.String, thisAddress.city);
                db.AddInParameter(ins_Addresses, "@st", DbType.String, thisAddress.state);
                db.AddInParameter(ins_Addresses, "@zip", DbType.Int32, thisAddress.zip);
                db.AddInParameter(ins_Addresses, "@county", DbType.String, "");
                db.AddInParameter(ins_Addresses, "@deleted", DbType.Boolean, false);
                db.AddOutParameter(ins_Addresses, "@addressID", DbType.Int32, sizeof(Int32));
                db.ExecuteScalar(ins_Addresses);
                addressID = (int)db.GetParameterValue(ins_Addresses, "@addressID");


                //Inserts staff
                DbCommand ins_Staff = db.GetStoredProcCommand("ins_StaffMember");


                db.AddInParameter(ins_Staff, "@staffTypeID", DbType.Int32, thisStaff.staffTypeID);
                db.AddInParameter(ins_Staff, "@addressesID", DbType.Int32, Convert.ToInt32(addressID));
                db.AddInParameter(ins_Staff, "@memberTypeID", DbType.Int32, thisStaff.memberTypeID);
                db.AddInParameter(ins_Staff, "@firstName", DbType.String, thisStaff.firstName);
                db.AddInParameter(ins_Staff, "@lastName", DbType.String, thisStaff.lastName);
                db.AddInParameter(ins_Staff, "@handicapped", DbType.Boolean, thisStaff.handicapped);
                db.AddInParameter(ins_Staff, "@staffAltID", DbType.String, thisStaff.staffAltID);
                db.AddInParameter(ins_Staff, "@deleted", DbType.Boolean, thisStaff.deleted);
                db.AddInParameter(ins_Staff, "@ssn", DbType.String, thisStaff.SSN);
                db.AddInParameter(ins_Staff, "@dob", DbType.Date, thisStaff.DOB);
                db.AddInParameter(ins_Staff, "@staffStatus", DbType.Int32, thisStaff.status);
                db.AddOutParameter(ins_Staff, "@staffID", DbType.Int32, sizeof(int));
                db.ExecuteScalar(ins_Staff);
                staffID = (int)db.GetParameterValue(ins_Staff, "@staffID");


                //insert Staff's Additional Contact Info
                DbCommand ins_AdditionalContactInfo = db.GetStoredProcCommand("ins_AdditionalContactInfo");

                db.AddInParameter(ins_AdditionalContactInfo, "@memberTypeID", DbType.Int32, thisStaff.memberTypeID);
                db.AddInParameter(ins_AdditionalContactInfo, "@additionalContactInfo", DbType.String, staffContact.additionalContactInfo);
                db.AddInParameter(ins_AdditionalContactInfo, "@additionalContactInfoTypeID", DbType.Int32, staffContact.additionalContactInfoTypeID);
                db.AddInParameter(ins_AdditionalContactInfo, "@deleted", DbType.Boolean, false);
                db.AddInParameter(ins_AdditionalContactInfo, "@memberID", DbType.Int32, staffID);
                db.ExecuteNonQuery(ins_AdditionalContactInfo);

                //enters Staff Alt ID into table
                staffAltID = shortFirst + shortLast + thisStaff.staffID.ToString();

                DbCommand upd_StaffAltID = db.GetStoredProcCommand("upd_StaffAltID");

                db.AddInParameter(upd_StaffAltID, "@staffID", DbType.Int32, staffID);
                db.AddInParameter(upd_StaffAltID, "@staffAltID", DbType.String, staffAltID);
                db.ExecuteNonQuery(upd_StaffAltID);

                return true;
            }
            catch
            {
                return false;
            }
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

            /// <summary>
            /// Get a substring of the first N characters. [Slow]
            /// </summary>
            public static string Truncate2(string source, int length)
            {
                return source.Substring(0, Math.Min(length, source.Length));
            }
        }

    }
}



//get a staff member from the database based on ID
//public Staff getStaffMember(int currentStaffID)
//{
//    Staff thisStaffMember = new Staff();

//    DbCommand getStaffMemberByID = db.GetStoredProcCommand("get_StaffByID");

//    var param = getStaffMemberByID.CreateParameter();
//    param.ParameterName = "@staffID";
//    param.Value = currentStaffID;
//    getStaffMemberByID.Parameters.Add(param);

//    using (getStaffMemberByID)
//    {
//        using (IDataReader staffReader = db.ExecuteReader(getStaffMemberByID))
//        {
//            if (staffReader.Read() == true)
//            {
//                int ordinal = staffReader.GetOrdinal("staffID");
//                thisStaffMember.staffID = staffReader.IsDBNull(ordinal) ? 0 : staffReader.GetInt32(ordinal);

//                ordinal = staffReader.GetOrdinal("firstName");
//                thisStaffMember.firstName = staffReader.IsDBNull(ordinal) ? " " : staffReader.GetString(ordinal);

//                ordinal = staffReader.GetOrdinal("lastName");
//                thisStaffMember.lastName = staffReader.IsDBNull(ordinal) ? " " : staffReader.GetString(ordinal);

//                thisStaffMember.fullName = thisStaffMember.firstName + " " + thisStaffMember.lastName;

//                ordinal = staffReader.GetOrdinal("staffSSN");
//                thisStaffMember.SSN = staffReader.IsDBNull(ordinal) ? 0 : staffReader.GetInt32(ordinal);


//                Address staffAddres = new Address();

//                ordinal = staffReader.GetOrdinal("address1");
//                staffAddres.address1 = staffReader.IsDBNull(ordinal) ? " " : staffReader.GetString(ordinal);

//                ordinal = staffReader.GetOrdinal("city");
//                staffAddres.city = staffReader.IsDBNull(ordinal) ? " " : staffReader.GetString(ordinal);

//                ordinal = staffReader.GetOrdinal("st");
//                staffAddres.state = staffReader.IsDBNull(ordinal) ? " " : staffReader.GetString(ordinal);

//                ordinal = staffReader.GetOrdinal("zip");
//                staffAddres.zip = staffReader.IsDBNull(ordinal) ? 0 : staffReader.GetInt32(ordinal);

//                ordinal = staffReader.GetOrdinal("staffAltID");
//                thisStaffMember.staffAltID = staffReader.IsDBNull(ordinal) ? " " : staffReader.GetString(ordinal);

//                thisStaffMember.staffAddress = staffAddres;

//                AdditionalContactInfoModel staffContact = new AdditionalContactInfoModel();

//                ordinal = staffReader.GetOrdinal("additionalContactInfo");
//                staffContact.additionalContactInfo = staffReader.IsDBNull(ordinal) ? " " : staffReader.GetString(ordinal);

//                thisStaffMember.staffContact = staffContact;

//                ordinal = staffReader.GetOrdinal("staffDOB");
//                thisStaffMember.DOB = staffReader.IsDBNull(ordinal) ? DateTime.Now : staffReader.GetDateTime(ordinal);

//            }
//            else
//            {
//                return null;
//            }
//        }
//    }

//    return thisStaffMember;
//}