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


namespace eciWEB2016.Class
{
    public class AddContactInfo
    {

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
    }
}