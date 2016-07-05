﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using eciWEB2016.Models;
using eciWEB2016.Controllers.DataControllers;
using System.Data;

namespace eciWEB2016.Controllers
{
    public class ClientController : Controller
    {
        // GET: Client
        /// <summary>
        /// 
        /// </summary>
        /// <returns></returns>
        public ActionResult Client_Update()
        {
            List<Client> list = new List<Client>();
            ClientDataController dataController = new ClientDataController();

            var clientList = new List<SelectListItem>();

            list = dataController.GetAllClients();

            for (int i = 0; i < list.Count; i++)
            {
                clientList.Add(new SelectListItem
                {
                    Text = list[i].altID + " " + list[i].firstName + " " + list[i].lastName,
                    Value = list[i].clientID.ToString()
                });
            }

            return View(clientList);
        }

        // GET: Client/Details/5
        public ActionResult GetClients()
        {
            List<Client> clients = new List<Client>();
            ClientDataController dataController = new ClientDataController();

            clients = dataController.GetAllClients();

            return Json(new { clients }, JsonRequestBehavior.AllowGet);
        }

        // GET: Client/Create
        public ActionResult Create()
        {

            return View();
        }

        // POST: Client/Create
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

        // GET: Client/Edit/5
        public ActionResult Edit(int id)
        {
            return View();
        }

        // POST: Client/Edit/5
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

        // GET: Client/Delete/5
        public ActionResult Delete(int id)
        {
            return View();
        }

        // POST: Client/Delete/5
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
