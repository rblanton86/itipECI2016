using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.Mvc;
using eciWEB2016.Models;
using Microsoft.Practices.EnterpriseLibrary.Data.Sql;

namespace eciWEB2016.Controllers
{
    public class AddressesDataController
    {
        public static SqlDatabase db;

        /// <summary>
        /// Creates a database connection if one has not been initiated.
        /// </summary>
        public AddressesDataController()
        {
            if (db == null)
            {
                db = new SqlDatabase(WebConfigurationManager.ConnectionStrings["eciConnectionString"].ToString());
            }
        }

        /// <summary>
        /// Inserts new address object into the database.
        /// </summary>
        /// <param name="newAddress"></param>
        /// <param name="memberID"></param>
        /// <param name="memberTypeID"></param>
        /// <returns>Address object with addressID assigned.</returns>
        public Address InsertAddress(Address newAddress, int memberID, int memberTypeID)
        {
            DbCommand ins_Addresses = db.GetStoredProcCommand("ins_Addresses");
            db.AddInParameter(ins_Addresses, "@addressTypeID", DbType.Int32, newAddress.addressTypeID);
            db.AddInParameter(ins_Addresses, "@address1", DbType.String, newAddress.address1);
            db.AddInParameter(ins_Addresses, "@address2", DbType.String, newAddress.address2);
            db.AddInParameter(ins_Addresses, "@city", DbType.String, newAddress.city);
            db.AddInParameter(ins_Addresses, "@st", DbType.String, newAddress.state);
            db.AddInParameter(ins_Addresses, "@zip", DbType.Int32, newAddress.zip);
            db.AddInParameter(ins_Addresses, "@mapsco", DbType.String, newAddress.mapsco);
            db.AddInParameter(ins_Addresses, "@county", DbType.String, newAddress.county);
            db.AddInParameter(ins_Addresses, "@memberID", DbType.Int32, memberID);
            db.AddInParameter(ins_Addresses, "@memberTypeID", DbType.Int32, memberTypeID);
            db.AddInParameter(ins_Addresses, "@deleted", DbType.Boolean, false);
            db.AddOutParameter(ins_Addresses, "@addressID", DbType.Int32, sizeof(int));

            try
            {
                db.ExecuteNonQuery(ins_Addresses);

                newAddress.addressesID = Convert.ToInt32(db.GetParameterValue(ins_Addresses, "@addressID"));
            }
            catch (Exception e)
            {
                Debug.WriteLine("Unable to insert address, exception thrown: {0}", e);
            }

            return newAddress;
        }

        /// <summary>
        /// Updates new address object into the database.
        /// </summary>
        /// <param name="selectedAddress"></param>
        /// <param name="memberID"></param>
        /// <param name="memberTypeID"></param>
        /// <returns>Address object with.</returns>
        public Address UpdateAddress(Address selectedAddress, int memberID, int memberTypeID)
        {
            DbCommand upd_Addresses = db.GetStoredProcCommand("upd_Addresses");
            db.AddInParameter(upd_Addresses, "@addressesID", DbType.Int32, selectedAddress.addressesID);
            db.AddInParameter(upd_Addresses, "@memberID", DbType.Int32, memberID);
            db.AddInParameter(upd_Addresses, "@memberTypeID", DbType.Int32, memberTypeID);
            db.AddInParameter(upd_Addresses, "@addressTypeID", DbType.Int32, selectedAddress.addressTypeID);
            db.AddInParameter(upd_Addresses, "@address1", DbType.String, selectedAddress.address1);
            db.AddInParameter(upd_Addresses, "@address2", DbType.String, selectedAddress.address2);
            db.AddInParameter(upd_Addresses, "@city", DbType.String, selectedAddress.city);
            db.AddInParameter(upd_Addresses, "@st", DbType.String, selectedAddress.state);
            db.AddInParameter(upd_Addresses, "@zip", DbType.Int32, selectedAddress.zip);
            db.AddInParameter(upd_Addresses, "@mapsco", DbType.String, selectedAddress.mapsco);
            db.AddInParameter(upd_Addresses, "@county", DbType.String, selectedAddress.county);

            try
            {
                db.ExecuteNonQuery(upd_Addresses);
            }
            catch (Exception e)
            {
                Debug.WriteLine("Unable to insert address, exception thrown: {0}", e);
            }

            return selectedAddress;
        }

        /// <summary>
        /// Access the database and marks selected address as deleted.
        /// </summary>
        /// <param name="selectedAddress"></param>
        public bool DeleteAddress(Address selectedAddress)
        {
            bool success = false;

            DbCommand del_Addresses = db.GetStoredProcCommand("del_Addresses");
            db.AddInParameter(del_Addresses, "@addressesID", DbType.Int32, selectedAddress.addressesID);
            db.AddOutParameter(del_Addresses, "@success", DbType.Boolean, 1);

            try
            {
                db.ExecuteNonQuery(del_Addresses);

                success = Convert.ToBoolean(db.GetParameterValue(del_Addresses, "@success"));
            }
            catch (Exception e)
            {
                Debug.WriteLine("Unable to delete address, exception thrown: {0}", e);
            }

            return success;
        }
    }
}