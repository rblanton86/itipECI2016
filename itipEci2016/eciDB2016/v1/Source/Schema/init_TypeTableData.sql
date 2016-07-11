/****************************************************************************
Description: Initiates default values for the 'type' tables, such as sex, ethnicity, race, etc.

Author: Jennifer M Graves

Date: 07/11/2010

Change History:
	TODO: Complete this data entry.
****************************************************************************/

-- Checks where type rows already exists.
IF EXISTS (SELECT additionalContactInfoType FROM AdditionalContactInfoType WHERE additionalContactInfoType LIKE 'Email' AND additionalContactInfoTypeID LIKE 1)
	BEGIN
		-- Notifies DBA if no additions are made. Pulls up whole table for visual verification.
		PRINT 'No changes made to AdditionalContactInfoType table, types already present.'
		SELECT * FROM AdditionalContactInfoType
	END
ELSE
	BEGIN
		-- Deletes any previously made additions in order to reset table.
		DELETE FROM AdditionalContactInfoType

		-- Turns on identity insert.
		SET IDENTITY_INSERT AdditionalContactInfoType ON

		-- Adds base contact info types to database table.
		INSERT INTO AdditionalContactInfoType (additionalContactInfoTypeID, additionalContactInfoType)
			VALUES (1, 'Email'), (2, 'Home Phone'), (3, 'Mobile Phone'), (4, 'Work Phone'), (5, 'Business Phone'), (6, 'Fax'), (7, 'Other')

		-- Turns off identity insert, as can only be on on one table at a time.
		SET IDENTITY_INSERT AdditionalContactInfoType ON

		-- Notifies DBA of changes made and pulls up table for visual verification.
		PRINT 'Additional Contact Info Types added'
		SELECT * FROM AdditionalContactInfoType
	END

IF EXISTS (SELECT addressesType FROM AddressesType WHERE addressesType LIKE 'Home' AND addressesTypeID LIKE 1)
	BEGIN
		-- Notifies DBA that no changes were made and selects table for DBA's visual verification.
		PRINT 'No changes made to Address Type table, types already present.'
		SELECT * FROM AddressesType
	END
ELSE
	BEGIN
		-- Deletes any previously made additions in order to reset table.
		DELETE FROM AddressesType

		-- Adds base contact info types to database table.
		INSERT INTO AddressesType (addressesType)
			VALUES ('Street Address'), ('Mailing Address'), ('Business Address'), ('Other')

		-- Notifies DBA of changes made and pulls up table for visual verification.
		PRINT 'Additional Contact Info Types added'
		SELECT * FROM AddressesType
	END

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