/************************************************
Description: 
	Creates main Referral Source table that holds RS information,
	and informaiton related to each client's referrals.
Author: 
	Jennifer M. Graves
Date: 
	06/20/2016
Change history:

**************************************************/

CREATE TABLE ReferralSource (
	referralSourceID INT IDENTITY(1,1),
	additionalContactInfoID INT FOREIGN KEY REFERENCES AdditionalContactInfo(additionalContactInfoID),
	referralSourceTypeID INT FOREIGN KEY REFERENCES ReferralSourceType(referralSourceTypeID),
	addressesID INT FOREIGN KEY REFERENCES Addresses(addressesID),
	referralSource VARCHAR(25),
) 
--Type Table: Provides description of referral source
CREATE TABLE ReferralSourceType (
	referralSourceTypeID INT IDENTITY (1,1),
	referralSourceType VARCHAR(250),
	referralNotificationType VARCHAR(20),
	)

/* Referral types in legacy database include the following: 
   (Referral Source Code), (New Referral Code)

	Parents, Family, Friends, (A), (05)
	Medical/Health Services (B), (04)
	Social Services (C), (06)
	Educational Services (D), (02)
	ECI programs (including transfers) (E), (01)
	Follow Along (F), (03)
	Other (G), (07)

*/

-- This table links Clients and Referral Sources together.
CREATE TABLE LnkClientReferralSource (
	clientID INT,
	referralSourceID INT,
	PRIMARY KEY (clientID, referralSourceID),
)