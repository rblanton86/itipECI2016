using eciWEB2016.Controllers.DataControllers;
using eciWEB2016.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace eciWEB2016.Controllers
{
    public class ReferralController : Controller
    {
        // GET: Referral
        public ActionResult Referral()
        {
            return View();
        }

        // GET: Referral/Details/5
        public ActionResult ReferralSourceDetails(int id)
        {
            ReferralSource thisReferralSource = new ReferralSource()
            {
                referralSourceID = id
            };

            ReferralDataController dataController = new ReferralDataController();

            thisReferralSource = dataController.GetReferralSourceDetails(thisReferralSource);

            return Json(thisReferralSource, JsonRequestBehavior.AllowGet);
        }

        public List<ReferralSource> GetAllReferralSources()
        {
            List<ReferralSource> listReferralSources = new List<ReferralSource>();

            return listReferralSources;
        }

        // GET: Referral/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: Referral/Create
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

        // GET: Referral/Edit/5
        public ActionResult Edit(int id)
        {
            return View();
        }

        // POST: Referral/Edit/5
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

        // GET: Referral/Delete/5
        public ActionResult Delete(int id)
        {
            return View();
        }

        // POST: Referral/Delete/5
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
