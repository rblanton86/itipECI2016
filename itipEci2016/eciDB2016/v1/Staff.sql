--Main table: Holds the name of staff members in relation to the patient.
CREATE TABLE Staff (
	staffID INT IDENTITY (1,1) PRIMARY KEY (staffID),
	staffTypeID INT FOREIGN KEY REFERENCES StaffType(staffTypeID),
	addressesID INT FOREIGN KEY REFERENCES Addresses(addressesID),
	additionalContactInfoID INT FOREIGN KEY REFERENCES AdditionalContactInfo(additionalContactInfoID),
	firstName VARCHAR(25),
	lastNAME VARCHAR(25),
)
--Type Table: Provides information about the staffs relation to the patient 
CREATE TABLE StaffType (
	staffTypeID INT IDENTITY (1,1) PRIMARY KEY (staffTypeID),
	staffType VARCHAR(25),
)

-- This table links Clients and Staff togther.
CREATE TABLE ClientStaff (
	clientID INT FOREIGN KEY REFERENCES Clients(clientID), 
	staffID INT FOREIGN KEY REFERENCES Staff(staffID),
	PRIMARY KEY (clientID, staffID),
)
