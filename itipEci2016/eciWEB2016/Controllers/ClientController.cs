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

        private ClientDataController dataController = new ClientDataController();

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

            ViewBag.officeList = GetOfficeList();
            //ViewBag.sexList = GetSexList();
            //ViewBag.raceList = GetRaceList();
            //ViewBag.ethnicityList = GetEthnicityList();
            //ViewBag.clientStatusList = GetClientStatusList();
            //ViewBag.communicationPreferencesList = GetCommunicationPreferencesList();
            //ViewBag.contactTypeList = GetContactTypeList();
            //ViewBag.stateCodeList = GetStateCodeList();
            //ViewBag.familyMemberTypeList = GetFamilyMemberTypeList();
            //ViewBag.staffTypeList = GetStaffTypeList();
            //ViewBag.primaryLanguageList = GetPrimaryLanguageList();
            //ViewBag.schoolInfoList = GetSchoolInfoList();

            return View(client);
        }

        public SelectList GetOfficeList()
        {
            SelectList officeList = dataController.GetOfficeList();

            return new SelectList(officeList, "Value", "Text", new OfficeModel().officeID);
        }

        //public SelectList GetSexList()
        //{
        //    SelectList sexList = dataController.GetSexList();

        //    return new SelectList(sexList, "Value", "Text", new SexModel().sexID);
        //}

        //public SelectList GetRaceList()
        //{
        //    SelectList raceList = dataController.GetRaceList();

        //    return new SelectList(raceList, "Value", "Text", new RaceModel().raceID);
        //}

        //public SelectList GetEthnicityList()
        //{
        //    SelectList ethnicityList = dataController.GetEthnicityList();

        //    return new SelectList(ethnicityList, "Value", "Text", new EthnicityModel().ethnicityID);
        //}

        //public SelectList GetClientStatusList()
        //{
        //    SelectList clientStatusList = dataController.GetClientStatusList();

        //    return new SelectList(clientStatusList, "Value", "Text", new ClientStatusModel().clientStatusID);
        //}

        //public SelectList GetCommunicationPreferencesList()
        //{
        //    SelectList communicationPreferencesList = dataController.GetCommunicationPreferencesList();

        //    return new SelectList(communicationPreferencesList, "Value", "Text", new CommunicationPreferencesModel().communicationPreferencesID);
        //}

        //public SelectList GetContactTypeList()
        //{
        //    SelectList contactTypeList = dataController.GetContactTypeList();

        //    return new SelectList(contactTypeList, "Value", "Text", new ContactTypeModel().contactTypeID);
        //}

        //public SelectList GetStateCodeList()
        //{
        //    SelectList stateCodeList = dataController.GetStateCodeList();

        //    return new SelectList(stateCodeList, "Value", "Text", new StateCodeModel().stateCodeID);
        //}

        //public SelectList GetFamilyMemberTypeList()
        //{
        //    SelectList familyMemberTypeList = dataController.GetFamilyMemberTypeList();

        //    return new SelectList(familyMemberTypeList, "Value", "Text", new FamilyMemberTypeModel().familyMemberTypeID);
        //}

        public SelectList GetStaffTypeList()
        {
            StaffDataController staffController = new StaffDataController();
            SelectList staffTypeList = staffController.GetStaffTypeList();

            return new SelectList(staffTypeList, "Value", "Text");
        }

        //public SelectList GetPrimaryLanguageList()
        //{
        //    SelectList primaryLanguageList = dataController.GetPrimaryLanguageList();

        //    return new SelectList(primaryLanguageList, "Value", "Text", new PrimaryLanguageModel().primaryLanguageID);
        //}

        //public SelectList GetSchoolInfoList()
        //{
        //    SelectList schoolInfoList = dataController.GetSchoolInfoList();

        //    return new SelectList(schoolInfoList, "Value", "Text", new SchoolInfoModel().schoolInfoID);
        //}

        [HttpGet]
        [ActionName("GetAjaxClientList")]
        public JsonResult GetClientList()
        {
            List<Client> clientList = new List<Client>();
            clientList = dataController.GetListClients();

            // Takes select list of all clients, returns at Json object.
            return Json(clientList, JsonRequestBehavior.AllowGet);
        }


        /************************************************************************** CREATE *******************************************************/

        public ActionResult InsertClient(Client newClient)
        {
            // Inserts client demographics and miscellaneous client only information.
            newClient = dataController.InsertClient(newClient);

            // Inserts client's address.
            newClient = dataController.InsertClientAddress(newClient);

            // Inserts all family members attached to the new client's family list.
            for (var family = 0; family <= newClient.clientFamily.Count; family++)
            {
                newClient.clientFamily[family] = dataController.InsertClientFamily(newClient.clientFamily[family], newClient.clientID);
            }

            // Inserts all insurances attached to the new Client.
            for (var insurance = 0; insurance <= newClient.clientInsurance.Count; insurance++)
            {
                newClient.clientInsurance[insurance] = dataController.InsertClientInsurance(newClient.clientInsurance[insurance], newClient.clientID);
            }

            // Inserts all staff attached to the new Client.
            for (var staff = 0; staff <= newClient.clientStaff.Count; staff++)
            {
                newClient.clientStaff[staff] = dataController.InsertClientStaff(newClient.clientStaff[staff], newClient.clientID);
            }

            // Inserts all diagnoses attached to the new Client.
            for (var diagnosis = 0; diagnosis <= newClient.clientDiagnosis.Count; diagnosis++)
            {
                newClient.clientDiagnosis[diagnosis] = dataController.InsertClientDiagnosis(newClient.clientDiagnosis[diagnosis], newClient.clientID);
            }

            // Inserts all physicians attached to the new Client.
            for (var physician = 0; physician <= newClient.clientDiagnosis.Count; physician++)
            {
                newClient.clientPhysicians[physician] = dataController.InsertClientPhysician(newClient.clientPhysicians[physician], newClient.clientID);
            }

            // Inserts all comments attached to the new Client.
            for (var comments = 0; comments <= newClient.clientComments.Count; comments++)
            {
                newClient.clientComments[comments] = dataController.InsertClientComments(newClient.clientComments[comments], newClient.clientID, newClient.memberTypeID);
            }


            // Updates the current in session client to the newly created client.
            Session["client"] = newClient;

            return View("Referral", newClient);
        }

        public ActionResult InsertClientFamily(Family newFamilyMember)
        {

            return View();
        }

        public ActionResult InsertClientInsurance()
        {

            return View();
        }

        public ActionResult InsertClientInsAuth()
        {

            return View();
        }

        public ActionResult InsertClientStaff()
        {

            return View();
        }

        public ActionResult InsertClientDiagnosis()
        {

            return View();
        }

        public ActionResult InsertClientComments()
        {

            return View();
        }

        public ActionResult InsertClientPhysician()
        {


            return View();
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
        public ActionResult UpdateClient(Client currentClient)
        {
            bool success;

            ClientDataController dataController = new ClientDataController();

            success = dataController.UpdateClient(currentClient);

            Session["client"] = currentClient;

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