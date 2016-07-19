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
		07-12-2016 -- jmg: Added race, occupation, employer columns. Also added DOB column for family member: sibling type.
			Edited script so foreign key dropped appropriately.
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


-- Declares and obtains the column id number for later query to assign foreign key name
DECLARE @col INT = 0
SELECT @col = (
	SELECT column_id
	FROM Sys.Columns AS c
	JOIN Sys.Tables AS t
	ON c.object_id = t.object_id
	WHERE t.object_id = object_id('FamilyMember') AND c.name = 'AdditionalContactInfo'
	)

-- Assigns a foreign key name for use in later script which will drop the foreign key constraint
SELECT @fkn = (
	SELECT f.name
	FROM sys.foreign_keys AS f
	INNER JOIN
		sys.foreign_key_columns AS k
			ON f.object_id = k.constraint_object_id
	INNER JOIN
		sys.tables AS t
			ON t.object_id = k.referenced_object_id
	WHERE k.parent_object_id = object_id('FamilyMember') AND k.parent_column_id = @col
	)

SELECT @fm

-- Checks if additional contact info table exists, creates if it doesn't..
IF ISNULL(@fm, 0) = 0
	BEGIN
		CREATE TABLE FamilyMember (
			familyMemberID INT IDENTITY (1,1) PRIMARY KEY,
			familyMemberTypeID INT CONSTRAINT FK_family_memberType FOREIGN KEY REFERENCES FamilyMemberType(familyMemberTypeID),
			additionalContactInfoID INT CONSTRAINT FK_family_contactInfo FOREIGN KEY REFERENCES AdditionalContactInfo(additionalContactInfoID),
			raceID INT CONSTRAINT FK_family_race FOREIGN KEY REFERENCES Race(raceID),
			sexID INT FOREIGN KEY REFERENCES Sex(sexID),
			firstName VARCHAR(25),
			lastName VARCHAR(25),
			isGuardian BIT,
			occupation VARCHAR(25),
			employer VARCHAR(25),
			dob DATE,
			updDate DATETIME DEFAULT (GETDATE()),
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
				
				WHILE EXISTS(select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where constraint_name = @fkn)
					BEGIN
						SELECT @dtscript = (
							'ALTER TABLE FamilyMember' + 
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

		IF EXISTS (SELECT * FROM sys.columns WHERE @fm = OBJECT_ID AND name ='memberTypeID')
			BEGIN
				PRINT 'memberTypeID already exists'
			END
		ELSE
			BEGIN
				ALTER TABLE FamilyMember
					ADD memberTypeID INT FOREIGN KEY REFERENCES MemberType(memberTypeID)
				PRINT 'Added memberTypeID column to table.'
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

		IF EXISTS (SELECT * FROM sys.columns WHERE @fm = OBJECT_ID AND name = 'raceID')
			BEGIN
				PRINT 'Unneeded, raceID column exists.'
			END
		ELSE
			BEGIN
				ALTER TABLE FamilyMember
					ADD raceID INT CONSTRAINT FK_family_race FOREIGN KEY REFERENCES Race(raceID)
				PRINT 'RaceID column added to FamilyMember table.'
			END

		IF EXISTS (SELECT * FROM sys.columns WHERE @fm = OBJECT_ID AND name = 'occupation')
			BEGIN
				PRINT 'Unneeded, occupation column exists.'
			END
		ELSE
			BEGIN
				ALTER TABLE FamilyMember
					ADD occupation VARCHAR(25)
				PRINT 'Occupation column added to FamilyMember table.'
			END

		IF EXISTS (SELECT * FROM sys.columns WHERE @fm = OBJECT_ID AND name = 'employer')
			BEGIN
				PRINT 'Unneeded, employer column exists.'
			END
		ELSE
			BEGIN
				ALTER TABLE FamilyMember
					ADD employer VARCHAR(25)
				PRINT 'Employer column added to FamilyMember table.'
			END

		IF EXISTS (SELECT * FROM sys.columns WHERE @fm = OBJECT_ID AND name = 'dob')
			BEGIN
				PRINT 'Unneeded, dob column exists.'
			END
		ELSE
			BEGIN
				ALTER TABLE FamilyMember
					ADD dob DATE
				PRINT 'DOB column added to FamilyMember table.'
			END

		IF EXISTS (SELECT * FROM sys.columns WHERE @fm = OBJECT_ID AND name ='updDate')
			BEGIN
				ALTER TABLE FamilyMember ADD CONSTRAINT
				DF_MyTable_Inserted DEFAULT GETDATE() FOR updDate
				PRINT 'Altered updDate column: Added Constraint'
			END
		ELSE
			BEGIN
				ALTER TABLE FamilyMember
					ADD updDate DATETIME DEFAULT (GETDATE())
				PRINT 'Added updDate column to table.'
			END
	END