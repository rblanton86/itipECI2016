using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Helpers;
using eciWEB2016.Models;
using eciWEB2016.Controllers.DataControllers;
using System.Data;
using System.Web.Script.Serialization;
using System.Web.Services;

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
            if (Session["client"] != null)
            {
                // If there is already a client in session, returns client to session.
                Client currentClient = (Client)Session["client"];
                ClientDataController dataController = new ClientDataController();
                currentClient = dataController.GetClient(currentClient.clientID);
                Session["client"] = currentClient;
            }
            else
            {
                // TODO: Replace the clientID int to something else to return a null client to the session, etc.
                Client currentClient = new Client();
                currentClient.clientID = 1;
                ClientDataController dataController = new ClientDataController();
                currentClient = dataController.GetClient(currentClient.clientID);
                Session["client"] = currentClient;
            }

            return View();
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="identifier"></param>
        /// <returns></returns>
        [HttpPost]
        [ActionName("GetAjaxClient")]
        [WebMethod(EnableSession = true)]
        public ActionResult GetClient(string identifier)
        {
            if (Session["client"] != null)
            {
                int clientID;
                int.TryParse(identifier, out clientID);

                Client currentClient = new Client();
                currentClient.clientID = clientID;
                ClientDataController dataController = new ClientDataController();
                currentClient = dataController.GetClient(currentClient.clientID);
                Session["client"] = currentClient;
            }
            return PartialView("Client_Partial");
        }

        // GET: Client/Details/5
        [HttpGet]
        [ActionName("GetAjaxClientList")]
        public JsonResult GetClientList()
        {
            List<Client> clientList = new List<Client>();
            ClientDataController dataController = new ClientDataController();
            clientList = dataController.GetListClients();

            // Takes select list of all clients, returns at Json object.
            return Json(clientList, JsonRequestBehavior.AllowGet);
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

        public void RemoveClient()
        {
            Session.Remove("client");
        }

        public void RemoveClientList()
        {
            Session.Remove("clientList");
        }
    }
}
