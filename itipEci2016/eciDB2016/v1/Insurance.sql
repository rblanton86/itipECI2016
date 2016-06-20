/************************************************
Description: 
	Creates a table to hold insurance information, as well
	as additional tables including authorizations and
	linking this information to other tables within the schema.
Author: 
	Jennifer M. Graves
Date: 
	06/20/2016
Change history:
	06.20.16 - tpc- Removed InsuranceAuthorization table and removed foreign keys to Insurance Table
**************************************************/

CREATE TABLE Insurance (
	insuranceID INT IDENTITY (1,1) PRIMARY KEY (insuranceID),
	insuranceName VARCHAR(75),
	insurancePolicyID VARCHAR(75),
	medPreAuthNumber VARCHAR(100),
	)
--Link Table: Links Insurance and Client tables together
CREATE TABLE LnkClientInsurance ( 
	insuranceID INT FOREIGN KEY REFERENCES Insurance(insuranceID),
	clientID INT FOREIGN KEY REFERENCES Clients(clientID),
	PRIMARY KEY (insuranceID, clientID)
	)
