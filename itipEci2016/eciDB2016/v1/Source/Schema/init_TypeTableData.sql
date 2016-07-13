/****************************************************************************
Description: Initiates default values for the 'type' tables, such as sex, ethnicity, race, etc.

Author: Jennifer M Graves

Date: 07/11/2010

Change History:
	TODO: Complete this data entry.
****************************************************************************/

DELETE FROM AdditionalContactInfoType
DECLARE @v VARCHAR(MAX)
SELECT @v =
'SET IDENTITY_INSERT AdditionalContactInfoType ON;
INSERT INTO AdditionalContactInfoType (additionalContactInfoTypeID, additionalContactInfoType)
	VALUES (1, ''Email''), (2, ''Home Phone''), (3, ''Mobile Phone''), (4, ''Work Phone''), (5, ''Business Phone''), (6, ''Fax''), (7, ''Other'');
SET IDENTITY_INSERT AdditionalContactInfoType OFF;'
EXEC(@v)
PRINT 'Additional Contact Info Types added'
SELECT * FROM AdditionalContactInfoType




-- Deletes any previously made additions in order to reset table.
DELETE FROM AddressesType

-- Turns on identity insert.
-- SET IDENTITY_INSERT AddressesType ON

-- Adds base contact info types to database table.
INSERT INTO AddressesType (addressesType)
	VALUES ('Street Address'), ('Mailing Address'), ('Business Address'), ('Other')

-- Turns off identity insert, as can only be on on one table at a time.
-- SET IDENTITY_INSERT AddressesType OFF

-- Notifies DBA of changes made and pulls up table for visual verification.
PRINT 'Additional Contact Info Types added'
SELECT * FROM AddressesType

IF EXISTS (SELECT ethnicity FROM Ethnicity WHERE ethnicity LIKE 'Hispanic' AND ethnicityID LIKE 1)
	BEGIN
		-- Notifies DBA that no changes were made and selects table for DBA's visual verifiction.
		PRINT 'No changes made to Ethnicity table, ethnicity already present.'
		SELECT * FROM Ethnicity
	END
ELSE
	BEGIN
		-- Deletes any previously made additions in order to reset table.
		DELETE FROM Ethnicity

		-- Adds base contact info types to database table.
		INSERT INTO Ethnicity (ethnicity)
			VALUES ('Hispanic'), ('Non-Hispanic')

		-- Notifies DBA of changes made and pulls up table for visual verification.
		PRINT 'Additional Contact Info Types added'
		SELECT * FROM Ethnicity
	END

IF EXISTS (SELECT race FROM Race WHERE race LIKE 'African American' AND raceID LIKE 1)
	BEGIN
		-- Notifies DBA that no changes were made and selects table for DBA's visual verification
		PRINT 'No changes made to Race table, data already present'
		SELECT * FROM Race
	END
ELSE
	BEGIN
		-- Deletes any previous made additions in order to reset table.
		DELETE FROM Race
		
		-- Adds base contact info types to database table.
		INSERT INTO Race(race)
			VALUES ('African American'), ('Asian'), ('Hawaiian/Pacific Islander'), ('Hispanic/Latino'), ('White')

		-- Notifies DBA of changes made and pulls up table for visual verification.
		PRINT 'Race table types added.'
		SELECT * FROM Race
	END