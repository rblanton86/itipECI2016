/***********************************************************************************************************
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
        public ActionResult Staff_Update()
        {
            Staff staff = new Staff();
            ViewBag.staffList = GetStaffList();

            return View();
        }

        public ActionResult Add_Staff()
        {
            return View();
        }

        // GET: Staff/TimeSheets
        public ActionResult Time_Sheets()
        {
            return View();
        }
        public ActionResult Time_Sheet_Service_Code()
        {
            return View();
        }
        
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
                             staffID = drRow.Field<int>("staffID").ToString()
                         }).ToList();
            //stores the list in the session
                System.Web.HttpContext.Current.Session["staffList"] = staff;
            

             return staff;
        }

        [System.Web.Services.WebMethod]
        public JsonResult GetStaffMember(int staffID)
        {

            Staff staffMember = new Staff();
            List<Staff> staffList = new List<Staff>();

            if (Session["staffList"] != null)
            {

                //pulls the staffList session and stores it in a new staffList List
                staffList = (List<Staff>)System.Web.HttpContext.Current.Session["staffList"];
                //selects from staffList the first list item with matching parameter staffID
                staffMember = staffList.FirstOrDefault(p => p.staffID == staffID.ToString());
                //stores the selected staffMember into the session
                System.Web.HttpContext.Current.Session["staffMember"] = staffMember;
                //creates json string with defined Property names and dynamic property values    
                //return Json(new { id = staffMember.staffID, firstName = staffMember.firstName, lastName = staffMember.lastName });
                return Json(staffMember, JsonRequestBehavior.AllowGet);
            }
            else
            {
                //if staffList is null, fills staffList then fills staffMember both to session
                StaffList();
                staffList = (List<Staff>)System.Web.HttpContext.Current.Session["staffList"];
                staffMember = staffList.FirstOrDefault(p => Convert.ToInt32(p.staffID) == staffID);
                System.Web.HttpContext.Current.Session["staffMember"] = staffMember;
                // return Json(new { id = staffMember.staffID, firstName = staffMember.firstName, lastName = staffMember.lastName });
                return Json(staffMember, JsonRequestBehavior.AllowGet);
            }
        }

        public ActionResult Staff_Time_Headers(string staffID)
        {
            try
            {
                List<Staff> staffList;
                StaffDataController dataController = new StaffDataController();

                staffList = StaffList();

                return PartialView("TimeSheet_Grid_Partial", staffList);

            }
            catch (Exception ex)
            {
                return Json(new { ok = false, message = ex.Message });
            }

        }

        public SelectList GetStaffList()
        {
            SelectList staffList;
            StaffDataController dataController = new StaffDataController();

            staffList = dataController.GetStaffDropDown();

            return new SelectList(staffList, "Value", "Text", new Staff().staffID);
        }

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

        // GET: Staff/Details/5
        public ActionResult Details(int id)
        {
            return View();
        }

        // GET: Staff/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: Staff/Create
        [HttpPost]
        public ActionResult Create(FormCollection collection)
        {
            try
            {
                // TODO: Add insert logic here
                


                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        // GET: Staff/Edit/5
        public ActionResult Edit(int id)
        {
            return View();
        }

        // POST: Staff/Edit/5
        [HttpPost]
        public ActionResult Edit(int id, FormCollection collection)
        {
            try
            {
                // TODO: Add update logic here

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        // GET: Staff/Delete/5
        public ActionResult Delete(int id)
        {
            return View();
        }

        // POST: Staff/Delete/5
        [HttpPost]
        public ActionResult Delete(int id, FormCollection collection)
        {
            try
            {
                // TODO: Add delete logic here

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }
    }
}
