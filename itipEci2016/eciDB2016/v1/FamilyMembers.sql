/************************************************
Description: 
	Creates table to hold family member and related
	information, including a table to link family information
	together.
Author: 
	Jennifer M. Graves
Date: 
	06/20/2016
Change history:

**************************************************/

CREATE TABLE FamilyMember (
	familyMemberID INT IDENTITY (1,1) PRIMARY KEY (familyID),
	familyMemberTypeID INT FOREIGN KEY REFERENCES FamilyMemberType(familyMemberTypeID),
	additionalContactInfo INT FOREIGN KEY REFERENCES AdditionalContactInfo(additionalContactInfoID),
	firstName VARCHAR(25),
	lastName VARCHAR(25),
	isGuardian BIT,
) 
--Type Table: Provides information regarding family members (i.e. Mother)
CREATE TABLE FamilyMemberType (
	familyMemberTypeID INT IDENTITY (1,1) PRIMARY KEY (familyTypeID),
	familyMemberType VARCHAR(25),
)

-- This table links Clients and Family Members together.
CREATE TABLE LnkClientFamily (
	clientID INT,
	familyID INT,
	PRIMARY KEY (clientID, familyID),
)
--Lnk Table: Links Addresses and family
CREATE TABLE LnkAddressesFamily (
	addressesID INT FOREIGN KEY REFERENCES Addresses(addressesID),
	familyID INT FOREIGN KEY REFERENCES FamilyMember(familyMemberID),
	PRIMARY KEY (addressesID, familyID)
	)
