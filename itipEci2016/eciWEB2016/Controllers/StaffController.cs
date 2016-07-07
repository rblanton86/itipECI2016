/***********************************************************************************************************
Description: Staff Controller for all responses involving staff pages
	 
Author: 
	Tyrell Powers-Crane 
Date: 
	6.29.2016
Change History:
	
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

            dsStaff = dataController.GetAllStaff();

            var staff = (from drRow in dsStaff.Tables[0].AsEnumerable()
                         select new Staff()
                         {
                             firstName = drRow.Field<string>("firstName"),
                             lastName = drRow.Field<string>("lastName"),
                             fullName = drRow.Field<string>("firstName") + " " + drRow.Field<string>("lastName"),
                             staffID = drRow.Field<int>("staffID").ToString()
                         }).ToList();

            System.Web.HttpContext.Current.Session["staffList"] = staff;


             return staff;
        }

        [System.Web.Services.WebMethod]
        public string getStaffMember(string staffID)
        {
            Staff staffMember = new Staff();
            List<Staff> staffList = new List<Staff>();

            staffList = (List<Staff>)System.Web.HttpContext.Current.Session["staffList"];

            staffMember = staffList.FirstOrDefault(p => p.staffID == staffID);
            
            System.Web.HttpContext.Current.Session["staffMember"] = staffMember;

            string JsonStaff = JsonConvert.SerializeObject(staffMember);

            return JsonStaff;
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
