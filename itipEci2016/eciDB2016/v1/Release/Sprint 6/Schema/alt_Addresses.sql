/***********************************************************************************************************
Description: 
		Alters Addresses table to add MAPSCO column.
Author: 
	Jennifer M. Graves
Date: 
	06-22-2016
Change History:
	06-30-2016 -jmg: Corrected if statement
	07-05-2016 -jmg: added deleted column
	08-09-2016 -jmg: added county column
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
IF ISNULL(@addresses, 0) = 0
	BEGIN
		CREATE TABLE Addresses (
			addressesID INT IDENTITY(1,1) PRIMARY KEY (addressesID) NOT NULL,
			addressesTypeID INT FOREIGN KEY REFERENCES AddressesType(addressesTypeID),
			address1 VARCHAR(50),
			address2 VARCHAR(25),
			city VARCHAR(25), 
			st NVARCHAR(2),
			zip INT,
			mapsco VARCHAR(25),
			county VARCHAR(25),
			updDate DATETIME DEFAULT (GETDATE()),
			deleted BIT
		)
	END
ELSE
	BEGIN
		-- Checks if mapsco column exists, alters table to add if it doesn't.
		IF EXISTS (SELECT * FROM sys.columns WHERE @addresses = OBJECT_ID AND name = 'mapsco')
			BEGIN
				PRINT 'Unneeded, mapsco column exists.'
			END
		ELSE
			BEGIN
				ALTER TABLE Addresses
					ADD mapsco VARCHAR(25)
			END

		IF EXISTS (SELECT * FROM sys.columns WHERE @addresses = OBJECT_ID AND name = 'deleted')
			BEGIN
				PRINT 'Unneeded, deleted column exists.'
			END
		ELSE
			BEGIN
				ALTER TABLE Addresses
					ADD deleted BIT
				PRINT 'Added deleted column on Addresses table.'
			END

		IF EXISTS (SELECT * FROM sys.columns WHERE @addresses = OBJECT_ID AND name = 'county')
			BEGIN
				PRINT 'Unneeded, county column exists.'
			END
		ELSE
			BEGIN
				ALTER TABLE Addresses
					ADD county VARCHAR(25)
			END

		IF EXISTS (SELECT * FROM sys.columns WHERE @addresses = OBJECT_ID AND name ='updDate')
			BEGIN
				ALTER TABLE Addresses ADD CONSTRAINT
				DF_MyTable_Inserted DEFAULT GETDATE() FOR updDate
				PRINT 'Altered updDate column: Added Constraint'
			END
		ELSE
			BEGIN
				ALTER TABLE Addresses
					ADD updDate DATETIME DEFAULT (GETDATE()) 
				PRINT 'Added updDate column to table.'
			END
	END