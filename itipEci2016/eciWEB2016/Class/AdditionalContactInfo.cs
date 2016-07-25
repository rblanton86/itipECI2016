using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using eciWEB2016.Models;
using System.Data;
using System.Data.Common;
using eciWEB2016.Controllers.DataControllers;
using Microsoft.Practices.EnterpriseLibrary.Common.Configuration;
using Microsoft.Practices.EnterpriseLibrary.Data;
using Microsoft.Practices.EnterpriseLibrary.Data.Sql;
using System.Web.Configuration;
using System.Diagnostics;

namespace eciWEB2016.Class
{
    public class AdditionalContactInfo
    {

        public static SqlDatabase db;

        public AdditionalContactInfo()
        {
            if (db == null)
            {
                db = new SqlDatabase(WebConfigurationManager.ConnectionStrings["eciWeb2015"].ToString());
            }
        }

        //gets contact info by a dataset
        public AdditionalContactInfoModel GetAddContactInfoByDataSet(DataSet ds)
        {
            //datasets passed through only have one row so we access that row
            DataRow dr = ds.Tables[0].Rows[0];
            //then assign values from that row to a new Address model
            AdditionalContactInfoModel thisAddContactInfo = new AdditionalContactInfoModel()
            {
                additionalContactInfo = dr.Field<string>("additionalContactInfo")
            };

            return thisAddContactInfo;
        }

        //gets a list of contact info by dataset 
        public List<AdditionalContactInfoModel> GetAdditionalContactInfoByDataSet(DataSet ds)
        {

            // Stores a list of all addresses belonging to the family member.
            List<AdditionalContactInfoModel> AdditionalContactInfoModelList = (from drRow in ds.Tables[0].AsEnumerable()

                select new AdditionalContactInfoModel()
                {
                    additionalContactInfo = drRow.Field<string>("additionalContactInfo")

                }).ToList();

            return AdditionalContactInfoModelList;
        }

        public AdditionalContactInfoModel InsertAdditionalContactInformation(AdditionalContactInfoModel additionalContactInfo, int memberID, int memberTypeID)
        {
            DbCommand ins_AdditionalContactInformation = db.GetStoredProcCommand("ins_AdditionalContactInformation");
            db.AddInParameter(ins_AdditionalContactInformation, "@memberID", DbType.Int32, memberID);
            db.AddInParameter(ins_AdditionalContactInformation, "@memberTypeID", DbType.Int32, memberTypeID);
            db.AddInParameter(ins_AdditionalContactInformation, "@additionalContactInfoTypeID", DbType.Int32, additionalContactInfo.additionalContactInfoTypeID);
            db.AddInParameter(ins_AdditionalContactInformation, "@additionalContactInfo", DbType.String, additionalContactInfo.additionalContactInfo);

            db.AddOutParameter(ins_AdditionalContactInformation, "@additionalContactInfoID", DbType.Int32, sizeof(int));

            try
            {
                db.ExecuteNonQuery(ins_AdditionalContactInformation);

                additionalContactInfo.additionalContactInfoID = Convert.ToInt32(db.GetParameterValue(ins_AdditionalContactInformation, "@additionalContactInfoID"));
            }
            catch (Exception e)
            {
                Debug.WriteLine("InsertContactInformation failed, exception: {0}", e);
            }

            return additionalContactInfo;
        }

        public AdditionalContactInfoModel UpdateAdditionalContactInformation(AdditionalContactInfoModel additionalContactInfo, int memberID, int memberTypeID)
        {
            DbCommand upd_AdditionalContactInfo = db.GetStoredProcCommand("upd_AdditionalContactInformation");
            db.AddInParameter(upd_AdditionalContactInfo, "@additionalContactInfoID", DbType.Int32, additionalContactInfo.additionalContactInfoID);
            db.AddInParameter(upd_AdditionalContactInfo, "@additionalContactInfo", DbType.String, additionalContactInfo.additionalContactInfo);

            db.AddOutParameter(upd_AdditionalContactInfo, "@success", DbType.Boolean, 1);

            try
            {
                db.ExecuteNonQuery(upd_AdditionalContactInfo);
            }
            catch (Exception e)
            {
                Debug.WriteLine("UpdateAdditionalContactInfo failed, exception: {0}", e);
            }

            return additionalContactInfo;
        }

        public bool DeleteAdditionalContactInformation(AdditionalContactInfoModel additionalContactInfo)
        {
            DbCommand del_AdditionalContactInfo = db.GetStoredProcCommand("del_AdditionalContactInformation");
            db.AddInParameter(del_AdditionalContactInfo, "@additionalContactInfoID", DbType.Int32, additionalContactInfo.additionalContactInfoID);
            db.AddOutParameter(del_AdditionalContactInfo, "@success", DbType.Boolean, 1);

            bool success;
            try
            {
                db.ExecuteNonQuery(del_AdditionalContactInfo);
                success = Convert.ToBoolean(db.GetParameterValue(del_AdditionalContactInfo, "@success"));
            }
            catch (Exception e)
            {
                Debug.WriteLine("DeleteAdditionalContactInfo failed, exception: {0}", e);
                success = false;
            }

            return success;
        }
    }
}