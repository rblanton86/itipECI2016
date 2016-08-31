using eciWEB2016.Controllers.DataControllers;
using eciWEB2016.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Services;
using eciWEB2016.Class;

namespace eciWEB2016.Controllers
{
    public class ReferralController : Controller
    {
        private ClientDataController clientDataController = new ClientDataController();

        private ClientController clientController = new ClientController();

        private ReferralDataController referralDataController = new ReferralDataController();

        private AddressesDataController addressesDataController = new AddressesDataController();

        /// <summary>
        /// Controller that interfaces withe the view to return data received from the database.
        /// </summary>
        public ActionResult Referral()
        {
            ReferralViewModel view = new ReferralViewModel()
            {
                client = new Client(),
                referral = new Referral()
            };

            if (Session["client"] != null)
            {
                // Clears session of current client.
                Session["client"] = view.client;
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
        /// Inserts a new referral to the client in Session.
        /// </summary>
        /// <param name="newReferral"></param>
        /// <returns>Partial view with updated client and referral objects.</returns>
        [HttpPost]
        [WebMethod(EnableSession = true)]
        public ActionResult InsertReferral(ReferralViewModel newReferral)
        {
            Client newClient = new Client();
            newClient = (Client)Session["client"];

            if (newClient.clientReferrals != null)
            {
                var thisReferral = newClient.clientReferrals.FindIndex(r => r.insertReferralDetailsComplete);
                newClient.clientReferrals[thisReferral] = newReferral.referral;

                // Marks client object as insert referral completed.
                newReferral.referral.insertReferralMainComplete = true;

                // Adds new referral object to the client object.
                newClient.clientReferrals.Add(newReferral.referral);

                // Marks entire referral as entry complete.
                newClient.insertReferralComplete = true;
            }
            else
            {
                newReferral.referral.insertReferralMainComplete = true;

                newClient.clientReferrals.Add(newReferral.referral);
            }

            // Returns updated client to session.
            Session["client"] = newClient;

            // Calls method to insert client if all insert properties are true.
            InsertNewClient(newReferral.client);

            // Gets list again for view.
            GetAllLists();

            return PartialView("_ReferralPartial", newReferral);
        }

        /// <summary>
        /// Inserts detailed referral information to the client in Session.
        /// </summary>
        /// <param name="newReferral"></param>
        /// <returns>Partial view with updated client and referral objects.</returns>
        [HttpPost]
        [WebMethod(EnableSession = true)]
        public ActionResult InsertReferralDetails(ReferralViewModel newReferral)
        {
            if (!newReferral.referral.insertReferralDetailsComplete)
            {
                // Assigns client in session to a client object.
                Client newClient = new Client();

                if(Session["client"] != null)
                {
                    newClient = (Client)Session["client"];
                }

                if (newReferral.referral.insertReferralMainComplete)
                {
                    // Updates the client's referral to include the new referral details.
                    var thisReferral = newClient.clientReferrals.FindIndex(r => r.insertReferralMainComplete);

                    // Inserts the referral details.
                    newClient.clientReferrals[thisReferral] = newReferral.referral;

                    // Marks insert of referral Details as complete.
                    newClient.clientReferrals[thisReferral].insertReferralDetailsComplete = true;

                    // Marks entire referral object as complete on the client object.
                    newClient.insertReferralComplete = true;
                }
                else
                {
                    newReferral.referral.insertReferralDetailsComplete = true;
                    newClient.clientReferrals.Add(newReferral.referral);
                }

                // Returns updated client object to Session.
                Session["client"] = newClient;

                // Calls method to insert client if all insert properties are true.
                InsertNewClient(newClient);
            }

            return PartialView("_ReferralDetailsPartial", newReferral);
        }

        /// <summary>
        /// Inserts client information into client in Session.
        /// </summary>
        /// <param name="newReferral"></param>
        /// <returns>Partial view with updated client and referral objects.</returns>
        [HttpPost]
        [WebMethod(EnableSession = true)]
        public ActionResult InsertClient(ReferralViewModel newReferral)
        {
            if (!newReferral.client.insertClientComplete)
            {
                // Checks if guardian is marked as guardian, so entry cannot be duplicated.
                if (!newReferral.client.guardian.isGuardian)
                {
                    // Marks family member as guardian.
                    newReferral.client.guardian.isGuardian = true;

                    // Adds guardian's home address to client's address.
                    newReferral.client.clientAddress = newReferral.client.guardian.familyAddress;

                    // Adds home number to client's main phone.
                    newReferral.client.phone = newReferral.client.guardian.familyContact.Find(c => c.additionalContactInfoTypeID == 1);

                    // Adds guardian to client object's family list.
                    newReferral.client.clientFamily.Add(newReferral.client.guardian);
                }

                // Marks client object as insert client completed.
                newReferral.client.insertClientComplete = true;

                // Returns updated client object to Session.
                Session["client"] = newReferral.client;

                // Calls method to insert client if all insert properties are true.
                InsertNewClient(newReferral.client);
            }

            return PartialView("_ClientPartial", newReferral);
        }

        /// <summary>
        /// Inserts additional client detail information to the new client in session.
        /// </summary>
        /// <param name="newReferral"></param>
        /// <returns>Partial view with client and referral objects.</returns>
        public ActionResult InsertClientDetails(ReferralViewModel newReferral)
        {
            if (!newReferral.client.insertClientDetailsComplete)
            {
                // Marks client object as insert client completed.
                newReferral.client.insertClientDetailsComplete = true;

                // Returns updated client object to Session.
                Session["client"] = newReferral.client;

                // Calls method to insert client if all insert properties are true.
                InsertNewClient(newReferral.client);
            }

            return PartialView("_ClientDetailsPartial", newReferral);
        }

        /// <summary>
        /// Inserts family information into client in Session.
        /// </summary>
        /// <param name="newReferral"></param>
        /// <returns>Partial view with updated client and referral objects.</returns>
        [HttpPost]
        [WebMethod(EnableSession = true)]
        public ActionResult InsertFamily(ReferralViewModel newReferral)
        {
            if (!newReferral.client.insertFamilyComplete)
            {
                // Check if guardian has been entered into family list, adds if not.
                if (!newReferral.client.guardian.isGuardian)
                {
                    // Marks family member as guardian.
                    newReferral.client.guardian.isGuardian = true;

                    // Adds guardian's home address to client's address.
                    newReferral.client.clientAddress = newReferral.client.guardian.familyAddress;

                    // Adds home number to client's main phone.
                    newReferral.client.phone = newReferral.client.guardian.familyContact.Find(c => c.additionalContactInfoTypeID == 1);

                    // Adds guardian to client object's family list.
                    newReferral.client.clientFamily.Add(newReferral.client.guardian);
                }

                // Marks client object as insert family completed.
                newReferral.client.insertFamilyComplete = true;

                // Returns updated client object to Session.
                Session["client"] = newReferral.client;

                // Calls method to insert client if all insert properties are true.
                InsertNewClient(newReferral.client);
            }

            return PartialView("_FamilyPartial", newReferral);
        }

        [HttpPost]
        [WebMethod(EnableSession = true)]
        public ActionResult AddFamilyToList()
        {
            Client client = new Client();

            Family newFamilyMember = new Family()
            {
                familyMemberTypeID = 1
            };

            if (Session["client"] != null)
            {
                client = (Client)Session["client"];
            }

            client.clientFamily.Add(newFamilyMember);

            Session["client"] = client;

            GetAllLists();

            return PartialView("_FamilyListPartial", client.clientFamily);
        }

        public void InsertNewClient(Client newClient)
        {
            if (newClient.insertClientComplete && newClient.insertClientDetailsComplete && newClient.insertReferralComplete && newClient.insertReferralComplete)
            {
                newClient = referralDataController.InsertNewClient(newClient);
                Session["client"] = newClient;
            };
        }
    }
}
