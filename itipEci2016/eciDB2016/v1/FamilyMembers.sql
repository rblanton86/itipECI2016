--Main Table: Holds Family Member names
CREATE TABLE FamilyMember (
	familyMemberID INT IDENTITY (1,1) PRIMARY KEY (familyID),
	familyMemberTypeID INT FOREIGN KEY REFERENCES FamilyMemberType(familyMemberTypeID),
	additionalContactInfo INT FOREIGN KEY REFERENCES AdditionalContactInfo(additionalContactInfoID),
	addressesID INT FOREIGN KEY REFERENCES Addresses(addressesID),
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