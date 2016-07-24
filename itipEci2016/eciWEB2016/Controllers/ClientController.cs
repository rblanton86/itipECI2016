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
        public ActionResult Client_Update()
        {
            if (Session["client"] == null)
            {
                // Creates a blank client for the inital view.
                Client newClient = new Client();

                Session["client"] = newClient;
                return View(newClient);
            }

            Client currentClient = new Client();
            currentClient = (Client)Session["client"];

            return View(currentClient);
        }

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


        /************************************************************************** CREATE *******************************************************/

        public ActionResult InsertClient(Client newClient)
        {
            ClientDataController dataController = new ClientDataController();

            // Inserts client demographics and miscellaneous client only information.
            newClient = dataController.InsertClient(newClient);

            // Inserts client's address.
            newClient = dataController.InsertClientAddress(newClient);

            // Inserts all family members attached to family.
            newClient = dataController.InsertClientFamily(newClient);



            return View("Referral", newClient);
        }

        /************************************************************************** READ ********************************************************/
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

        /************************************************************************** UPDATE ********************************************************/

        [HttpPost]
        public ActionResult UpdateClient(Client model)
        {
            bool success;

            ClientDataController dataController = new ClientDataController();

            success = dataController.UpdateClient(model);

            Session["client"] = model;

            return View("Client_Update", model);
        }

        /************************************************************************** DELETE ********************************************************/
        public ActionResult DeleteClient()
        {
            if (Session["client"] != null)
            {
                Client deletingClient = new Client();
                deletingClient = (Client)Session["client"];

                bool success;

                ClientDataController dataController = new ClientDataController();

                success = dataController.DeleteClient(deletingClient);
            
            }

            Client newClient = new Client();

            return View("Client_Update", newClient);
        }
    }
}
