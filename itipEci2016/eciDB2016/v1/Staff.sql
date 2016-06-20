/************************************************
Description: 
	Creates main Staff table that holds staff information,
	creates StaffType table that holds staff role type,
	creates linking table that links Clients table to Staff table.
Author: 
	Jennifer M. Graves
Date: 
	06/20/2016
Change history:

**************************************************/

CREATE TABLE Staff (
	staffID INT IDENTITY (1,1) PRIMARY KEY (staffID),
	staffTypeID INT FOREIGN KEY REFERENCES StaffType(staffTypeID),
	addressesID INT FOREIGN KEY REFERENCES Addresses(addressesID),
	additionalContactInfoID INT FOREIGN KEY REFERENCES AdditionalContactInfo(additionalContactInfoID),
	firstName VARCHAR(25),
	lastNAME VARCHAR(25),
)

CREATE TABLE StaffType (
	staffTypeID INT IDENTITY (1,1) PRIMARY KEY (staffTypeID),
	staffType VARCHAR(25),
)

CREATE TABLE ClientStaff (
	clientID INT FOREIGN KEY REFERENCES Clients(clientID), 
	staffID INT FOREIGN KEY REFERENCES Staff(staffID),
	PRIMARY KEY (clientID, staffID),
)