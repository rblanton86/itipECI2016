/***********************************************************************************************************
Description: 
		Alters additionalContactInfo column on FamilyMember table to additionalContactInfoID
Author: 
		Jennifer M. Graves
Date: 
		06-23-2016
Change History:
		06-30-2016 -- jmg: Corrected if statement
		07-05-2016 -- jmg: Added deleted column.
************************************************************************************************************/
	
-- Declares table variable for aci table
DECLARE @fm INT = 0
DECLARE @fkn NVARCHAR(50)
DECLARE @databaseName NVARCHAR(50) -- Variable to hold your database's name
DECLARE @dtscript NVARCHAR(255) -- Variable to hold the script, which we will build later, and which drops all constraints for the table you are dropping
    
SET @databaseName = 'eciDB2016'

-- Assigns table ID to aci variable.
SELECT @fm = (
	SELECT OBJECT_ID
	FROM Sys.Tables
	WHERE name = 'FamilyMember'
)

-- Assigns a foreign key name for use in later script which will drop the foreign key constraint
SELECT @fkn = (
    SELECT name
    FROM sys.foreign_keys
    WHERE referenced_object_id = object_id('AdditionalContactInfo') AND parent_object_id = object_id('FamilyMember')
)


SELECT @fm

-- Checks if additional contact info table exists, creates if it doesn't..
IF ISNULL(@fm, 0) = 0
	BEGIN
		CREATE TABLE FamilyMember (
			familyMemberID INT IDENTITY (1,1) PRIMARY KEY,
			familyMemberTypeID INT FOREIGN KEY REFERENCES FamilyMemberType(familyMemberTypeID),
			additionalContactInfoID INT FOREIGN KEY REFERENCES AdditionalContactInfo(additionalContactInfoID),
			sexID INT FOREIGN KEY REFERENCES Sex(sexID),
			firstName VARCHAR(25),
			lastName VARCHAR(25),
			isGuardian BIT,
			deleted BIT
		)
	END
ELSE
	BEGIN
		-- Checks if additionalContactInfoID column exists, alters table to add if it doesn't.
		IF EXISTS (SELECT * FROM sys.columns WHERE @fm = OBJECT_ID AND name = 'additionalContactInfoID')
			BEGIN
				PRINT 'Unneeded: additionalContactInfoID already exists.'
			END
		ELSE
			BEGIN
				ALTER TABLE FamilyMember
					ADD additionalContactInfoID INT FOREIGN KEY REFERENCES AdditionalContactInfo(additionalContactInfoID)
			END
				
		-- Checks if additionalContactInfo column exists, removes it if it does after copying table data over.
		IF EXISTS (SELECT * FROM sys.columns WHERE @fm = OBJECT_ID AND name = 'additionalContactInfo')
			BEGIN
				DECLARE @some NVARCHAR(100) = 'UPDATE FamilyMember SET additionalContactInfoID = additionalContactInfo'
				EXEC sp_executesql @some
				
				WHILE EXISTS(select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where constraint_catalog = @databaseName and table_name = 'FamilyMember')
					BEGIN
						SELECT @dtscript = (
						  'ALTER TABLE FamiyMember' + 
						  ' DROP CONSTRAINT ' + 
						  @fkn
						  )
						FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS 
						WHERE constraint_catalog = @databaseName and table_name = 'FamilyMember'
						exec sp_executesql @dtscript
					END

				ALTER TABLE FamilyMember
					DROP COLUMN additionalContactInfo
			END
		ELSE
			BEGIN
				PRINT 'Unneeded: ContactInfoID exists and ContactInfo does not, no update needed.'
			END

		IF EXISTS (SELECT * FROM sys.columns WHERE @fm = OBJECT_ID AND name = 'sexID')
			BEGIN
				PRINT 'Unneeded: sexID already exists.'
			END
		ELSE
			BEGIN
				ALTER TABLE FamilyMember
					ADD sexID INT FOREIGN KEY REFERENCES Sex(sexID)
			END

		IF EXISTS (SELECT * FROM sys.columns WHERE @fm = OBJECT_ID AND name = 'deleted')
			BEGIN
				PRINT 'Unneeded, deleted column exists.'
			END
		ELSE
			BEGIN
				ALTER TABLE FamilyMember
					ADD deleted BIT
				PRINT 'Added deleted column on FamilyMember table.'
			END
	END