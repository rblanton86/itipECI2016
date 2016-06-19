--Main table: Holds all addresses on the database for any type. 
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