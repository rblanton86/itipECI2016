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
using Pulzonic.Multipartial;
using System.Data.Common;

namespace eciWEB2016.Controllers
{
    /// <summary>
    /// Controller that interfaces with the database to return data needed for the Client object and views.
    /// </summary>
    public class ClientController : Controller
    {
        private ClientDataController clientDataController = new ClientDataController();

        /// <summary>
        /// Method which checks whether a client is loaded in the user session. Adds blank client if no client loaded. Also calls methods and returns to ViewBag data for all drop down lists on the Client_Update page.
        /// </summary>
        /// <returns>Returns client object to the Client_Update view, either a blank object or filled client object with information to current client in Session.</returns>
        public ActionResult Client_Update()
        {
            Client client = new Client();
            if (Session["client"] == null)
            {
                // Creates a blank client for the inital view.
                Session["client"] = client;
            }
            else
            {
                // Takes the current client from session and returns it to the Client_Update view model.
                client = (Client)Session["client"];
            }

            GetAllLists();

            return View(client);
        }

        public void GetAllLists()
        {
            ViewBag.officeList = GetOfficeList();
            ViewBag.sexList = GetSexList();
            ViewBag.raceList = GetRaceList();
            ViewBag.ethnicityList = GetEthnicityList();
            ViewBag.clientStatusList = GetClientStatusList();
            ViewBag.communicationPreferencesList = GetCommunicationPreferencesList();
            ViewBag.contactTypeList = GetContactTypeList();
            ViewBag.stateCodeList = GetStateCodeList();
            ViewBag.familyMemberTypeList = GetFamilyMemberTypeList();
            ViewBag.staffTypeList = GetStaffTypeList();
            ViewBag.staffList = GetStaffList();
            ViewBag.primaryLanguageList = GetPrimaryLanguageList();
            ViewBag.schoolInfoList = GetSchoolInfoList();
        }

        /// <summary>
        /// Calls a method to query the database for all offices in the database.
        /// </summary>
        /// <returns>Returns a select list of all offices.</returns>
        public SelectList GetOfficeList()
        {
            SelectList officeList = clientDataController.GetOfficeList();

            return new SelectList(officeList, "Value", "Text", new OfficeModel().officeID);
        }

        /// <summary>
        /// Calls a method to query the database for all sexes defined in the database.
        /// </summary>
        /// <returns>Returns a select list of all sexes defined.</returns>
        public SelectList GetSexList()
        {
            SelectList sexList = clientDataController.GetSexList();

            return new SelectList(sexList, "Value", "Text", new SexModel().sexID);
        }

        /// <summary>
        /// Calls a method to query the database for all races defined in the database.
        /// </summary>
        /// <returns>Returns a select list of all races defined.</returns>
        public SelectList GetRaceList()
        {
            SelectList raceList = clientDataController.GetRaceList();

            return new SelectList(raceList, "Value", "Text", new RaceModel().raceID);
        }

        /// <summary>
        /// Calls a method to query the database for all ethnicities defined in the database.
        /// </summary>
        /// <returns>Returns a select list of all ethnicities defined.</returns>
        public SelectList GetEthnicityList()
        {
            SelectList ethnicityList = clientDataController.GetEthnicityList();

            return new SelectList(ethnicityList, "Value", "Text", new EthnicityModel().ethnicityID);
        }

        /// <summary>
        /// Calls a method to query the database for all client statuses defined in the database (active/inactive).
        /// </summary>
        /// <returns>Returns a select list of all client statuses defined, such as active or inactive.</returns>
        public SelectList GetClientStatusList()
        {
            SelectList clientStatusList = clientDataController.GetClientStatusList();

            return new SelectList(clientStatusList, "Value", "Text", new ClientStatusModel().clientStatusID);
        }

        /// <summary>
        /// Calls a method to query the database for all communication preferences defined in the database.
        /// </summary>
        /// <returns>Returns a select list of all communication preferences defined.</returns>
        public SelectList GetCommunicationPreferencesList()
        {
            SelectList communicationPreferencesList = clientDataController.GetCommunicationPreferencesList();

            return new SelectList(communicationPreferencesList, "Value", "Text", new CommunicationPreferencesModel().communicationPreferencesID);
        }

        /// <summary>
        /// Calls a method to query the database for all contact types defined in the database.
        /// </summary>
        /// <returns>Returns a select list of all contact types defined.</returns>
        public SelectList GetContactTypeList()
        {
            SelectList contactTypeList = clientDataController.GetContactTypeList();

            return new SelectList(contactTypeList, "Value", "Text", new ContactTypeModel().contactTypeID);
        }

        /// <summary>
        /// Calls a method to query the database for all state codes.
        /// </summary>
        /// <returns>Returns a select list of all state codes.</returns>
        public SelectList GetStateCodeList()
        {
            SelectList stateCodeList = clientDataController.GetStateCodeList();

            return new SelectList(stateCodeList, "Value", "Text", new StateCodeModel().stateCodeID);
        }

        /// <summary>
        /// Calls a method to query the database for all family member types, or guardian types, defined in the database.
        /// </summary>
        /// <returns>Returns a select list of all family member types.</returns>
        public SelectList GetFamilyMemberTypeList()
        {
            SelectList familyMemberTypeList = clientDataController.GetFamilyMemberTypeList();

            return new SelectList(familyMemberTypeList, "Value", "Text", new FamilyMemberTypeModel().familyMemberTypeID);
        }

        /// <summary>
        /// Calls a method to query the database for all staff types on the database.
        /// </summary>
        /// <returns>Returns a select list of all staff types defined.</returns>
        public SelectList GetStaffTypeList()
        {
            StaffDataController staffController = new StaffDataController();
            SelectList staffTypeList = staffController.GetStaffTypeList();

            return new SelectList(staffTypeList, "Value", "Text");
        }

        public SelectList GetStaffList()
        {
            StaffDataController staffController = new StaffDataController();
            SelectList staffList = staffController.GetStaffDropDown();

            return new SelectList(staffList, "Value", "Text");
        }

        /// <summary>
        /// Calls a method to query the database for all languages listed on the database.
        /// </summary>
        /// <returns>Returns a select list of all languages defined.</returns>
        public SelectList GetPrimaryLanguageList()
        {
            SelectList primaryLanguageList = clientDataController.GetPrimaryLanguageList();

            return new SelectList(primaryLanguageList, "Value", "Text", new PrimaryLanguageModel().primaryLanguageID);
        }

        /// <summary>
        /// Calls a method to query the database for all ISD held on the database.
        /// </summary>
        /// <returns>Returns a select list of all ISD defined.</returns>
        public SelectList GetSchoolInfoList()
        {
            SelectList schoolInfoList = clientDataController.GetSchoolInfoList();

            return new SelectList(schoolInfoList, "Value", "Text", new SchoolInfoModel().schoolInfoID);
        }

        /// <summary>
        /// Calls a method to fill a list with every client currently on the database.
        /// </summary>
        /// <returns>Returns first name, last name, client ID and alt ID for every client on the database.</returns>
        [HttpGet]
        [ActionName("GetAjaxClientList")]
        public JsonResult GetClientList()
        {
            List<Client> clientList = new List<Client>();
            clientList = clientDataController.GetListClients();

            // Takes select list of all clients, returns at Json object.
            return Json(clientList, JsonRequestBehavior.AllowGet);
        }

        /************************************************************************** CREATE *******************************************************/

        // Clients are created on the referral page, see Referral Controller for Create methods.

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

            GetAllLists();

            return PartialView("Client_Partial");
        }

        [HttpPost]
        [ActionName("GetAjaxFamily")]
        [WebMethod(EnableSession = true)]
        public ActionResult GetFamily(Client currentClient)
        {
            if (Session["client"] != null)
            {
                currentClient = (Client)Session["client"];
            }

            GetAllLists();

            return PartialView("Client_FamilyGrid_Partial", currentClient.clientFamily);
        }

        [HttpPost]
        [ActionName("GetAjaxDiagnosis")]
        [WebMethod(EnableSession = true)]
        public ActionResult GetDiagnosis(Client currentClient)
        {
            if (Session["client"] != null)
            {
                currentClient = (Client)Session["client"];
            }

            GetAllLists();

            return PartialView("Client_DiagnosisGrid_Partial", currentClient.clientDiagnosis);
        }

        [HttpPost]
        [ActionName("GetAjaxPhysician")]
        [WebMethod(EnableSession = true)]
        public ActionResult GetPhysician(Client currentClient)
        {
            if (Session["client"] != null)
            {
                currentClient = (Client)Session["client"];
            }

            GetAllLists();

            return PartialView("Client_PhysicianGrid_Partial", currentClient.clientPhysicians);
        }

        /************************************************************************** UPDATE ********************************************************/

        [HttpPost]
        public ActionResult UpdateClient(Client currentClient)
        {
            bool success;

            ClientDataController dataController = new ClientDataController();

            success = dataController.UpdateClient(currentClient);

            Session["client"] = currentClient;

            GetAllLists();

            return View("Client_Update", currentClient);
        }

        /************************************************************************** DELETE ********************************************************/
        public ActionResult DeleteClient(Client deletingClient)
        {
            if (Session["client"] == null)
            {
                return View();
            }
            else
            {
                deletingClient = (Client)Session["client"];

                bool success;

                ClientDataController dataController = new ClientDataController();

                // Flags as deleted on the DB the client demographic information and the client Address.
                success = dataController.DeleteClient(deletingClient);
                success = dataController.DeleteClientAddress(deletingClient);

                // Flags as deleted all family assigned to patient.
                foreach (var family in deletingClient.clientFamily)
                {
                    success = dataController.DeleteClientFamily(family);
                }

                // Flags as deleted all insurance assigned to patient.
                foreach (var insurance in deletingClient.clientInsurance)
                {
                    success = dataController.DeleteClientInsurance(insurance, deletingClient);
                }

                // Flags as deleted all staff assigned to patient.
                foreach (var staff in deletingClient.clientStaff)
                {
                    success = dataController.DeleteClientStaff(staff, deletingClient);
                }

                // Flags as deleted all diagnoses assigned to patient.
                foreach (var diagnosis in deletingClient.clientDiagnosis)
                {
                    success = dataController.DeleteClientDiagnosis(diagnosis, deletingClient);
                }

                // Flags as deleted all comments assigned to patient.
                foreach (var comment in deletingClient.clientComments)
                {
                    success = dataController.DeleteClientComment(comment, deletingClient);
                }

                // Flags as deleted all physician assigned to patient.
                foreach (var physician in deletingClient.clientPhysicians)
                {
                    success = dataController.DeleteClientPhysician(physician, deletingClient);
                }

                // Removes current client from session to assign a blank client.
                Client newClient = new Client();
                Session["client"] = newClient;

                // Returns blank client to form.
                return View("Client_Update", newClient);
            }
        }
    }
}