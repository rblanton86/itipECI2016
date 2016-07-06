using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using eciWEB2016.Models;
using eciWEB2016.Controllers.DataControllers;
using System.Data;

namespace eciWEB2016.Controllers
{
    public class TimeSheetController : Controller
    {
        // GET: TimeSheet
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult TimeSheet_Grid_Partial(int staffID)
        {
            try
            {
                List<TimeHeaderModel> headerList;
                TimeSheetDataController dataController = new TimeSheetDataController();

                headerList = dataController.GetTimeHeaders(staffID);

                return PartialView("TimeSheet_Grid_Partial", headerList);

            }
            catch (Exception ex)
            {
                return Json(new { ok = false, message = ex.Message });
            }

        }

        // GET: TimeSheet/Details/5
        public ActionResult Details(int id)
        {
            return View();
        }

        // GET: TimeSheet/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: TimeSheet/Create
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

        // GET: TimeSheet/Edit/5
        public ActionResult Edit(int id)
        {
            return View();
        }

        // POST: TimeSheet/Edit/5
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

        // GET: TimeSheet/Delete/5
        public ActionResult Delete(int id)
        {
            return View();
        }

        // POST: TimeSheet/Delete/5
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
