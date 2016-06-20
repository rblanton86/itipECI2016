/************************************************
Description: 
	Creates main physicians table and linking tables which
	contain information relating to each physician.
Author: 
	Jennifer M. Graves
Date: 
	06/20/2016
Change history:

**************************************************/

CREATE TABLE Physician (
	physicianID INT IDENTITY (1,1) PRIMARY KEY (physicianID),
	addressesID INT FOREIGN KEY REFERENCES Addresses(addressesID),
	additionalContactInfoID INT FOREIGN KEY REFERENCES AdditionalContactInfo(additionalContactInfoID),
	clientID INT FOREIGN KEY REFERENCES Clients(clientID),
	officeID INT,
)
--Lnk Table: Links Physician and Addresses tables
CREATE TABLE LnkPhysicianAddresses (
	physicianID INT FOREIGN KEY REFERENCES Physician(physicianID),
	addressesID INT FOREIGN KEY REFERENCES Addresses(addressesID),
	PRIMARY KEY (physicianID, addressesID)
	)
--Lnk Table: Links Client and Phys tables
CREATE TABLE ClientPhysician (
	clientID INT,
	physicianID INT,
	PRIMARY KEY (clientID, physicianID),
)