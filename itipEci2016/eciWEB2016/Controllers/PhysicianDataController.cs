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
    public class PhysicianDataController
    {
        public static SqlDatabase db;

        public PhysicianDataController()
        {
            if (db == null)
            {
                db = new SqlDatabase(WebConfigurationManager.ConnectionStrings["eciConnectionString"].ToString());
            }
        }

        //get all physicians and return as a dataset
        public DataSet GetAllPhysicians()
        {
            DbCommand dbCommand = db.GetStoredProcCommand("get_AllPhysicians");

            // db.AddInParameter(dbCommand, "@parameterName", DbType.TypeName, variableName);

            DataSet ds = db.ExecuteDataSet(dbCommand);
            return ds;
        }

        //get a single physician by first and last name
        public Physician GetPhysician(string firstName, string lastName)
        {
            DbCommand dbCommand = db.GetStoredProcCommand("get_Physician");
            db.AddInParameter(dbCommand, "firsName", DbType.String, firstName);
            db.AddInParameter(dbCommand, "lastName", DbType.String, lastName);

            DataSet ds = db.ExecuteDataSet(dbCommand);

            DataRow dr = ds.Tables[0].Rows[0];

            Physician currentPhysician = new Physician()
            {
                physicianID = dr.Field<int>("physicianID"),
                firstName = dr.Field<string>("firstName"),
                lastName = dr.Field<string>("lastName"),
                fullName = dr.Field<string>("firstName") + " " + dr.Field<string>("lastName"),
            };

            Addresses addr = new Addresses();

            currentPhysician.physicianAddrs = addr.GetAddressByDataSet(ds);

            return currentPhysician;
        }

        //update Staff Member

        public bool PhysicianUpdate(Physician thisPhysician)
        {
            try
            {

                //Update Physician
                DbCommand upd_Physician = db.GetStoredProcCommand("upd_Physician");

                // db.AddInParameter(dbCommand, "@parameterName", DbType.TypeName, variableName);

                db.AddInParameter(upd_Physician, "@physicianID", DbType.String, thisPhysician.physicianID);
                db.AddInParameter(upd_Physician, "@firstName", DbType.String, thisPhysician.firstName);
                db.AddInParameter(upd_Physician, "@lastName", DbType.String, thisPhysician.lastName);
                db.AddInParameter(upd_Physician, "@deleted", DbType.Boolean, thisPhysician.deleted);

                db.ExecuteNonQuery(upd_Physician);

                //update Physician's Addresses
                DbCommand upd_Addresses = db.GetStoredProcCommand("upd_Addresses");

                db.AddInParameter(upd_Addresses, "@addressesID", DbType.Int32, thisPhysician.physicianAddrs.addressesID);
                db.AddInParameter(upd_Addresses, "@addressTypeID", DbType.Int32, thisPhysician.physicianAddrs.addressType);
                db.AddInParameter(upd_Addresses, "@address1", DbType.String, thisPhysician.physicianAddrs.address1);
                db.AddInParameter(upd_Addresses, "@address2", DbType.String, thisPhysician.physicianAddrs.address2);
                db.AddInParameter(upd_Addresses, "@city", DbType.String, thisPhysician.physicianAddrs.city);
                db.AddInParameter(upd_Addresses, "@st", DbType.String, thisPhysician.physicianAddrs.state);
                db.AddInParameter(upd_Addresses, "@zip", DbType.Int32, thisPhysician.physicianAddrs.zip);
                db.AddInParameter(upd_Addresses, "@deleted", DbType.Boolean, thisPhysician.physicianAddrs.deleted);

                db.ExecuteNonQuery(upd_Addresses);

                return true;
            }
            catch
            {
                return false;
            }
        }

        public bool InsertStaff(Physician thisPhysician)
        {
            try
            {

                string addressID;
                int aciID;
                string succesful;

                //insert Staff's Addresses
                DbCommand ins_Addresses = db.GetStoredProcCommand("ins_Addresses");

                db.AddInParameter(ins_Addresses, "@addressTypeID", DbType.Int32, thisPhysician.addressesID);
                db.AddInParameter(ins_Addresses, "@address1", DbType.String, thisPhysician.address1);
                db.AddInParameter(ins_Addresses, "@address2", DbType.String, thisPhysician.address2);
                db.AddInParameter(ins_Addresses, "@city", DbType.String, thisPhysician.city);
                db.AddInParameter(ins_Addresses, "@st", DbType.String, thisPhysician.state);
                db.AddInParameter(ins_Addresses, "@zip", DbType.Int32, thisPhysician.zip);
                db.AddInParameter(ins_Addresses, "@deleted", DbType.Boolean, false);
                db.AddOutParameter(ins_Addresses, "@addressID", DbType.Int32, sizeof(Int32));

                addressID = (string)(db.ExecuteScalar(ins_Addresses));


                //Inserts physician
                DbCommand ins_Physician = db.GetStoredProcCommand("ins_Physician");

                db.AddInParameter(ins_Physician, "@addressesID", DbType.Int32, Convert.ToInt32(addressID));
                db.AddInParameter(ins_Physician, "@additionalContactInfoID", DbType.Int32, 1);
                db.AddInParameter(ins_Physician, "@firstName", DbType.String, thisPhysician.firstName);
                db.AddInParameter(ins_Physician, "@lastName", DbType.String, thisPhysician.lastName);
                db.AddInParameter(ins_Physician, "@title", DbType.String, thisPhysician.title);

                db.ExecuteNonQuery(ins_Physician);

                return true;
            }
            catch
            {
                return false;
            }
        }

    }
}