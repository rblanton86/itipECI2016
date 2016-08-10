using eciWEB2016.Controllers.DataControllers;
using eciWEB2016.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Services;

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
            // Creates empty view to avoid errors caused by null model.
            Referral newReferral = new Referral();
            Client newClient = new Client();

            ReferralViewModel view = new ReferralViewModel();

            if (Session["client"] != null)
            {
                // Clears session of current client.
                Session["client"] = newClient;
            }

            GetAllLists();

            return View(view);
        }

        public void GetAllLists()
        {
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
        }

        

        /************************************************************************** CREATE *******************************************************/

        /// <summary>
        /// Inserts a new referral into the database and saves it to session.
        /// </summary>
        /// <param name="newReferral"></param>
        /// <returns>Referral view with new referral loaded.</returns>
        [HttpPost]
        [WebMethod(EnableSession = true)]
        public ActionResult InsertReferral(ReferralViewModel newReferral)
        {
            Client newClient = new Client();

            if(Session["client"] != null)
            {
                newClient = (Client)Session["client"];
            }

            if(newClient.firstName != "" && newClient.lastName != "" && newClient.clientID != 0)
            {
                newClient = referralDataController.InsertClient(newClient);
            }

            newReferral.client.guardian.isGuardian = true;
            
            newReferral.client.clientAddress = newReferral.client.guardian.familyAddress;

            newReferral.client.phone = newReferral.client.guardian.familyContact.Find(c => c.additionalContactInfoTypeID == 1);

            newClient.clientFamily.Add(newReferral.client.guardian);

            newClient.clientReferrals.Add(newReferral.referral);

            Session["client"] = newClient;

            GetAllLists();

            return JsonResult("Referral", newReferral);
        }

        [HttpPost]
        [WebMethod(EnableSession = true)]
        public ActionResult InsertNewFamily()
        {
            Client client = new Client();

            Family newFamilyMember = new Family();

            if (Session["client"] != null)
            {
                client = (Client)Session["client"];
            }

            client.clientFamily.Add(newFamilyMember);

            Session["client"] = client;

            clientController.GetAllLists();

            return PartialView("_FamilyPartial", client.clientFamily);
        }
    }
}
