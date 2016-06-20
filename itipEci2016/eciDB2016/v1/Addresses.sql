/***********************************************************************************************************
Description: 
	 Creates Address tables that holds addresses and address type 
Author: 
	Tyrell Powers-Crane
Date: 
	6.20.2016
Change History:
	
************************************************************************************************************/
CREATE TABLE Addresses (
	addressesID INT IDENTITY(1,1) PRIMARY KEY (addressesID),
	addressesTypeID INT FOREIGN KEY REFERENCES AddressType(addressesTypeID),
	address1 VARCHAR(50),
	address2 VARCHAR(25),
	city VARCHAR(25), 
	st NVARCHAR(2),
	zip INT,
)
--Type Table: Provides description of address table
CREATE TABLE AddressesType (
	addressesTypeID INT IDENTITY (1,1) PRIMARY KEY (addressesTypeID),
	addressesType VARCHAR(25)
	)