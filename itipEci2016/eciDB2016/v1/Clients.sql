--Main Table: Holds Patient information
CREATE TABLE Clients ( 
	clientID INT IDENTITY (1,1) PRIMARY KEY (clientID),
	raceID INT FOREIGN KEY REFERENCES Race(raceID),
	ethnicityID INT FOREIGN KEY REFERENCES Ethnicity(ethnicityID),
	clientStatusID INT FOREIGN KEY REFERENCES ClientStatus(clientStatusID),
	familyID INT FOREIGN KEY REFERENCES FamilyMember(familyID),
	referralSourceID INT FOREIGN KEY REFERENCES ReferralSource(referralSourcID),
	physicianID INT FOREIGN KEY REFERENCES Physician(physicianID),
	staffID INT FOREIGN KEY REFERENCES Staff(staffID),
	memberAddressID INT FOREIGN KEY REFERENCES Addresses(addressesID),
	additionalContactInfoID INT FOREIGN KEY REFERENCES AdditionalContactInfo(additionalContactInfoID),
	insuranceID INT FOREIGN KEY REFERENCES Insurance(insuranceID),
	firstName VARCHAR(25),
	lastName VARCHAR(25),
	dob INT,
	ssn INT,
	referralSource VARCHAR(50),
)
--identifies race of patient
CREATE TABLE Race (
	raceID INT IDENTITY (1,1),
	race VARCHAR(25),
)
--identifies ethnicity of patient
CREATE TABLE Ethnicity (
	ethnicityID INT IDENTITY (1,1),
	ethnicity VARCHAR(25),
)
-- provides information regarding patient status
CREATE TABLE ClientStatus (
	clientStatusID INT IDENTITY (1,1),
	clientStatus VARCHAR(25),
	initialDate INT,
	dismissedDate INT,
	dismissalReason VARCHAR(100),
)

