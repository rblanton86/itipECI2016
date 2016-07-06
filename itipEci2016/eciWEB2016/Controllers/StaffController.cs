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
using eciWEB2016.Models;
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

        
        public ActionResult Staff_Time_Headers(string staffID)
        {
            try
            {
                List<Staff> staffList;
                StaffDataController dataController = new StaffDataController();

                staffList = dataController.GetAllStaff();

                return PartialView("TimeSheet_Grid_Partial", staffList);

            }
            catch (Exception ex)
            {
                return Json(new { ok = false, message = ex.Message });
            }

        }
        public ActionResult TimeSheet_Grid_Partial(string staffID)
        {
            try
            {
                List<TimeHeaderModel> headerList;
                TimeSheetDataController dataController = new TimeSheetDataController();

                headerList = dataController.GetTimeHeaders();

                return PartialView("TimeSheet_Grid_Partial", headerList);

            }
            catch (Exception ex)
            {
                return Json(new { ok = false, message = ex.Message });
            }

        }

        public ActionResult Time_Headers()
        {
            Staff staff = new Staff();
            ViewBag.staffList = staff.GetStaffList();
         
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
