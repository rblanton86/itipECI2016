/***********************************************************************************************************
Description: 
	 Creates all initial tables for the database
Author: 
	Tyrell Powers-Crane , Co-Author: Jennifer Graves
Date: 
	6.20.2016
Change History:
	06-20-2016: -- jmg -- Clarification, edits to tables.
	07-11-2016: -- jmg -- Updates to add tables.
	07-12-2016: -- jmg -- Added diagnosis tables.
************************************************************************************************************/

CREATE TABLE Race (
	raceID INT IDENTITY (1,1) PRIMARY KEY,
	race VARCHAR(25) NOT NULL
)

CREATE TABLE Ethnicity (
	ethnicityID INT IDENTITY (1,1) PRIMARY KEY,
	ethnicity VARCHAR(25) NOT NULL
)

CREATE TABLE ClientStatus (
	clientStatusID INT IDENTITY (1,1) PRIMARY KEY,
	clientStatus VARCHAR(25) NOT NULL
)

--Type Table: Provides description of address table then creates address table
CREATE TABLE AddressesType (
	addressesTypeID INT IDENTITY (1,1) PRIMARY KEY (addressesTypeID) NOT NULL,
	addressesType VARCHAR(25) NOT NULL
	)

CREATE TABLE Addresses (
	addressesID INT IDENTITY(1,1) PRIMARY KEY (addressesID) NOT NULL,
	addressesTypeID INT FOREIGN KEY REFERENCES AddressesType(addressesTypeID),
	address1 VARCHAR(50),
	address2 VARCHAR(25),
	city VARCHAR(25), 
	st NVARCHAR(2),
	zip INT,
)
--
CREATE TABLE MemberType (
	memberTypeID INT IDENTITY (1,1) PRIMARY KEY (memberTypeID) NOT NULL,
	memberType VARCHAR(25) NOT NULL	
)

--Type Table: Provides description of Additional Contact Info then creates addContactInfo Table
CREATE TABLE AdditionalContactInfoType (
	additionalContactInfoTypeID INT IDENTITY (1,1) PRIMARY KEY (additionalContactInfoTypeID) NOT NULL,
	additionalContactInfoType VARCHAR(25)
	)

CREATE TABLE AdditionalContactInfo (
	additionalContactInfoID INT IDENTITY (1,1) PRIMARY KEY (additionalContactInfoID) NOT NULL,
	memberTypeID INT FOREIGN KEY REFERENCES MemberType(memberTypeID),
	additionalContactInfoTypeID INT FOREIGN KEY REFERENCES AdditionalContactInfoType(additionalContactInfoTypeID),
	additionalContactInfo VARCHAR(255) NOT NULL,
)

--Creates CommPref Table
CREATE TABLE CommunicationPreferences (
	communicationPreferencesID INT IDENTITY (1,1) PRIMARY KEY (communicationPreferencesID),
	communicationPreferences VARCHAR(25) NOT NULL,
	)

--Type Table: Provides description of diagnosis (i.e. Primary) then creates diagnosis Table
CREATE TABLE DiagnosisType (
	diagnosisTypeID INT IDENTITY (1,1) PRIMARY KEY (diagnosisTYPEID),
	isPrimary BIT,
	diagnosisType VARCHAR(25)
	)

--Creates Extra/comments table
CREATE TABLE Comments (
	commentsID INT IDENTITY (1,1) PRIMARY KEY (commentsID) NOT NULL,
	comments varchar(250) NOT NULL,
	)

--Type Table: Provides information regarding family members (i.e. Mother) and creates family member table
CREATE TABLE FamilyMemberType (
	familyMemberTypeID INT IDENTITY (1,1) PRIMARY KEY (familyMemberTypeID),
	familyMemberType VARCHAR(25) NOT NULL,
)

CREATE TABLE FamilyMember (
	familyMemberID INT IDENTITY (1,1) PRIMARY KEY (familyMemberID),
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
	commentsID INT FOREIGN KEY REFERENCES Comments(commentsID),
	authorized_From INT,
	authorized_To INT,
	insuranceAuthorizationType VARCHAR (25)
	)

--Creates Primary Language Table
CREATE TABLE PrimaryLanguage (
	primaryLanguageID INT IDENTITY (1,1) PRIMARY KEY (primaryLanguageID),
	primaryLanguage VARCHAR(20) NOT NULL,
	)

--Type Table: Provides description of referral source and Creates Referral source Table
CREATE TABLE ReferralSourceType (
	referralSourceTypeID INT IDENTITY (1,1) PRIMARY KEY (referralSourceTypeID),
	referralSourceType VARCHAR(250),
	referralNotificationType VARCHAR(20),
	)

CREATE TABLE ReferralSource (
	referralSourceID INT IDENTITY(1,1) PRIMARY KEY (referralSourceID),
	additionalContactInfoID INT FOREIGN KEY REFERENCES AdditionalContactInfo(additionalContactInfoID),
	referralSourceTypeID INT FOREIGN KEY REFERENCES ReferralSourceType(referralSourceTypeID),
	addressesID INT FOREIGN KEY REFERENCES Addresses(addressesID),
	referralSource VARCHAR(25) NOT NULL,
	)

--Creates school information table
CREATE TABLE SchoolInformation (
	schoolInfoID INT IDENTITY (1,1) PRIMARY KEY (schoolInfoID),
	isd int NOT NULL
	)

--Creates stafftype table and creates staff table
CREATE TABLE StaffType (
	staffTypeID INT IDENTITY (1,1) PRIMARY KEY (staffTypeID),
	staffType VARCHAR(25) NOT NULL
	)

CREATE TABLE Staff (
	staffID INT IDENTITY (1,1) PRIMARY KEY (staffID),
	staffTypeID INT FOREIGN KEY REFERENCES StaffType(staffTypeID),
	addressesID INT FOREIGN KEY REFERENCES Addresses(addressesID),
	additionalContactInfoID INT FOREIGN KEY REFERENCES AdditionalContactInfo(additionalContactInfoID),
	firstName VARCHAR(25),
	lastName VARCHAR(25),
	)

--Creates Physician tables
CREATE TABLE Physician (
	physicianID INT IDENTITY (1,1) PRIMARY KEY (physicianID),
	addressesID INT FOREIGN KEY REFERENCES Addresses(addressesID),
	additionalContactInfoID INT FOREIGN KEY REFERENCES AdditionalContactInfo(additionalContactInfoID),
	title VARCHAR(10),
	firstName VARCHAR(25),
	lastName VARCHAR(25),
	)

-- Creates Sex table
CREATE TABLE Sex (
	sexID INT IDENTITY (1,1) PRIMARY KEY,
	sex VARCHAR(25),
	)

-- Creates Office table.
CREATE TABLE Office (
	officeID INT IDENTITY (1,1) PRIMARY KEY,
	officeName VARCHAR(25),
	)

--Client Table
CREATE TABLE Clients ( 
	clientID INT IDENTITY (1,1) PRIMARY KEY (clientID),
	raceID INT FOREIGN KEY REFERENCES Race(raceID),
	ethnicityID INT FOREIGN KEY REFERENCES Ethnicity(ethnicityID),
	clientStatusID INT FOREIGN KEY REFERENCES ClientStatus(clientStatusID),
	primaryLanguageID INT FOREIGN KEY REFERENCES PrimaryLanguage(primaryLanguageID),
	schoolInfoID INT FOREIGN KEY REFERENCES SchoolInformation(schoolInfoID),
	commentsID INT FOREIGN KEY REFERENCES Comments(commentsID),
	insuranceAuthID INT FOREIGN KEY REFERENCES InsuranceAuthorization(insuranceAuthID),
	communicationPreferencesID INT FOREIGN KEY REFERENCES CommunicationPreferences(communicationPreferencesID),
	sexID INT FOREIGN KEY REFERENCES Sex(sexID),
	officeID INT FOREIGN KEY REFERENCES Office(officeID),
	addressesID INT FOREIGN KEY REFERENCES Addresses(addressesID),
	altID VARCHAR(25),
	firstName VARCHAR(25),
	middleInitial VARCHAR(1),
	lastName VARCHAR(25),
	dob DATE,
	ssn INT,
	referralSource VARCHAR(50),
	intakeDate DATETIME,
	ifspDate DATE,
	compSvcDate DATE,
	serviceAreaException BIT,
	tkidsCaseNumber INT,
	consentToRelease BIT,
	eci VARCHAR(25),
	accountingSystemID VARCHAR(25),
	deleted BIT
	)

-- Creates DiagnosisCode table.
CREATE TABLE DiagnosisCode (
	diagnosisCodeID INT IDENTITY (1,1) PRIMARY KEY,
	diagnosisCode VARCHAR(10),
	diagnosisDescription VARCHAR(100)
)

-- Creates DiagnosisType table
CREATE TABLE DiagnosisType (
	diagnosisTypeID INT IDENTITY (1,1) PRIMARY KEY,
	diagnosisType VARCHAR(10)
)

-- Creates Diagnosis table.
CREATE TABLE Diagnosis (
	diagnosisID INT IDENTITY(1,1) PRIMARY KEY(DiagnosisID),
	clientID INT CONSTRAINT FK_diagnosis_client FOREIGN KEY REFERENCES Client(clientID),
	diagnosisCodeID INT CONSTRAINT FK_diagnosis_diagnosisCode FOREIGN KEY REFERENCES DiagnosisCode(diagnosisCodeID),
	diagnosisTypeID INT CONSTRAINT FK_diagnosis_diagnosisType FOREIGN KEY REFERENCES DiagnosisType(diagnosisTypeID),
	isPrimary BIT,
	diagnosis_From DATE,
	diagnosis_To DATE,
	deleted BIT
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
	commentsID INT FOREIGN KEY REFERENCES Comments(commentsID),
	)

CREATE TABLE ClientStaff (
	clientID INT FOREIGN KEY REFERENCES Clients(clientID), 
	staffID INT FOREIGN KEY REFERENCES Staff(staffID),
		PRIMARY KEY (clientID, staffID),
	)

CREATE TABLE TimeHeader (
	timeHeaderID int IDENTITY (1,1) PRIMARY KEY,
	staffID int FOREIGN KEY REFERENCES Staff(staffID),
	weekEnding varchar(10),
	deleted bit
	)

CREATE TABLE TimeDetail (
	timeDetailID int IDENTITY (1,1) PRIMARY KEY,
	timeHeaderID int FOREIGN KEY REFERENCES TimeHeader(timeHeaderID),
	clientID int FOREIGN KEY REFERENCES Clients(clientID),
	actualTime decimal,
	eciCode varchar(5),
	insuranceDesignation char(1),
	cptCode varchar(5),
	insuranceTime decimal,
	placeOfService char(1),
	tcm varchar(10),
	canceled varchar(10),
	updDate datetime,
	deleted bit
	)