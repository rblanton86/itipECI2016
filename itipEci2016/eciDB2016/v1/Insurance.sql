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

**************************************************/

CREATE TABLE Insurance (
	insuranceID INT IDENTITY (1,1) PRIMARY KEY (insuranceID),
	insuranceName VARCHAR(75),
	insurancePolicyID VARCHAR(75),
	medPreAuthNumber VARCHAR(100),
	)
--Link Table: Links Insurance and Client tables together
CREATE TABLE LnkClientInsurance ( 
	insuranceID INT,
	clientID INT,
	PRIMARY KEY (insuranceID, clientID)
	)
--Type Table: Provides authorization information for clients insurance
CREATE TABLE InsuranceAuthorization (
	insuranceAuthID INT IDENTITY (1,1) PRIMARY KEY (insuranceAuthID),
	insuranceID INT FOREIGN KEY REFERENCES Insurance(insuranceID),
	authorized_From INT,
	authorized_To INT,
	insuranceAuthorizationType VARCHAR (25)
	)