/****************************************************************************
Description: Initiates default values for the 'type' tables, such as sex, ethnicity, race, etc.

Author: Jennifer M Graves

Date: 07/12/2010

Change History:
	07-13-2016: JMG - Added MemberType values.
	07-21-2016: JMG - Added CommunicationPreferences and School Information values.
****************************************************************************/
IF EXISTS(SELECT * FROM CommunicationPreferences)
	BEGIN
		PRINT 'Did Not create office types, already exist.'
	END
ELSE
	BEGIN
		DELETE FROM DiagnosisType
		DECLARE @m VARCHAR(MAX)
		SELECT @m =
			'SET IDENTITY_INSERT CommunicationPreferences ON;
			INSERT INTO CommunicationPreferences(communicationPreferencesID, communicationPreferences)
				VALUES (1, ''Home Phone''),
					(2, ''Mobile Phone''),
					(3, ''Work Phone''),
					(4, ''Email''),
					(5, ''Mail'')
			SET IDENTITY_INSERT CommunicationPreferences OFF;'
		EXEC(@m)
		PRINT 'CommunicationPreferences table values added.'
		SELECT * FROM CommunicationPreferences
	END

IF EXISTS(SELECT * FROM SchoolInformation)
	BEGIN
		PRINT 'Did Not create office types, already exist.'
	END
ELSE
	BEGIN
		DELETE FROM DiagnosisType
		DECLARE @n VARCHAR(MAX)
		SELECT @n =
			'SET IDENTITY_INSERT SchoolInformation ON;
			INSERT INTO SchoolInformation(schoolInfoID, isd)
				VALUES (1, ''Unknown'')
			SET IDENTITY_INSERT SchoolInformation OFF;'
		EXEC(@n)
		PRINT 'SchoolInformation table values added.'
		SELECT * FROM SchoolInformation
	END

IF EXISTS(SELECT * FROM Office)
	BEGIN
		PRINT 'Did Not create office types, already exist.'
	END
ELSE
	BEGIN
		DELETE FROM DiagnosisType
		DECLARE @o VARCHAR(MAX)
		SELECT @o =
			'SET IDENTITY_INSERT Office ON;
			INSERT INTO Office(officeID, officeName)
				VALUES (1, ''Main'')
			SET IDENTITY_INSERT Office OFF;'
		EXEC(@o)
		PRINT 'Office table values added.'
		SELECT * FROM Office
	END

DELETE FROM DiagnosisType
DECLARE @p VARCHAR(MAX)
SELECT @p =
	'SET IDENTITY_INSERT DiagnosisType ON;
	INSERT INTO DiagnosisType(diagnosisTypeID, diagnosisType)
		VALUES (1, ''ICD-10''),
			(2, ''ICD-09'');
	SET IDENTITY_INSERT DiagnosisType OFF;'
EXEC(@p)
PRINT 'DiagnosisType table values added.'
SELECT * FROM DiagnosisType

DELETE FROM MemberType
DECLARE @q VARCHAR(MAX)
SELECT @q =
	'SET IDENTITY_INSERT MemberType ON;
	INSERT INTO MemberType(memberTypeID, memberType)
		VALUES (1, ''Client''),
			(2, ''Family''),
			(3, ''Staff''),
			(4, ''Physician''),
			(5, ''Referral Source''),
			(6, ''Insurance''),
			(7, ''InsuranceType'');
	SET IDENTITY_INSERT MemberType OFF;'
EXEC(@q)
PRINT 'MemberType table values added.'
SELECT * FROM MemberType

DELETE FROM Sex
DECLARE @r VARCHAR(MAX)
SELECT @r =
	'SET IDENTITY_INSERT Sex ON;
	INSERT INTO Sex(sexID, sex)
		VALUES (1, ''Male''),
			(2, ''Female''),
			(3, ''Other'');
	SET IDENTITY_INSERT Sex OFF;'
EXEC(@r)
PRINT 'Sex table values added.'
SELECT * FROM Sex


DELETE FROM StaffType
DECLARE @s VARCHAR(MAX)
SELECT @s =
	'SET IDENTITY_INSERT StaffType ON;
	INSERT INTO StaffType(staffTypeID, staffType)
		VALUES (1, ''Caseworker''),
			(2, ''Physical Therapist''),
			(3, ''Speech Therapist''),
			(4, ''Occupational Therapist'');
	SET IDENTITY_INSERT StaffType OFF;'
EXEC(@s)
PRINT 'StaffType table values added.'
SELECT * FROM StaffType


DELETE FROM FamilyMemberType
DECLARE @t VARCHAR(MAX)
SELECT @t =
	'SET IDENTITY_INSERT FamilyMemberType ON;
	INSERT INTO FamilyMemberType(familyMemberTypeID, familyMemberType)
		VALUES (1, ''Mother''),
			(2, ''Father''),
			(3, ''Grandparent''),
			(4, ''Sibling''),
			(5, ''Uncle''),
			(6, ''Aunt''),
			(7, ''Other Family''),
			(8, ''Other/Legally Appointed'');
	SET IDENTITY_INSERT FamilyMemberType OFF;'
EXEC(@t)
PRINT 'FamilyMemberType table values added.'
SELECT * FROM FamilyMemberType


DELETE FROM ClientStatus
DECLARE @u VARCHAR(MAX)
SELECT @u =
	'SET IDENTITY_INSERT ClientStatus ON;
	INSERT INTO ClientStatus(clientStatusID, clientStatus)
		VALUES (1, ''Active''),
			(2, ''Inactive'');
	SET IDENTITY_INSERT ClientStatus OFF;'
EXEC(@u)
PRINT 'ClientStatus table values added.'
SELECT * FROM ClientStatus


DELETE FROM AdditionalContactInfoType
DECLARE @v VARCHAR(MAX)
SELECT @v =
	'SET IDENTITY_INSERT AdditionalContactInfoType ON;
	INSERT INTO AdditionalContactInfoType (additionalContactInfoTypeID, additionalContactInfoType)
		VALUES (1, ''Email''),
			(2, ''Home Phone''),
			(3, ''Mobile Phone''),
			(4, ''Work Phone''),
			(5, ''Business Phone''),
			(6, ''Fax''),
			(7, ''Other'');
	SET IDENTITY_INSERT AdditionalContactInfoType OFF;'
EXEC(@v)
PRINT 'Additional Contact Info Types added'
SELECT * FROM AdditionalContactInfoType


DELETE FROM AddressesType
DECLARE @w VARCHAR(MAX)
SELECT @w =
	'SET IDENTITY_INSERT AddressesType ON;
	INSERT INTO AddressesType (addressesTypeID, addressesType)
		VALUES (1, ''Street Address''),
			(2, ''Mailing Address''),
			(3, ''Business Address''),
			(4, ''Other'');
	SET IDENTITY_INSERT AddressesType OFF;'
EXEC(@w)
PRINT 'Addresses Types added'
SELECT * FROM AddressesType


DELETE FROM Ethnicity
DECLARE @x VARCHAR(MAX)
SELECT @x =
	'SET IDENTITY_INSERT Ethnicity ON;
	INSERT INTO Ethnicity(ethnicityID, ethnicity)
		VALUES (1, ''Hispanic''),
			(2, ''Non-Hispanic'');
	SET IDENTITY_INSERT Ethnicity OFF;'
EXEC(@x)
PRINT 'Ethnicity values added'
SELECT * FROM Ethnicity


DELETE FROM Race
DECLARE @y VARCHAR(MAX)
SELECT @y =
	'SET IDENTITY_INSERT Race ON;
	INSERT INTO Race(raceID, race)
		VALUES (1, ''African American''),
			(2, ''Asian''),
			(3, ''Hawaiian/Pacific Islander''),
			(4, ''Hispanic/Latino''),
			(5, ''White'');
	SET IDENTITY_INSERT Race OFF;'
EXEC(@y)
PRINT 'Race table values added.'
SELECT * FROM Race


DELETE FROM PrimaryLanguage
DECLARE @z VARCHAR(MAX)
SELECT @z =
	'SET IDENTITY_INSERT PrimaryLanguage ON;
	INSERT INTO PrimaryLanguage(primaryLanguageID, primaryLanguage)
		VALUES (1, ''English''),
			(2, ''Spanish''),
			(3, ''Cantonese''),
			(4, ''Mandarin''),
			(5, ''French''),
			(6, ''Tagalog''),
			(7, ''Vietnamese''),
			(8, ''Korean''),
			(9, ''German''),
			(10, ''Arabic''),
			(11, ''Russian''),
			(12, ''Indic/Indian''),
			(13, ''Italian''),
			(14, ''Portugese''),
			(15, ''Hindi''),
			(16, ''Polish''),
			(17, ''Japanese''),
			(18, ''Persian''),
			(19, ''Urdu''),
			(20, ''Gujarati''),
			(21, ''Greek''),
			(22, ''Serbo-Croatian''),
			(23, ''Armenian''),
			(24, ''Hebrew''),
			(25, ''Khmer''),
			(26, ''Hmong''),
			(27, ''Navajo''),
			(28, ''Thai''),
			(29, ''Yiddish''),
			(30, ''Laotian''),
			(31, ''Tamil''),
			(32, ''ASL'');
		SET IDENTITY_INSERT PrimaryLanguage OFF;'
EXEC(@z)
PRINT 'PrimaryLanguage table values added.'
SELECT * FROM PrimaryLanguage