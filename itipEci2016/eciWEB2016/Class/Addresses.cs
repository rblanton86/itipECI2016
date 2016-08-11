/***********************************************************************************************************
Description: Data Controller for Staff Controller
	 
Author: 
	Tyrell Powers-Crane 
Date: 
	7.13.2016
Change History:
	
************************************************************************************************************/
using System.Collections.Generic;
using System.Linq;
using eciWEB2016.Models;
using System.Data;

namespace eciWEB2016.Class
{
    public class Addresses
    {
        /// <summary>
        /// Takes a dataset as input and returns address as object.
        /// </summary>
        /// <param name="ds"></param>
        /// <returns>Address object with all parameters.</returns>
        public Address GetAddressByDataSet(DataSet ds)
        {
            //datasets passed through only have one row so we access that row
            DataRow dr = ds.Tables[0].Rows[0];
            //then assign values from that row to a new Address model
            Address thisAddress = new Address()
            {
                addressesID = dr.Field<int>("addressesID"),
                address1 = dr.Field<string>("address1"),
                address2 = dr.Field<string>("address2"),
                city = dr.Field<string>("city"),
                state = dr.Field<string>("st"),
                zip = dr.Field<int>("zip"),
                county = dr.Field<string>("county"),
                mapsco = dr.Field<string>("mapsco"),

            };

            return thisAddress;
        }

        /// <summary>
        /// Takes a dataset as input and returns a list of addresses as an object.
        /// </summary>
        /// <param name="ds"></param>
        /// <returns>List of Address object.</returns>
        public List<Address> GetAddressesByDataSet(DataSet ds)
        {

            // Stores a list of all addresses belonging to the family member.
            List<Address> AddressList = (from drRow in ds.Tables[0].AsEnumerable()
                                         select new Address()
                                         {
                                             addressTypeID = drRow.Field<int>("addressesTypeID"),
                                             addressesType = drRow.Field<string>("addressesType"),
                                             addressesID = drRow.Field<int>("addressessID"),
                                             address1 = drRow.Field<string>("address1"),
                                             address2 = drRow.Field<string>("address2"),
                                             city = drRow.Field<string>("city"),
                                             state = drRow.Field<string>("st"),
                                             zip = drRow.Field<int>("zip"),
                                             county = drRow.Field<string>("county"),
                                             mapsco = drRow.Field<string>("mapsco")

                                         }).ToList();
            return AddressList;
        }
    }
}