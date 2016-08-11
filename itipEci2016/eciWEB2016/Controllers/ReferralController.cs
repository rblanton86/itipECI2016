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
        /// Inserts a new referral into the database and saves it to session.
        /// </summary>
        /// <param name="newReferral"></param>
        /// <returns>Referral view with new referral loaded.</returns>
        [HttpPost]
        [WebMethod(EnableSession = true)]
        public ActionResult InsertReferral(ReferralViewModel newReferral)
        {
            // Checks if client has already been inserted to database, inserts if client has not.
            if(newReferral.client.clientID == 0)
            {
                // Calls method to insert new client and returns client information. Returns with ID value for later checks.
                newReferral.client = InsertNewClient(newReferral.client);

                // Adds guardian to the list of family members belonging to the patient.
                newReferral.client.clientFamily.Add(newReferral.client.guardian);

                // Adds the new referral to client object.
                newReferral.client.clientReferrals.Add(newReferral.referral);

                // Checks if each referral information has been added to the database
                for (int referral = 0; referral <= newReferral.client.clientReferrals.Count(); referral ++)
                {
                    newReferral.client.clientReferrals[referral] = referralDataController.InsertClientReferral(newReferral.client.clientReferrals[referral], newReferral.client.clientID);
                }
            }

            Session["client"] = newReferral.client;

            GetAllLists();

            return Json(newReferral);
        }

        /// <summary>
        /// Calls data controller to insert client into the database.
        /// </summary>
        /// <param name="newClient"></param>
        /// <returns>Returns a client object with clientID for further checks agains.</returns>
        public Client InsertNewClient(Client newClient)
        {
            // Sets primary guardian isGuardian value to true after entry.
            if (newClient.guardian.isGuardian == false)
            {
                newClient.guardian.isGuardian = true;
            }

            // Assigns primary guardian's address to client Address.
            newClient.clientAddress = newClient.guardian.familyAddress;

            newClient.clientAddress = InsertNewAddress(newClient.clientAddress, newClient.clientID, 1);

            // Assigns primary guardian's home phone to client as primary phone.
            newClient.phone = newClient.guardian.familyContact.Find(c => c.additionalContactInfoTypeID == 1);

            // Calls method in the data controller to insert client into the database and returns a client object with client ID for further checks against.
            newClient = referralDataController.InsertClient(newClient);

            return newClient;
        }

        /// <summary>
        /// Calls data controller to insert client into the database.
        /// </summary>
        /// <param name="newAddress"></param>
        /// <returns>Returns an address object with addressesID for further checks against.</returns>
        public Address InsertNewAddress(Address newAddress, int memberID, int memberTypeID)
        {
            if(newAddress.addressesID == 0)
            {
                newAddress = addressesDataController.InsertAddress(newAddress, memberID, memberTypeID);
            }
            else
            {
                newAddress = addressesDataController.UpdateAddress(newAddress, memberID, memberTypeID);
            }

            return newAddress;
        }

        /// <summary>
        /// Calls data controller to insert client's family members into the database.
        /// </summary>
        /// <param name="newFamily"></param>
        /// <param name="ClientID"></param>
        /// <returns>Family object with familyMemberID assigned for further checks against.</returns>
        public List<Family> InsertNewFamily(List<Family> familyList, int clientID)
        {
            // Inserts all new family members into database.
            for (int familyMember = 0; familyMember <= familyList.Count(); familyMember++)
            {
                // Checks if selected family member has already been entered into the database.
                if (familyList[familyMember].familyMemberID == 0)
                {
                    // Inserts family member into the database, returns with ID value for later checks.
                    familyList[familyMember] = referralDataController.InsertClientFamily(familyList[familyMember], clientID);
                }
            }

            return familyList;
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

            return PartialView("_FamilyPartial", client.clientFamily);
        }
    }
}
