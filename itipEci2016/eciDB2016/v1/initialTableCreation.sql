--Main table: clients.
CREATE TABLE Clients (
	clientID INT IDENTITY (1,1) NOT NULL PRIMARY KEY,
	memberTypeID INT FOREIGN KEY REFERENCES MemberType(memberTypeID),
	raceID INT FOREIGN KEY REFERENCES Race(raceID),
	ethnicityID INT FOREIGN KEY REFERENCES Ethnicity(ethnicityID),
	clientStatusID INT FOREIGN KEY REFERENCES ClientStatus(clientStatusID),
	familyID INT FOREIGN KEY REFERENCES FamilyMember(familyID),
	-- referralSourceID INT FOREIGN KEY REFERENCES ReferralSource(referralSourceID), -- Removed so that after linking table ClientReferral is created, it will link to this instead.
	physicianID INT FOREIGN KEY REFERENCES Physician(physicianID),
	staffID INT FOREIGN KEY REFERENCES Staff(staffID),
	memberAddressID INT FOREIGN KEY REFERENCES MemberAddress(memberAddressID),
	additionalContactInfoID INT FOREIGN KEY REFERENCES AdditionalContactInfo(additionalContactInfoID),
	firstName VARCHAR(25),
	middleInitial VARCHAR(1),
	lastName VARCHAR(25),
	dob INT,
	ssn INT,
	weightLBS INT, -- do we need both weight fields? one can be figured off of the other mathematically rather than stored as a separate value later?
	weightOZ INT, -- ??
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
	referralSourceID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	memberTypeID INT FOREIGN KEY REFERENCES MemberType(memberTypeID),
	additionalContactInfoID INT FOREIGN KEY REFERENCES AdditionalContactInfo(additionalContactInfoID),
	referralSource VARCHAR(25),
	referringAgencyName VARCHAR(25),
	referringAgencyLocation VARCHAR(25), -- City, State
)

--Main table: family.
CREATE TABLE FamilyMember (
	familyID INT IDENTITY (1,1) NOT NULL PRIMARY KEY,
	memberTypeID INT FOREIGN KEY REFERENCES MemberType(memberTypeID), -- I.E. Client, Physician, Referral Source, Family, etc.
	familyTypeID INT FOREIGN KEY REFERENCES FamilyMemberType(familyTypeID), -- I.E. Parent, Sibling, Legal Guardian, etc.
	raceID INT FOREIGN KEY REFERENCES Race(raceID),
	firstName VARCHAR(25),
	lastName VARCHAR(25),
	isGuardian BIT,
	dob INT,
	occupation VARCHAR(25),
	employer VARCHAR(25),
)

CREATE TABLE FamilyMemberType (
	familyTypeID INT IDENTITY (1,1) NOT NULL PRIMARY KEY,
	familyType VARCHAR(25), -- Legal Guardian, Parent, Sibling
)

--Main table: Staff.
CREATE TABLE Staff (
	staffID INT IDENTITY (1,1) NOT NULL PRIMARY KEY,
	staffTypeID INT FOREIGN KEY REFERENCES StaffType(staffTypeID),
	memberAddressID INT FOREIGN KEY REFERENCES MemberAddress(memberAddressID),
	additionalContactInfoID INT FOREIGN KEY REFERENCES AdditionalContactInfo(additionalContactInfoID),
	firstName VARCHAR(25),
	lastName VARCHAR(25),
)

CREATE TABLE StaffType (
	staffTypeID INT IDENTITY (1,1) NOT NULL PRIMARY KEY,
	staffType VARCHAR(25), -- Service Coordinator, Interpreter, PT, ST, OT,	NUT
)

--Main table: Holds all addresses on the database for any type. 
CREATE TABLE MemberAddress (
	memberAddressID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	organizationName VARCHAR(25),
	address1 VARCHAR(50),
	address2 VARCHAR(25),
	city VARCHAR(25),
	st VARCHAR(2),
	zip INT,
	county VARCHAR(25),
	mapsco VARCHAR(10),
)

--Main table: phone, email, twitter, etc...
CREATE TABLE AdditionalContactInfo (
	additionalContactInfoID INT IDENTITY (1,1) NOT NULL PRIMARY KEY,
	memberID INT, --Can be any table id, clientID, staffID, referralSourceID, etc. ??? Since this references may tables, how do we indicate it as a foreign key?
	memberTypeID INT FOREIGN KEY REFERENCES MemberType(memberTypeID),
	additionalContactInfo VARCHAR(255),
)

--Reference table.
CREATE TABLE MemberType (
	memberTypeID INT IDENTITY (1,1) NOT NULL PRIMARY KEY,
	memberType VARCHAR(25),	-- Client, physician, referralsource, family member, staff.
)

CREATE TABLE Race (
	raceID INT IDENTITY (1,1) NOT NULL PRIMARY KEY,
	race VARCHAR(25),
)

CREATE TABLE Ethnicity (
	ethnicityID INT IDENTITY (1,1) NOT NULL PRIMARY KEY,
	ethnicity VARCHAR(25),
)

CREATE TABLE ClientStatus (
	clientStatusID INT IDENTITY (1,1) NOT NULL PRIMARY KEY,
	clientStatus VARCHAR(25), -- Active, Inactive
	initialDate INT,
	dismissedDate INT,
	dismissalReason VARCHAR(100), --- Declined Services, Moved, Could not contact, Deceased, Other -- Do we want this to be it's own table with a foreign key here?
)

CREATE TABLE Physician (
	physicianID INT IDENTITY (1,1) NOT NULL PRIMARY KEY,
	memberAddressID INT FOREIGN KEY REFERENCES MemberAddress(MemberAddressID),
	memberTypeID INT FOREIGN KEY REFERENCES MemberType(memberTypeID),
	additionalContactInfoID	INT FOREIGN KEY REFERENCES AdditionalContactInfo(additionalContactInfoID),
	firstName VARCHAR(25),
	lastName VARCHAR(25),
	physicianNPI INT,
	physicianType VARCHAR(25),
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
	commentsID INT FOREIGN KEY REFERENCES Comments(commentsID),
	referralDate INT,
)

-- This table links Clients and Staff togther.
CREATE TABLE ClientStaff (
	clientID INT,
	staffID INT,
	PRIMARY KEY (clientID, staffID),
)

CREATE TABLE Insurance (
	insuranceID INT IDENTITY (1,1) NOT NULL PRIMARY KEY,
	memberAddressID INT FOREIGN KEY REFERENCES MemberAddress(memberAddressID),
	additionalContactInfoID INT FOREIGN KEY REFERENCES AdditionalContactInfo(additionalContactInfoID),
	insuranceName VARCHAR(75),
)

CREATE TABLE InsuranceAuthorization (
	insuranceAuthID INT IDENTITY (1,1) PRIMARY KEY NOT NULL,
	clientID INT FOREIGN KEY REFERENCES Clients(clientID),
	insuranceAuthTypeID INT FOREIGN KEY REFERENCES InsuranceAuthorizationType(insuraneAuthTypeID),
	authorizationNumber INT,
	authorizedFrom INT,
	authorizedTo INT,
	)

CREATE TABLE SchoolInformation (
	schoolInfoID INT IDENTITY (1,1) NOT NULL PRIMARY KEY,
	clientID INT FOREIGN KEY REFERENCES Clients(clientID),
	isd int,
	)

CREATE TABLE Diagnosis (
	diagnosisID INT IDENTITY (1,1) NOT NULL PRIMARY KEY,
	clientID INT FOREIGN KEY REFERENCES Clients(clientID),
	diagnosisTypeID INT FOREIGN KEY REFERENCES DiagnosisType(diagnosisTypeID),
	icd10 VARCHAR(15),
)

CREATE TABLE DiagnosisType (
	diagnosisTypeID INT IDENTITY (1,1) NOT NULL PRIMARY KEY,
	isPrimary BIT,
	diagnosisType VARCHAR(25), -- Primary, secondary, tertiary, inactive, active
	)

CREATE TABLE Comments (
	commentsID INT IDENTITY (1,1) NOT NULL PRIMARY KEY,
	comments varchar(250),
	)