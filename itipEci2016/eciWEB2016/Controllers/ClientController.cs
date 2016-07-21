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
        public ActionResult Client_Update()
        {
            if (Session["client"] == null)
            {
                // Creates a blank client for the inital view.
                Client currentClient = new Client();
                currentClient.clientID = 0;
                currentClient.accountingSystemID = 0;
                currentClient.ageInMonths = 0;
                currentClient.agencyFrom = "";
                currentClient.altID = "";
                currentClient.firstName = "";
                currentClient.lastName = "";
                currentClient.fullName = "";

                // Generates blank address data for blank Client.
                Address blankAddress = new Address()
                {
                    address1 = " ",
                    address2 = " ",
                    city = " ",
                    state = "TX",
                    zip = 0,
                    mapsco = "A1",
                    county = " "
                };
                currentClient.clientAddress = blankAddress;

                Session["client"] = currentClient;
            }

            return View();
        }

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
        public ActionResult UpdateClient(Client model)
        {
            Client newclient = new Client();
            bool success;

            ClientDataController dataController = new ClientDataController();

            success = dataController.UpdateClient(model);

            return View("Client_Update", newclient);
        }

        // GET: Client/Delete/5
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
            return View("Client_Update");
        }
    }
}
