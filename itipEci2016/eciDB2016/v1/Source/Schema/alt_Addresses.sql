﻿/***********************************************************************************************************
Description: 
		Alters Addresses table to add MAPSCO column.
Author: 
	Jennifer M. Graves
Date: 
	06-22-2016
Change History:
		
************************************************************************************************************/

-- Declares table variable for addresses table
DECLARE @addresses INT = 0



-- Assigns table ID to addresses variable.
SELECT @addresses = (
	SELECT OBJECT_ID
	FROM Sys.Tables
	WHERE name = 'Addresses'
)

SELECT @addresses

-- Checks if table exists, create table if it doesn't.
IF @addresses = 0
	BEGIN
		CREATE TABLE Addresses (
			addressesID INT IDENTITY(1,1) PRIMARY KEY (addressesID) NOT NULL,
			addressesTypeID INT FOREIGN KEY REFERENCES AddressesType(addressesTypeID),
			address1 VARCHAR(50),
			address2 VARCHAR(25),
			city VARCHAR(25), 
			st NVARCHAR(2),
			zip INT,
			mapsco VARCHAR(25)
		)
	END
ELSE
	BEGIN
		-- Checks if mapsco column exists, alters table to add if it doesn't.
		IF EXISTS (SELECT * FROM sys.columns WHERE @addresses = OBJECT_ID AND name = 'mapsco')
			BEGIN
				RETURN
			END
		ELSE
			BEGIN
				ALTER TABLE Addresses
					ADD mapsco VARCHAR(25)
			END
	END