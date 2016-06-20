/***********************************************************************************************************
Description: 
	 Creates all initial tables for the database
Author: 
	Tyrell Powers-Crane , Co-Author: Jennifer Graves
Date: 
	6.20.2016
Change History:
	
************************************************************************************************************/

--Type Table: Provides description of address table then creates address table
CREATE TABLE AddressesType (
	addressesTypeID INT IDENTITY (1,1) PRIMARY KEY (addressesTypeID),
	addressesType VARCHAR(25)
	)
--
CREATE TABLE Addresses (
	addressesID INT IDENTITY(1,1) PRIMARY KEY (addressesID),
	addressesTypeID INT FOREIGN KEY REFERENCES AddressType(addressesTypeID),
	address1 VARCHAR(50),
	address2 VARCHAR(25),
	city VARCHAR(25), 
	st NVARCHAR(2),
	zip INT,
)
--
CREATE TABLE MemberType (
	memberTypeID INT IDENTITY (1,1) PRIMARY KEY (memberTypeID),
	memberType VARCHAR(25),	
) 
--Type Table: Provides description of Additional Contact Info then creates addContactInfo Table
CREATE TABLE AdditionalContactInfoType (
	additionalContactInfoTypeID INT IDENTITY (1,1) PRIMARY KEY (additionalContactInfoTypeID),
	additionalContactInfoType VARCHAR(25)
	) 
--
CREATE TABLE AdditionalContactInfo (
	additionalContactInfoID INT IDENTITY (1,1) PRIMARY KEY (additionalContactInfoID),
	memberTypeID INT FOREIGN KEY REFERENCES MemberType(memberTypeID),
	additionalContactInfoTypeID INT FOREIGN KEY REFERENCES AdditionalContactInfoType(additonalContactInfoTypeID),
	additionalContactInfo VARCHAR(255),
) 
--Creates CommPref Table
CREATE TABLE CommunicationPreferences (
	communicationPreferencesID INT IDENTITY (1,1) PRIMARY KEY (communicationPreferencesID),
	communicationPreferences VARCHAR(25),
	)
--Type Table: Provides description of diagnosis (i.e. Primary) then creates diagnosis Table
CREATE TABLE DiagnosisType (
	diagnosisTypeID INT IDENTITY (1,1) PRIMARY KEY (diagnosisTYPEID),
	isPrimary BIT,
	diagnosisType VARCHAR(25)
	)
--
CREATE TABLE Diagnosis (
	diagnosisID INT IDENTITY (1,1) PRIMARY KEY (diagnosisID),
	diagnosisTypeID INT FOREIGN KEY REFERENCES DiagnosisType(diagnosisTypeID),
	icd_10_Code VARCHAR(15), 
	)
--Creates Extra/comments table
CREATE TABLE Comments (
	commentsID INT IDENTITY (1,1) PRIMARY KEY (commentsID) NOT NULL,
	comments varchar(250) NOT NULL,
	)
--Type Table: Provides information regarding family members (i.e. Mother) and creates family member table
CREATE TABLE FamilyMemberType (
	familyMemberTypeID INT IDENTITY (1,1) PRIMARY KEY (familyTypeID),
	familyMemberType VARCHAR(25),
)
--
CREATE TABLE FamilyMember (
	familyMemberID INT IDENTITY (1,1) PRIMARY KEY (familyID),
	familyMemberTypeID INT FOREIGN KEY REFERENCES FamilyMemberType(familyMemberTypeID),
	additionalContactInfo INT FOREIGN KEY REFERENCES AdditionalContactInfo(additionalContactInfoID),
	firstName VARCHAR(25),
	lastName VARCHAR(25),
	isGuardian BIT,
) 
--Creates Insurance Table
CREATE TABLE Insurance (
	insuranceID INT IDENTITY (1,1) PRIMARY KEY (insuranceID),
	insuranceName VARCHAR(75),
	insurancePolicyID VARCHAR(75),
	medPreAuthNumber VARCHAR(100),
	)
--CREATE TABLE InsuranceAuthorization (
CREATE TABLE InsuranceAuthorization (
	insuranceAuthID INT IDENTITY (1,1) PRIMARY KEY (insuranceAuthID),
	authorized_From INT,
	authorized_To INT,
	insuranceAuthorizationType VARCHAR (25)
	)
--Creates Primary Language Table
CREATE TABLE PrimaryLanguage (
	primaryLanguageID INT IDENTITY (1,1) PRIMARY KEY (primaryLanguageID),
	primaryLanguage VARCHAR(20),
	)
--Type Table: Provides description of referral source and Creates Referral source Table
CREATE TABLE ReferralSourceType (
	referralSourceTypeID INT IDENTITY (1,1),
	referralSourceType VARCHAR(250),
	referralNotificationType VARCHAR(20),
	)
--
CREATE TABLE ReferralSource (
	referralSourceID INT IDENTITY(1,1),
	additionalContactInfoID INT FOREIGN KEY REFERENCES AdditionalContactInfo(additionalContactInfoID),
	referralSourceTypeID INT FOREIGN KEY REFERENCES ReferralSourceType(referralSourceTypeID),
	addressesID INT FOREIGN KEY REFERENCES Addresses(addressesID),
	referralSource VARCHAR(25),
) 
--Creates school information table
CREATE TABLE SchoolInformation (
	schoolInfoID INT IDENTITY (1,1) PRIMARY KEY (schoolInfoID),
	isd int,
	)
--Creates stafftype table and creates staff table
CREATE TABLE StaffType (
	staffTypeID INT IDENTITY (1,1) PRIMARY KEY (staffTypeID),
	staffType VARCHAR(25),
)
--
CREATE TABLE Staff (
	staffID INT IDENTITY (1,1) PRIMARY KEY (staffID),
	staffTypeID INT FOREIGN KEY REFERENCES StaffType(staffTypeID),
	addressesID INT FOREIGN KEY REFERENCES Addresses(addressesID),
	additionalContactInfoID INT FOREIGN KEY REFERENCES AdditionalContactInfo(additionalContactInfoID),
	firstName VARCHAR(25),
	lastNAME VARCHAR(25),
)
--Creates Physician tables
CREATE TABLE Physician (
	physicianID INT IDENTITY (1,1) PRIMARY KEY (physicianID),
	addressesID INT FOREIGN KEY REFERENCES Addresses(addressesID),
	additionalContactInfoID INT FOREIGN KEY REFERENCES AdditionalContactInfo(additionalContactInfoID),
	officeID INT,
)
--Client Table
CREATE TABLE Clients ( 
		clientID INT IDENTITY (1,1) PRIMARY KEY (clientID),
		raceID INT FOREIGN KEY REFERENCES Race(raceID),
		ethnicityID INT FOREIGN KEY REFERENCES Ethnicity(ethnicityID),
		clientStatusID INT FOREIGN KEY REFERENCES ClientStatus(clientStatusID),
		firstName VARCHAR(25),
		lastName VARCHAR(25),
		dob INT,
		ssn INT,
		referralSource VARCHAR(50),
	)
-- linking tables
CREATE TABLE LnkAddressesFamily (
	addressesID INT FOREIGN KEY REFERENCES Addresses(addressesID),
	familyID INT FOREIGN KEY REFERENCES FamilyMember(familyMemberID),
	PRIMARY KEY (addressesID, familyID)
	)
CREATE TABLE LnkClientFamily (
	clientID INT FOREIGN KEY REFERENCES Clients(clientID),
	familyID INT FOREIGN KEY REFERENCES FamilyMember(familyMemberID),
	PRIMARY KEY (clientID, familyID),
)
CREATE TABLE LnkClientInsurance ( 
	insuranceID INT FOREIGN KEY REFERENCES Insurance(insuranceID),
	clientID INT FOREIGN KEY REFERENCES Clients(clientID),
	PRIMARY KEY (insuranceID, clientID)
	)
CREATE TABLE LnkClientReferralSource (
	clientID INT FOREIGN KEY REFERENCES Clients(clientID),
	referralSourceID INT FOREIGN KEY REFERENCES ReferralSource(referralSourceID),
	PRIMARY KEY (clientID, referralSourceID),
)
CREATE TABLE ClientStaff (
	clientID INT FOREIGN KEY REFERENCES Clients(clientID), 
	staffID INT FOREIGN KEY REFERENCES Staff(staffID),
	PRIMARY KEY (clientID, staffID),
)
