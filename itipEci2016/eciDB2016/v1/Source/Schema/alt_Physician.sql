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
			updDate DATETIME DEFAULT (GETDATE()),
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

		IF EXISTS (SELECT * FROM sys.columns WHERE @md = OBJECT_ID AND name ='memberTypeID')
			BEGIN
				PRINT 'memberTypeID already exists'
			END
		ELSE
			BEGIN
				ALTER TABLE Physician
					ADD memberTypeID INT FOREIGN KEY REFERENCES MemberType(memberTypeID)
				PRINT 'Added memberTypeID column to table.'
			END

		IF EXISTS (SELECT * FROM sys.columns WHERE @md = OBJECT_ID AND name ='updDate')
			BEGIN
				ALTER TABLE Physician ADD CONSTRAINT
				DF_MyTable_Inserted DEFAULT GETDATE() FOR updDate
				PRINT 'Altered updDate column: Added Constraint'
			END
		ELSE
			BEGIN
				ALTER TABLE Physician
					ADD updDate DATETIME DEFAULT (GETDATE())
				PRINT 'Added updDate column to table.'
			END
	END