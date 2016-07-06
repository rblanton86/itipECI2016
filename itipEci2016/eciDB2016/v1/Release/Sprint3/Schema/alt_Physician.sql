/****************************************************************************
Description: Alter Physician table.

Author: Jennifer M Graves

Date: 07-05-2016

Change History:
		07-05-2016 -- jmg: Added deleted bit column to table.
****************************************************************************/

-- Declares the table variable for Physician
DECLARE @md INT = 0

-- Assigns the system table ID to @md variable for later use.
SELECT @md = (
	SELECT OBJECT_ID
	FROM sys.tables
	WHERE name = 'Physician'
)

SELECT @md

-- Checks if table exists.
IF ISNULL(@md, 0) = 0
	BEGIN
		--Creates Physician table if it doesn't exist.
		CREATE TABLE Physician (
			physicianID INT IDENTITY(1,1) PRIMARY KEY(physicianID),
			addressesID INT CONSTRAINT FK_physician_addresses FOREIGN KEY REFERENCES Addresses(addressesID),
			additionalContactInfoID INT CONSTRAINT FK_physician_contactInfo FOREIGN KEY REFERENCES Addresses(additionalContactInfoID),
			title VARCHAR(10),
			firstName VARCHAR(25),
			lastName VARCHAR(25),
			deleted BIT
		)

		PRINT 'Added Physician table to database.'
	END
ELSE
	BEGIN
		-- Checks if deleted column exists.
		IF EXISTS (SELECT * FROM sys.columns WHERE @md = OBJECT_ID AND name = 'deleted')
			BEGIN
				-- Advises DBA no column added, as already exists.
				PRINT 'Unneeded: deleted column exists.'
			END
		ELSE
			BEGIN
				-- Creates column, advises DBA.
				ALTER TABLE Physician
					ADD deleted BIT
				PRINT 'Added deleted column on Physician table.'
			END
	END