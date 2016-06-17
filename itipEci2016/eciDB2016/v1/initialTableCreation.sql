--Main table: clients.
CREATE TABLE Clients (
	clientID INT IDENTITY (1,1),
	raceID INT,
	ethnicityID INT,
	clientStatusID INT,
	familyID INT,
	referralSourceID INT,
	physicianID INT,
	staffID INT,
	memberAddressID INT,
	additionalContactInfoID INT,
	firstName VARCHAR(25),
	lastName VARCHAR(25),
	dob INT,
	ssn INT,
	referralSource VARCHAR(50),
)

/* Referral types in legacy database includ the following: 
   (Referral Source Code), (New Referral Code)

	Parents, Family, Friends, (A), (05)
	Medical/Health Services (B), (04)
	Social Services (C), (06)
	Educational Services (D), (02)
	ECI programs (including transfers) (E), (01)
	Follow Along (F), (03)
	Other (G), (07)

*/
CREATE TABLE ReferralSource (
	referralSourceID INT IDENTITY(1,1),
	additionalContactInfoID INT,
	referralSource VARCHAR(25),
)

--Main table: family.
CREATE TABLE FamilyMember (
	familyID INT IDENTITY (1,1),	
	familyTypeID INT,
	firstName VARCHAR(25),
	lastName VARCHAR(25),
	isGuardian BIT,
)

CREATE TABLE FamilyMemberType (
	familyTypeID INT IDENTITY (1,1),
	familyType VARCHAR(25),
)

--Main table: Staff.
CREATE TABLE Staff (
	staffID INT IDENTITY (1,1),
	staffTypeID INT,
	memberAddressID INT,
	additionalContactInfoID INT,
	firstName VARCHAR(25),
	lastNAME VARCHAR(25),
)

CREATE TABLE StaffType (
	staffTypeID INT IDENTITY (1,1),
	staffType VARCHAR(25),
)

--Main table: Holds all addresses on the database for any type. 
CREATE TABLE MemberAddress (
	memberAddressID INT IDENTITY(1,1),
	address1 VARCHAR(50),
	address2 VARCHAR(25),
	city VARCHAR(25),
	st NVARCHAR(2),
	zip INT,
)

--Main table: phone, email, twitter, etc...
CREATE TABLE AdditionalContactInfo (
	additionalContactInfoID INT IDENTITY (1,1),
	memberID INT, --Can be any table id, clientID, staffID, referralSourceID, etc.
	memberTypeID INT,
	additionalContactInfo VARCHAR(255),
)

--Reference table. Client, physician, referralsource, family member, staff.
CREATE TABLE MemberType (
	memberTypeID INT IDENTITY (1,1),
	memberType VARCHAR(25),	
)

CREATE TABLE Race (
	raceID INT IDENTITY (1,1),
	race VARCHAR(25),
)

CREATE TABLE Ethnicity (
	ethnicityID INT IDENTITY (1,1),
	ethnicity VARCHAR(25),
)

CREATE TABLE ClientStatus (
	clientStatusID INT IDENTITY (1,1),
	clientStatus VARCHAR(25),
	initialDate INT,
	dismissedDate INT,
	dismissalReason VARCHAR(100),
)

CREATE TABLE Physician (
	physicianID INT IDENTITY (1,1),
	officeID INT,
)

CREATE TABLE Office (
	officeID INT IDENTITY (1,1),
	office VARCHAR(25),
)

-- This table linking table to link Physicians and Offices together.
CREATE TABLE PhysicianOffice (
	officeID INT,
	physicianID INT,
	PRIMARY KEY (officeID, physicianID),
)

-- This table links Clients and Physicians together.
CREATE TABLE ClientPhysician (
	clientID INT,
	physicianID INT,
	PRIMARY KEY (clientID, physicianID),
)

-- This table links Clients and Family Members together.
CREATE TABLE ClientFamily (
	clientID INT,
	familyID INT,
	PRIMARY KEY (clientID, familyID),
)

-- This table links Clients and Referral Sources together.
CREATE TABLE ClientReferralSource (
	clientID INT,
	referralSourceID INT,
	PRIMARY KEY (clientID, referralSourceID),
)

-- This table links Clients and Staff togther.
CREATE TABLE ClientStaff (
	clientID INT,
	staffID INT,
	PRIMARY KEY (clientID, staffID),
)

CREATE TABLE Insurance (
	clientID INT,
	insuranceID INT,
	insuranceName VARCHAR(75),
	insurancePolicyID VARCHAR(75),
	medPreAuthNumber VARCHAR(100),
	)

CREATE TABLE InsuranceAuthorization (
	clientID INT,
	insuranceAuthID INT,
	authorized_From INT,
	authorized_To INT,
	)

CREATE TABLE SchoolInformation (
	schoolInfoID INT,
	clientID INT,
	isd int,
	)

CREATE TABLE Diagnosis (
	diagnosisID INT,
	clientID INT,
	icd_10_Code VARCHAR(15),
	PRIMARY KEY (clientID, diagnosisID)
	)

CREATE TABLE DiagnosisType (
	diagnosisTypeID INT,
	diagnosisID INT,
	isPrimary BIT,
	diagnosisType VARCHAR(25)
	)

CREATE TABLE Comments (
	clientID INT,
	commentsID INT,
	comments varchar(250),
	)
	