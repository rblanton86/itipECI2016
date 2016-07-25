﻿/***********************************************************************************************************
Description: Staff Controller for all responses involving staff pages
	 
Author: 
	Tyrell Powers-Crane 
Date: 
	6.29.2016
Change History:
	7.11.2016 -tpc- Added route for AddStaff View
************************************************************************************************************/
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Data;
using System.Web.Services;
using System.Data.Common;
using System.Reflection;
using Newtonsoft.Json;
using eciWEB2016.Models;
using eciWEB2016.Class;
using eciWEB2016.Controllers.DataControllers;


namespace eciWEB2016.Controllers
{
    public class StaffController : Controller
    {
        // GET: Staff

        public ActionResult Time_Sheets()
        {
            return View();
        }

        public ActionResult Time_Sheet_Service_Code()
        {
            return View();
        }

        //creates a list of staffmembers and stores in the session
        public List<Staff> StaffList()
        {
            DataSet dsStaff;
            StaffDataController dataController = new StaffDataController();
            //retrieves staff data and stores it in a dataset
            dsStaff = dataController.GetAllStaff();
            //stores each staff member and their properties to a list of Staff objects
            var staff = (from drRow in dsStaff.Tables[0].AsEnumerable()
                         select new Staff()
                         {
                             firstName = drRow.Field<string>("firstName"),
                             lastName = drRow.Field<string>("lastName"),
                             fullName = drRow.Field<string>("firstName") + " " + drRow.Field<string>("lastName"),
                             staffID = drRow.Field<int>("staffID"),
                             status = drRow.Field<int>("staffStatus"),
                             staffAltID = drRow.Field<string>("staffAltID")
                             
                         }).ToList();
            //stores the list in the session
                System.Web.HttpContext.Current.Session["staffList"] = staff;
            

             return staff;
        }

        //used to get staff member from session. Used in webgrid partial
        [System.Web.Services.WebMethod]
        public JsonResult GetStaffMemberFromSession(int staffID)
        {

            Staff staffMember = new Staff();
            List<Staff> staffList = new List<Staff>();

            if (Session["staffList"] != null)
            {

                //pulls the staffList session and stores it in a new staffList List
                staffList = (List<Staff>)System.Web.HttpContext.Current.Session["staffList"];
                //selects from staffList the first list item with matching parameter staffID
                staffMember = staffList.FirstOrDefault(p => p.staffID == staffID);
                //stores the selected staffMember into the session
                System.Web.HttpContext.Current.Session["staffMember"] = staffMember;
                //creates json string with defined Property names and dynamic property values    
                //return Json(new { id = staffMember.staffID, firstName = staffMember.firstName, lastName = staffMember.lastName });
                return Json(staffMember, JsonRequestBehavior.AllowGet);
            }
            else
            {
                StaffList();
                staffList = (List<Staff>)System.Web.HttpContext.Current.Session["staffList"];
                staffMember = staffList.FirstOrDefault(p => Convert.ToInt32(p.staffID) == staffID);
                System.Web.HttpContext.Current.Session["staffMember"] = staffMember;
                // return Json(new { id = staffMember.staffID, firstName = staffMember.firstName, lastName = staffMember.lastName });
                return Json(staffMember, JsonRequestBehavior.AllowGet);
            }
        }

        //used to get staff member, put in db, then display staff info on partial page
        [HttpPost]
        [ActionName("GetAjaxStaff")]
        [WebMethod(EnableSession = true)]
        public ActionResult GetStaffMember(int staffID)
        {
            Staff staffMember = new Staff();

            StaffDataController dataController = new StaffDataController();
            staffMember = dataController.GetStaffMember(staffID);
            // staffMember = dataController.getStaffMember(Convert.ToInt32(staffMember.staffID));
            System.Web.HttpContext.Current.Session["staffMember"] = staffMember;

            ViewBag.statusList = GetStatusList();

            return PartialView("Staff_Partial");
        }



        //used to fill webgrid with staff details
        public ActionResult Staff_Time_Headers(string staffID)
        {
            try
            {
                List<Staff> staffList;
                StaffDataController dataController = new StaffDataController();
                //staffList() creates a list of all staff members and stores it to the session
                staffList = StaffList();
                
                return PartialView("TimeSheet_Grid_Partial", staffList);

            }
            catch (Exception ex)
            {
                return Json(new { ok = false, message = ex.Message });
            }

        }

        //creates a list of staff members as a selectlist. Used for dropdown boxes
        public SelectList GetStaffList()
        {
            SelectList staffList;
            StaffDataController dataController = new StaffDataController();

            staffList = dataController.GetStaffDropDown();

            return new SelectList(staffList, "Value", "Text", new Staff().staffID);
        }

        //returns time headers view and populates dropdown box
        public ActionResult Time_Headers()
        {
            Staff staff = new Staff();
            ViewBag.staffList = GetStaffList();
         
            return View();
        }

        public ActionResult Time_Sheet_Input()
        {
            return View();
        }

        // GET: Staff/Create
        //returns Add_Staff View
        public ActionResult Add_Staff()
        {
            Staff blankStaff = new Staff();
            ViewBag.statusList = GetStatusList();
            ViewBag.staffTypeList = GetStaffTypeList();
            return View(blankStaff);
        }

        //populates a staff type dropdown
        public SelectList GetStaffTypeList()
        {
            SelectList staffTypeList;
            StaffDataController dataController = new StaffDataController();

            staffTypeList = dataController.GetStaffTypeList();

            return new SelectList(staffTypeList, "Value", "Text", new Staff().staffTypeID);
        }

        //populates a status dropdown
        public SelectList GetStatusList()
        {
            SelectList statusList;
            StaffDataController dataController = new StaffDataController();

            statusList = dataController.GetStatusList();

            return new SelectList(statusList, "Value", "Text", new Staff().status);
        }

        public ActionResult StaffAdditionalContactInfoPartial()
        {
            ViewBag.contactTypeList = GetContactTypeList();
            ViewBag.memberTypeList = GetMemberTypeList();

            return PartialView();
        }

        //populates drop down for member type
        public SelectList GetMemberTypeList()
        {

            SelectList memberList;
            StaffDataController dataController = new StaffDataController();

            memberList = dataController.GetMemberTypeList();

            return new SelectList(memberList, "Value", "Text", new AdditionalContactInfoModel().memberTypeID);
        }

        //populates drop down list for contact info type
        public SelectList GetContactTypeList()
        {
            SelectList contactList;
            StaffDataController dataController = new StaffDataController();

            contactList = dataController.GetContactTypeList();

            return new SelectList(contactList, "Value", "Text", new AdditionalContactInfoModel().additionalContactInfoTypeID);
        }
        //returns partial view for inserting addresses
        public ActionResult StaffAddressPartial()
        {
            Address thisAddress = new Address();

            ViewBag.addressTypeList = GetAddressTypeList();

            return PartialView(thisAddress);
        }

        //Populates a dropdown for address types
        public SelectList GetAddressTypeList()
        {
            SelectList addressList;
            StaffDataController dataController = new StaffDataController();

            addressList = dataController.GetAddressTypeList();

            return new SelectList(addressList, "Value", "Text", new Address().addressTypeID);
        }
        //populates address type list

        // POST: Staff/Create
        [HttpPost]
        public ActionResult CreateStaffMember(Staff staff, Address address, AdditionalContactInfoModel aci)
        {
               
                bool success;

                StaffDataController dataController = new StaffDataController();

                success = dataController.InsertStaff(staff, address, aci);
                
                

                return Content(success.ToString());           

        }

        // GET: Staff/Edit/5

        //returns staffUpdate page and populates dropdown 
        public ActionResult Staff_Update()
        {
            Staff blankStaff = new Staff();
            Address blankAddress = new Address();

            if (Session["staffMember"] == null)
            {               
                blankStaff.staffAddress = blankAddress;
                Session["staffMember"] = blankStaff;
            }
            else
            {
             
                blankStaff = (Staff)Session["staffMember"];
            }
            ViewBag.staffList = GetStaffList();
            ViewBag.statusList = GetStatusList();

            return View();
        }

        [HttpPost]
        public ActionResult staffUpdate(Staff staff, Address address, AdditionalContactInfoModel aci)
        {

            bool success;

            StaffDataController dataController = new StaffDataController();

            staff.deleted = true;

            success = dataController.InsertStaff(staff, address, aci);

            return Content(success.ToString());

        }
        
    }
}
