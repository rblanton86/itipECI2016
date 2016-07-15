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
              firstName = dr.Field<string>("firstName"),
              lastName = dr.Field<string>("lastName"),
              fullName = dr.Field<string>("firstName") + " " + dr.Field<string>("lastName"),
              SSN = dr.Field<int>("ssn"),
              DOB = dr.IsNull("dob") ? new DateTime(1900,1,1) : dr.Field<DateTime>("dob")

            };

            Addresses addr = new Addresses();

            currentStaff.staffAddress = addr.GetAddressByDataSet(ds);

            return currentStaff;
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

            //update Staff Member

        public bool staffUpdate(Staff thisStaff)
        {
            try
            {

                //Update Staff
                DbCommand upd_Staff = db.GetStoredProcCommand("upd_Staff");

                // db.AddInParameter(dbCommand, "@parameterName", DbType.TypeName, variableName);

                db.AddInParameter(upd_Staff, "@staffID", DbType.String, thisStaff.staffID);
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
                db.AddInParameter(upd_Addresses, "@addressTypeID", DbType.Int32, thisStaff.staffAddress.addressType);
                db.AddInParameter(upd_Addresses, "@address1", DbType.String, thisStaff.staffAddress.address1);
                db.AddInParameter(upd_Addresses, "@address2", DbType.String, thisStaff.staffAddress.address2);
                db.AddInParameter(upd_Addresses, "@city", DbType.String, thisStaff.staffAddress.city);
                db.AddInParameter(upd_Addresses, "@st", DbType.String, thisStaff.staffAddress.state);
                db.AddInParameter(upd_Addresses, "@zip", DbType.Int32, thisStaff.staffAddress.zip);
                db.AddInParameter(upd_Addresses, "@deleted", DbType.Boolean, thisStaff.staffAddress.deleted);

                db.ExecuteNonQuery(upd_Addresses);

                //update Staff's Additional Contact Info
                //DbCommand upd_AdditionalContactInfo = db.GetStoredProcCommand("upd_AdditionalContactInfo");

                //db.AddInParameter(upd_AdditionalContactInfo, "@additionalContactInfo", DbType.String, thisStaff.staffContact);
                //db.AddInParameter(upd_AdditionalContactInfo, "@additionalContactInfoTypeID", DbType.Int32, 1);
                //db.AddInParameter(upd_AdditionalContactInfo, "@deleted", DbType.Boolean, thisStaff.staffContact);

                //db.ExecuteNonQuery(upd_AdditionalContactInfo);

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

                string addressID;
                int aciID;
                string succesful;

                //insert Staff's Addresses
                DbCommand ins_Addresses = db.GetStoredProcCommand("ins_Addresses");

                db.AddInParameter(ins_Addresses, "@addressTypeID", DbType.Int32, thisStaff.addressesID);
                db.AddInParameter(ins_Addresses, "@address1", DbType.String, thisStaff.address1);
                db.AddInParameter(ins_Addresses, "@address2", DbType.String, thisStaff.address2);
                db.AddInParameter(ins_Addresses, "@city", DbType.String, thisStaff.city);
                db.AddInParameter(ins_Addresses, "@st", DbType.String, thisStaff.state);
                db.AddInParameter(ins_Addresses, "@zip", DbType.Int32, thisStaff.zip);
                db.AddInParameter(ins_Addresses, "@deleted", DbType.Boolean, false);
                db.AddOutParameter(ins_Addresses, "@addressID", DbType.Int32, sizeof(Int32));

                addressID = (string)(db.ExecuteScalar(ins_Addresses));




                //insert Staff's Additional Contact Info
                DbCommand ins_AdditionalContactInfo = db.GetStoredProcCommand("ins_AdditionalContactInfo");

                AdditionalContactInfoModel staffContact = new AdditionalContactInfoModel();

                staffContact = thisStaff.staffContact;

                db.AddInParameter(ins_AdditionalContactInfo, "@memberTypeID", DbType.Int32, 1);
                db.AddInParameter(ins_AdditionalContactInfo, "@additionalContactInfo", DbType.String, staffContact.additionalContactInfo);
                db.AddInParameter(ins_AdditionalContactInfo, "@additionalContactInfoTypeID", DbType.Int32, 1);
                db.AddInParameter(ins_AdditionalContactInfo, "@deleted", DbType.Boolean, false);

                aciID = Convert.ToInt32(db.ExecuteScalar(ins_AdditionalContactInfo).ToString());


                //Inserts staff
                DbCommand ins_Staff = db.GetStoredProcCommand("ins_StaffMember");

                db.AddInParameter(ins_Staff, "@addressesID", DbType.Int32, Convert.ToInt32(addressID));
                db.AddInParameter(ins_Staff, "@additionalContactInfoID", DbType.Int32, Convert.ToInt32(aciID));
                db.AddInParameter(ins_Staff, "@staffTypeID", DbType.Int32, thisStaff.staffTypeID);
                db.AddInParameter(ins_Staff, "@firstName", DbType.String, thisStaff.firstName);
                db.AddInParameter(ins_Staff, "@lastName", DbType.String, thisStaff.lastName);
                db.AddInParameter(ins_Staff, "@handicapped", DbType.Boolean, thisStaff.handicapped);
                db.AddInParameter(ins_Staff, "@staffAltID", DbType.String, thisStaff.staffAltID);
                db.AddInParameter(ins_Staff, "@deleted", DbType.Boolean, thisStaff.deleted);
                db.AddInParameter(ins_Staff, "@ssn", DbType.String, thisStaff.SSN);
                db.AddInParameter(ins_Staff, "@dob", DbType.String, thisStaff.DOB);
                db.AddOutParameter(ins_Staff, "@success", DbType.Int32, sizeof(Int32));

                succesful = (string)db.ExecuteScalar(ins_Staff);


                return true;
            }
            catch
            {
                return false;
            }
        }
        
    }
}