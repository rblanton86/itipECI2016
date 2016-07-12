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

        public DataSet GetAllStaff()
        {
            DbCommand dbCommand = db.GetStoredProcCommand("get_AllStaff");

            // db.AddInParameter(dbCommand, "@parameterName", DbType.TypeName, variableName);

            DataSet ds = db.ExecuteDataSet(dbCommand);

            return ds;
        }

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

        //get a staff member from the database based on ID
        public Staff getStaffMember(int currentStaffID)
        {
            Staff thisStaffMember = new Staff();

            DbCommand getStaffMemberByID = db.GetStoredProcCommand("get_StaffByID");

            var param = getStaffMemberByID.CreateParameter();
            param.ParameterName = "@staffID";
            param.Value = currentStaffID;
            getStaffMemberByID.Parameters.Add(param);

            using (getStaffMemberByID)
            {
                using (IDataReader staffReader = db.ExecuteReader(getStaffMemberByID))
                {
                    if (staffReader.Read() == true)
                    {
                        int ordinal = staffReader.GetOrdinal("staffID");
                        thisStaffMember.staffID = staffReader.IsDBNull(ordinal) ? 0 : staffReader.GetInt32(ordinal);

                        ordinal = staffReader.GetOrdinal("firstName");
                        thisStaffMember.firstName = staffReader.IsDBNull(ordinal) ? " " : staffReader.GetString(ordinal);

                        ordinal = staffReader.GetOrdinal("lastName");
                        thisStaffMember.lastName = staffReader.IsDBNull(ordinal) ? " " : staffReader.GetString(ordinal);

                        thisStaffMember.fullName = thisStaffMember.firstName + " " + thisStaffMember.lastName;

                        ordinal = staffReader.GetOrdinal("staffSSN");
                        thisStaffMember.SSN = staffReader.IsDBNull(ordinal) ? 0 : staffReader.GetInt32(ordinal);

                        ordinal = staffReader.GetOrdinal("address1");
                        ordinal = staffReader.GetOrdinal("city");
                        ordinal = staffReader.GetOrdinal("state");
                        ordinal = staffReader.GetOrdinal("zip");
                        Address staffAddres = new Address();
                        staffAddres.address1 = staffReader.IsDBNull(ordinal) ? " " : staffReader.GetString(ordinal);
                        staffAddres.city = staffReader.IsDBNull(ordinal) ? " " : staffReader.GetString(ordinal);
                        staffAddres.state = staffReader.IsDBNull(ordinal) ? " " : staffReader.GetString(ordinal);
                        staffAddres.zip = staffReader.IsDBNull(ordinal) ? 0 : staffReader.GetInt32(ordinal);
                        thisStaffMember.staffAddress = staffAddres;

                        ordinal = staffReader.GetOrdinal("staffAltID");
                        thisStaffMember.staffAltID = staffReader.IsDBNull(ordinal) ? " " : staffReader.GetString(ordinal);

                        ordinal = staffReader.GetOrdinal("additionalContactInfo");
                        AdditionalContactInfoModel staffContact = new AdditionalContactInfoModel();
                        staffContact.additionalContactInfo = staffReader.IsDBNull(ordinal) ? " " : staffReader.GetString(ordinal);
                        
                        //ordinal = staffReader.GetOrdinal("dob");
                        //thisStaffMember.DOB = staffReader.IsDBNull(ordinal) ? " " : staffReader.GetString(ordinal);


                    }
                    else
                    {
                        return null;
                    }
                }
            }

            return thisStaffMember;
        }

        //update Staff Member

        public bool staffUpdate(Staff thisStaff)
        {
            try
            {

                //Update Staff
                DbCommand upd_Staff = db.GetStoredProcCommand("upd_Staff");

                // db.AddInParameter(dbCommand, "@parameterName", DbType.TypeName, variableName);

                db.AddInParameter(upd_Staff, "@staffID", DbType.Int32, thisStaff.staffID);
                db.AddInParameter(upd_Staff, "@firstName", DbType.String, thisStaff.firstName);
                db.AddInParameter(upd_Staff, "@lastName", DbType.String, thisStaff.lastName);
                db.AddInParameter(upd_Staff, "@handicapped", DbType.Boolean, thisStaff.handicapped);
                db.AddInParameter(upd_Staff, "@staffAltID", DbType.String, thisStaff.staffAltID);
                db.AddInParameter(upd_Staff, "@deleted", DbType.Boolean, thisStaff.deleted);
                db.AddInParameter(upd_Staff, "@staffSSN", DbType.String, thisStaff.firstName);

                db.ExecuteNonQuery(upd_Staff);

                //update Staff's Addresses
                DbCommand upd_Addresses = db.GetStoredProcCommand("upd_Addresses");

                db.AddInParameter(upd_Addresses, "@addressesID", DbType.Int32, thisStaff.staffAddress.addressesID);
                db.AddInParameter(upd_Addresses, "@addressTypeID", DbType.Int32, thisStaff.staffAddress.addressTypeID);
                db.AddInParameter(upd_Addresses, "@address1", DbType.String, thisStaff.staffAddress.address1);
                db.AddInParameter(upd_Addresses, "@address2", DbType.String, thisStaff.staffAddress.address2);
                db.AddInParameter(upd_Addresses, "@city", DbType.String, thisStaff.staffAddress.city);
                db.AddInParameter(upd_Addresses, "@st", DbType.String, thisStaff.staffAddress.state);
                db.AddInParameter(upd_Addresses, "@zip", DbType.Int32, thisStaff.staffAddress.zip);
                db.AddInParameter(upd_Addresses, "@deleted", DbType.Boolean, thisStaff.staffAddress.deleted);

                db.ExecuteNonQuery(upd_Addresses);

                //update Staff's Additional Contact Info
                DbCommand upd_AdditionalContactInfo = db.GetStoredProcCommand("upd_AdditionalContactInfo");

                db.AddInParameter(upd_AdditionalContactInfo, "@additionalContactInfo", DbType.String, thisStaff.staffContact.additionalContactInfo);
                db.AddInParameter(upd_AdditionalContactInfo, "@additionalContactInfoTypeID", DbType.Int32, thisStaff.staffContact.additionalContactInfoTypeID);
                db.AddInParameter(upd_AdditionalContactInfo, "@deleted", DbType.Boolean, thisStaff.staffContact.deleted);

                db.ExecuteNonQuery(upd_AdditionalContactInfo);

                return true;
            }
            catch
            {
                return false;
            }
        }

        public bool InsertStaff(Staff thisStaff)
        {
            try
            {
                DbCommand ins_Staff = db.GetStoredProcCommand("ins_StaffMember");

                // db.AddInParameter(dbCommand, "@parameterName", DbType.TypeName, variableName);

                db.AddInParameter(ins_Staff, "@staffTypeID", DbType.Int32, thisStaff.staffTypeID);
                db.AddInParameter(ins_Staff, "@addressesID", DbType.Int32, thisStaff.staffAddress.addressesID);
                db.AddInParameter(ins_Staff, "@additionalContactInfoID", DbType.Int32, thisStaff.staffContact.additionalContactInfoID);
                db.AddInParameter(ins_Staff, "@firstName", DbType.String, thisStaff.firstName);
                db.AddInParameter(ins_Staff, "@lastName", DbType.String, thisStaff.lastName);
                db.AddInParameter(ins_Staff, "@handicapped", DbType.Boolean, thisStaff.handicapped);
                db.AddInParameter(ins_Staff, "@staffAltID", DbType.String, thisStaff.staffAltID);
                db.AddInParameter(ins_Staff, "@deleted", DbType.Boolean, thisStaff.deleted);
                db.AddInParameter(ins_Staff, "@staffSSN", DbType.String, thisStaff.SSN);

                db.ExecuteNonQuery(ins_Staff);

                //insert Staff's Addresses
                DbCommand ins_Addresses = db.GetStoredProcCommand("ins_Addresses");

                db.AddInParameter(ins_Addresses, "@addressTypeID", DbType.Int32, thisStaff.staffAddress.addressTypeID);
                db.AddInParameter(ins_Addresses, "@address1", DbType.String, thisStaff.staffAddress.address1);
                db.AddInParameter(ins_Addresses, "@address2", DbType.String, thisStaff.staffAddress.address2);
                db.AddInParameter(ins_Addresses, "@city", DbType.String, thisStaff.staffAddress.city);
                db.AddInParameter(ins_Addresses, "@st", DbType.String, thisStaff.staffAddress.state);
                db.AddInParameter(ins_Addresses, "@zip", DbType.Int32, thisStaff.staffAddress.zip);
                db.AddInParameter(ins_Addresses, "@deleted", DbType.Boolean, thisStaff.staffAddress.deleted);

                db.ExecuteNonQuery(ins_Addresses);

                //insert Staff's Additional Contact Info
                DbCommand ins_AdditionalContactInfo = db.GetStoredProcCommand("ins_AdditionalContactInfo");

                db.AddInParameter(ins_AdditionalContactInfo, "@memberTypeID", DbType.Int32, thisStaff.staffContact.memberTypeID);
                db.AddInParameter(ins_AdditionalContactInfo, "@additionalContactInfo", DbType.String, thisStaff.staffContact.additionalContactInfo);
                db.AddInParameter(ins_AdditionalContactInfo, "@additionalContactInfoTypeID", DbType.Int32, thisStaff.staffContact.additionalContactInfoTypeID);
                db.AddInParameter(ins_AdditionalContactInfo, "@deleted", DbType.Boolean, thisStaff.staffContact.deleted);

                db.ExecuteNonQuery(ins_AdditionalContactInfo);

                return true;
            }
            catch
            {
                return false;
            }
        }
        
    }
}