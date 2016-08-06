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
        private ClientDataController clientDataController = new ClientDataController();

        private ClientController clientController = new ClientController();

        private ReferralDataController referralDataController = new ReferralDataController();

        /// <summary>
        /// Controller that interfaces withe the view to return data received from the database.
        /// </summary>
        public ActionResult Referral()
        {
            Referral newReferral = new Referral();

            if (Session["client"] != null)
            {
                Session["client"] = newReferral.referredClient;
            }

            ViewBag.officeList = clientController.GetOfficeList();
            ViewBag.sexList = clientController.GetSexList();
            ViewBag.raceList = clientController.GetRaceList();
            ViewBag.ethnicityList = clientController.GetEthnicityList();
            ViewBag.clientStatusList = clientController.GetClientStatusList();
            ViewBag.communicationPreferencesList = clientController.GetCommunicationPreferencesList();
            ViewBag.contactTypeList = clientController.GetContactTypeList();
            ViewBag.stateCodeList = clientController.GetStateCodeList();
            ViewBag.familyMemberTypeList = clientController.GetFamilyMemberTypeList();
            ViewBag.staffTypeList = clientController.GetStaffTypeList();
            ViewBag.staffList = clientController.GetStaffList();
            ViewBag.primaryLanguageList = clientController.GetPrimaryLanguageList();
            ViewBag.schoolInfoList = clientController.GetSchoolInfoList();

            return View(newReferral);
        }


        /************************************************************************** CREATE *******************************************************/
        
        [HttpPost]
        public ActionResult InsertReferral(Referral newReferral)
        {
            newReferral.referredClient = InsertClient(newReferral.referredClient);
            newReferral.referredClient = InsertClientStaff(newReferral.referredClient);

            return View();
        }

        public Client InsertClient(Client newClient)
        {
            newClient = referralDataController.InsertClient(newClient);

            return newClient;
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

        public Client InsertClientStaff(Client newClient)
        {
            if (newClient.intakeCoordinator != null)
            {
                newClient.intakeCoordinator = referralDataController.InsertClientStaff(newClient.intakeCoordinator, newClient.clientID);

                newClient.clientStaff.Add(newClient.intakeCoordinator);
            }

            if (newClient.serviceCoordinator != null)
            {
                newClient.serviceCoordinator = referralDataController.InsertClientStaff(newClient.serviceCoordinator, newClient.clientID);

                newClient.clientStaff.Add(newClient.serviceCoordinator);
            }

            if (newClient.caseManager != null)
            {
                newClient.caseManager = referralDataController.InsertClientStaff(newClient.caseManager, newClient.clientID);

                newClient.clientStaff.Add(newClient.caseManager);
            }

            return newClient;
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
    }
}
