--Main Table: Holds the insurance name of the client
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