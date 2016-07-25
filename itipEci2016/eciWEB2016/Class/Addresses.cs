/***********************************************************************************************************
Description: Data Controller for Staff Controller
	 
Author: 
	Tyrell Powers-Crane 
Date: 
	7.13.2016
Change History:
	
************************************************************************************************************/
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
    public class Addresses
    {

        //gets addresses for any dataset sent through and returns as a address model
        public Address GetAddressByDataSet(DataSet ds)
        {
            //datasets passed through only have one row so we access that row
            DataRow dr = ds.Tables[0].Rows[0];
            //then assign values from that row to a new Address model
            Address thisAddress = new Address()
            {
                address1 = dr.Field<string>("address1"),
                address2 = dr.Field<string>("address2"),
                city = dr.Field<string>("city"),
                state = dr.Field<string>("st"),
                zip = dr.Field<int>("zip"),
                mapsco = dr.Field<string>("mapsco"),

            };

            return thisAddress;
        }

        //gets All addresses associated with a client by familyID and returns as a list
        public List<Address> GetAddressesByDataSet(DataSet ds)
        {

            // Stores a list of all addresses belonging to the family member.
            List<Address> AddressList = (from drRow in ds.Tables[0].AsEnumerable()
                                         select new Address()
                                         {
                                             addressesType = drRow.Field<string>(""),
                                             address1 = drRow.Field<string>(""),
                                             address2 = drRow.Field<string>(""),
                                             city = drRow.Field<string>(""),
                                             state = drRow.Field<string>(""),
                                             zip = drRow.Field<int>(""),
                                             county = drRow.Field<string>(""),
                                             mapsco = drRow.Field<string>("")

                                         }).ToList();
            return AddressList;
        }

    }
}