/***********************************************************************************************************
Description: 
	 Creates all initial tables for the database
Author: 
	Tyrell Powers-Crane , Co-Author: Jennifer Graves
Date: 
	6.20.2016
Change History:
	06-20-2016: JMG - Clarification, edits to tables.
	07-11-2016: JMG - Updates to add tables.
	07-12-2016: JMG - Added diagnosis tables.
	07-13-2016: JMG - Added If/Exists statement and initial table values where needed.
	07-14-2016: JMG - Added CommentsType table and updated Comments, Clients and InsuranceAuth table values.
	08-09-2016: JMG - Added county column to Addresses table. Added LnkAddressMember table. Removed addressesID column from clients table.
************************************************************************************************************/

IF EXISTS (SELECT * FROM sys.tables WHERE name = 'Race')
	BEGIN
		-- Notifies DBA that table has already been created.
		PRINT 'Race table not added: already exists'
	END
ELSE
	BEGIN
		-- Creates table.
		CREATE TABLE Race (
			raceID INT IDENTITY (1,1) PRIMARY KEY,
			race VARCHAR(25) NOT NULL
		)

		-- Stores procedure into string which sets identity column, executes.
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

		-- Notifies DBA of successful table creation.
		PRINT 'Race table initiated with default values.'

		-- Check if identity column is at proper seed, reseeds if not proper.
		IF (SELECT IDENT_CURRENT ('Race')) = 5
			BEGIN
				PRINT 'Identity value not reseeded: set at correct identity value.'
			END
		ELSE
			BEGIN
				DBCC CHECKIDENT ('Race', RESEED, 5)

				PRINT 'Reseeding identity value.'

				DBCC CHECKIDENT ('Race')
			END

		-- Selects table for DBA view to ensure proper table creation.
		SELECT * FROM Race		
	END


IF EXISTS (SELECT * FROM sys.tables WHERE name = 'Ethnicity')
	BEGIN
		-- Notifies DBA that table has already been created.
		PRINT 'Ethnicity table not added: already exists'
	END
ELSE
	BEGIN
		-- Creates table.
		CREATE TABLE Ethnicity (
			ethnicityID INT IDENTITY (1,1) PRIMARY KEY,
			ethnicity VARCHAR(25) NOT NULL
		)

		-- Stores procedure into string which sets identity column, executes.
		DECLARE @x VARCHAR(MAX)
		SELECT @x =
			'SET IDENTITY_INSERT Ethnicity ON;
			INSERT INTO Ethnicity(ethnicityID, ethnicity)
				VALUES (1, ''Hispanic''),
					(2, ''Non-Hispanic'');
			SET IDENTITY_INSERT Ethnicity OFF;'
		EXEC(@x)

		-- Check if identity column is at proper seed, reseeds if not proper.
		IF (SELECT IDENT_CURRENT ('Ethnicity')) = 2
			BEGIN
				PRINT 'Identity value not reseeded: set at correct identity value.'
			END
		ELSE
			BEGIN
				DBCC CHECKIDENT ('Ethnicity', RESEED, 2)

				PRINT 'Reseeding identity value.'

				DBCC CHECKIDENT ('Ethnicity')
			END

		-- Notifies DBA that table has been created.
		PRINT 'Ethnicity table initiated with default values.'

		-- Selects table for DBA view to ensure proper table creation.
		SELECT * FROM Ethnicity
	END


IF EXISTS (SELECT * FROM sys.tables WHERE name = 'ClientStatus')
	BEGIN
		-- Notifies DBA that table has already been created.
		PRINT 'ClientStatus table not added: already exists'
	END
ELSE
	BEGIN
		-- Creates table.
		CREATE TABLE ClientStatus (
			clientStatusID INT IDENTITY (1,1) PRIMARY KEY,
			clientStatus VARCHAR(25) NOT NULL
		)

		-- Stores procedure into string which sets identity column, executes.
		DECLARE @u VARCHAR(MAX)
		SELECT @u =
			'SET IDENTITY_INSERT ClientStatus ON;
			INSERT INTO ClientStatus(clientStatusID, clientStatus)
				VALUES (1, ''Active''),
					(2, ''Inactive'');
			SET IDENTITY_INSERT ClientStatus OFF;'
		EXEC(@u)

		-- Check if identity column is at proper seed, reseeds if not proper.
		IF (SELECT IDENT_CURRENT ('ClientStatus')) = 2
			BEGIN
				PRINT 'Identity value not reseeded: set at correct identity value.'
			END
		ELSE
			BEGIN
				DBCC CHECKIDENT ('ClientStatus', RESEED, 2)

				PRINT 'Reseeding identity value.'

				DBCC CHECKIDENT ('ClientStatus')
			END

		-- Notifies DBA that table has been created.
		PRINT 'ClientStatus table initiated with default values.'

		-- Selects table for DBA view to ensure proper table creation.
		SELECT * FROM ClientStatus
	END


IF EXISTS (SELECT * FROM sys.tables WHERE name = 'AddressesType')
	BEGIN
		-- Notifies DBA that table has already been created.
		PRINT 'AddressesType table not added: already exists'
	END
ELSE
	BEGIN
		-- Creates table.
		CREATE TABLE AddressesType (
			addressesTypeID INT IDENTITY (1,1) PRIMARY KEY (addressesTypeID) NOT NULL,
			addressesType VARCHAR(25) NOT NULL
		)

		-- Stores procedure into string which sets identity column, executes.
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

		-- Check if identity column is at proper seed, reseeds if not proper.
		IF (SELECT IDENT_CURRENT ('AddressesType')) = 4
			BEGIN
				PRINT 'Identity value not reseeded: set at correct identity value.'
			END
		ELSE
			BEGIN
				DBCC CHECKIDENT ('AddressesType', RESEED, 4)

				PRINT 'Reseeding identity value.'

				DBCC CHECKIDENT ('AddressesType')
			END

		-- Notifies DBA that table has been created.
		PRINT 'AddressesType table initiated.'

		-- Selects table for DBA view to ensure proper table creation.
		SELECT * FROM AddressesType
	END


IF EXISTS (SELECT * FROM sys.tables WHERE name = 'Addresses')
	BEGIN
		-- Notifies DBA that table has already been created.
		PRINT 'Addresses table not added: already exists'
	END
ELSE
	BEGIN
		-- Creates table.
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

		-- Check if identity column is at proper seed, reseeds if not proper.
		IF (SELECT IDENT_CURRENT ('Addresses')) = 0
			BEGIN
				PRINT 'Identity value not reseeded: set at correct identity value.'
			END
		ELSE
			BEGIN
				DBCC CHECKIDENT ('Addresses', RESEED, 0)

				PRINT 'Reseeding identity value.'

				DBCC CHECKIDENT ('Addresses')
			END

		-- Notifies DBA that table has been created.
		PRINT 'Addresses table initiated.'

		-- Selects table for DBA view to ensure proper table creation.
		SELECT * FROM Addresses
	END


IF EXISTS (SELECT * FROM sys.tables WHERE name = 'MemberType')
	BEGIN
		-- Notifies DBA that table has already been created.
		PRINT 'MemberType table not added: already exists'
	END
ELSE
	BEGIN
		-- Creates table.
		CREATE TABLE MemberType (
			memberTypeID INT IDENTITY (1,1) PRIMARY KEY (memberTypeID) NOT NULL,
			memberType VARCHAR(25) NOT NULL	
		)

		-- Stores procedure into string which sets identity column, executes.
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
					(7, ''InsuranceAuth'');
			SET IDENTITY_INSERT MemberType OFF;'
		EXEC(@q)
		
		-- Check if identity column is at proper seed, reseeds if not proper.
		IF (SELECT IDENT_CURRENT ('MemberType')) = 5
			BEGIN
				PRINT 'Identity value not reseeded: set at correct identity value.'
			END
		ELSE
			BEGIN
				DBCC CHECKIDENT ('MemberType', RESEED, 5)

				PRINT 'Reseeding identity value.'

				DBCC CHECKIDENT ('MemberType')
			END

		-- Notifies DBA that table has been created.
		PRINT 'MemberType table initiated.'

		-- Selects table for DBA view to ensure proper table creation.
		SELECT * FROM MemberType
	END


IF EXISTS (SELECT * FROM sys.tables WHERE name = 'AdditionalContactInfoType')
	BEGIN
		-- Notifies DBA that table has already been created.
		PRINT 'AdditionalContactInfoType table not added: already exists'
	END
ELSE
	BEGIN
		-- Creates table.
		CREATE TABLE AdditionalContactInfoType (
			additionalContactInfoTypeID INT IDENTITY (1,1) PRIMARY KEY (additionalContactInfoTypeID) NOT NULL,
			additionalContactInfoType VARCHAR(25)
		)
		
		-- Stores procedure into string which sets identity column, executes.
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
		
		-- Check if identity column is at proper seed, reseeds if not proper.
		IF (SELECT IDENT_CURRENT ('AdditionalContactInfoType')) = 7
			BEGIN
				PRINT 'Identity value not reseeded: set at correct identity value.'
			END
		ELSE
			BEGIN
				DBCC CHECKIDENT ('AdditionalContactInfoType', RESEED, 7)

				PRINT 'Reseeding identity value.'

				DBCC CHECKIDENT ('AdditionalContactInfoType')
			END

		-- Notifies DBA that table has been created.
		PRINT 'AdditionalContactInfoType table initiated.'

		-- Selects table for DBA view to ensure proper table creation.
		SELECT * FROM AdditionalContactInfoType
	END


IF EXISTS (SELECT * FROM sys.tables WHERE name = 'AdditionalContactInfo')
	BEGIN
		-- Notifies DBA that table has already been created.
		PRINT 'AdditionalContactInfo table not added: already exists'
	END
ELSE
	BEGIN
		-- Creates table.
		CREATE TABLE AdditionalContactInfo (
			additionalContactInfoID INT IDENTITY(1,1) PRIMARY KEY(additionalContactInfoID),
			memberTypeID INT NOT NULL CONSTRAINT FK_AddtContInfo_MemberType FOREIGN KEY REFERENCES MemberType(memberTypeID),
			additionalContactInfoTypeID INT NOT NULL CONSTRAINT FK_clients_aciid FOREIGN KEY REFERENCES AdditionalContactInfoType(additionalContactInfoTypeID),
			additionalContactInfo VARCHAR(255),
			updDate DATETIME DEFAULT (GETDATE()),
			deleted BIT
		)

		-- Check if identity column is at proper seed, reseeds if not proper.
		IF (SELECT IDENT_CURRENT ('AdditionalContactInfo')) = 0
			BEGIN
				PRINT 'Identity value not reseeded: set at correct identity value.'
			END
		ELSE
			BEGIN
				DBCC CHECKIDENT ('AdditionalContactInfo', RESEED, 0)

				PRINT 'Reseeding identity value.'

				DBCC CHECKIDENT ('AdditionalContactInfo')
			END

		-- Notifies DBA that table has been created.
		PRINT 'AdditionalContactInfo table initiated.'

		-- Selects table for DBA view to ensure proper table creation.
		SELECT * FROM AdditionalContactInfo
	END


IF EXISTS (SELECT * FROM sys.tables WHERE name = 'Physician')
	BEGIN
		-- Notifies DBA that table has already been created.
		PRINT 'Physician table not added: already exists'
	END
ELSE
	BEGIN
		-- Creates table.
		CREATE TABLE Physician (
			physicianID INT IDENTITY(1,1) PRIMARY KEY(physicianID),
			addressesID INT CONSTRAINT FK_Physician_Addresses FOREIGN KEY REFERENCES Addresses(addressesID),
			additionalContactInfoID INT CONSTRAINT FK_Physician_ContactInfo FOREIGN KEY REFERENCES AdditionalContactInfo(additionalContactInfoID),
			title VARCHAR(10),
			firstName VARCHAR(25),
			lastName VARCHAR(25),
			updDate DATETIME DEFAULT (GETDATE()),
			deleted BIT
		)

		-- Check if identity column is at proper seed, reseeds if not proper.
		IF (SELECT IDENT_CURRENT ('Physician')) = 0
			BEGIN
				PRINT 'Identity value not reseeded: set at correct identity value.'
			END
		ELSE
			BEGIN
				DBCC CHECKIDENT ('Physician', RESEED, 0)

				PRINT 'Reseeding identity value.'

				DBCC CHECKIDENT ('Physician')
			END

		-- Notifies DBA that table has been created.
		PRINT 'Physician table initiated.'

		-- Selects table for DBA view to ensure proper table creation.
		SELECT * FROM Physician
	END


IF EXISTS (SELECT * FROM sys.tables WHERE name = 'CommunicationPreferences')
	BEGIN
		-- Notifies DBA that table has already been created.
		PRINT 'CommunicationPreferences table not added: already exists'
	END
ELSE
	BEGIN
		-- Creates table.
		CREATE TABLE CommunicationPreferences (
			communicationPreferencesID INT IDENTITY (1,1) PRIMARY KEY (communicationPreferencesID),
			communicationPreferences VARCHAR(25) NOT NULL,
		)
		
		-- Stores procedure into string which sets identity column, executes.
		-- ?? Need values to add here.

		-- Check if identity column is at proper seed, reseeds if not proper.
		IF (SELECT IDENT_CURRENT ('CommunicationPreferences')) = 0
			BEGIN
				PRINT 'Identity value not reseeded: set at correct identity value.'
			END
		ELSE
			BEGIN
				DBCC CHECKIDENT ('CommunicationPreferences', RESEED, 0)

				PRINT 'Reseeding identity value.'

				DBCC CHECKIDENT ('CommunicationPreferences')
			END

		-- Notifies DBA that table has been created.
		PRINT 'CommunicationPreferences table initiated.'

		-- Selects table for DBA view to ensure proper table creation.
		SELECT * FROM CommunicationPreferences
	END


IF EXISTS (SELECT * FROM sys.tables WHERE name = 'DiagnosisType')
	BEGIN
		-- Notifies DBA that table has already been created.
		PRINT 'DiagnosisType table not added: already exists'
	END
ELSE
	BEGIN
		-- Creates table.
		CREATE TABLE DiagnosisType (
			diagnosisTypeID INT IDENTITY (1,1) PRIMARY KEY (diagnosisTYPEID),
			isPrimary BIT,
			diagnosisType VARCHAR(25)
		)
		
		-- Stores procedure into string which sets identity column, executes.
		DECLARE @p VARCHAR(MAX)
		SELECT @p =
			'SET IDENTITY_INSERT DiagnosisType ON;
			INSERT INTO DiagnosisType(diagnosisTypeID, diagnosisType)
				VALUES (1, ''ICD-10''),
					(2, ''ICD-09'');
			SET IDENTITY_INSERT DiagnosisType OFF;'
		EXEC(@p)
		
		-- Check if identity column is at proper seed, reseeds if not proper.
		IF (SELECT IDENT_CURRENT ('DiagnosisType')) = 2
			BEGIN
				PRINT 'Identity value not reseeded: set at correct identity value.'
			END
		ELSE
			BEGIN
				DBCC CHECKIDENT ('DiagnosisType', RESEED, 2)

				PRINT 'Reseeding identity value.'

				DBCC CHECKIDENT ('DiagnosisType')
			END

		-- Notifies DBA that table has been created.
		PRINT 'DiagnosisType table initiated.'

		-- Selects table for DBA view to ensure proper table creation.
		SELECT * FROM DiagnosisType
	END


	IF EXISTS (SELECT * FROM sys.tables WHERE name = 'CommentsType')
	BEGIN
		-- Notifies DBA that table has already been created.
		PRINT 'CommentsType table not added: already exists'
	END
ELSE
	BEGIN
		-- Creates table.
		CREATE TABLE CommentsType (
			commentsTypeID INT IDENTITY (1,1) PRIMARY KEY,
			commentsType VARCHAR(50) NOT NULL
		)

		-- Notifies DBA of successful table creation.
		PRINT 'CommentsType table initiated with default values.'

		-- Check if identity column is at proper seed, reseeds if not proper.
		IF (SELECT IDENT_CURRENT ('CommentsType')) = 0
			BEGIN
				PRINT 'Identity value not reseeded: set at correct identity value.'
			END
		ELSE
			BEGIN
				DBCC CHECKIDENT ('CommentsType', RESEED, 0)

				PRINT 'Reseeding identity value.'

				DBCC CHECKIDENT ('CommentsType')
			END

		-- Selects table for DBA view to ensure proper table creation.
		SELECT * FROM CommentsType		
	END


IF EXISTS (SELECT * FROM sys.tables WHERE name = 'Comments')
	BEGIN
		-- Notifies DBA that table has already been created.
		PRINT 'Comments table not added: already exists'
	END
ELSE
	BEGIN
		-- Creates table.
		CREATE TABLE Comments (
			commentsID INT IDENTITY(1,1) PRIMARY KEY(CommentsID),
			commentsTypeID INT CONSTRAINT FK_Comments_CommentsType FOREIGN KEY REFERENCES CommentsType(commentsTypeID), --chk
			memberID INT, -- chk
			memberTypeID INT CONSTRAINT FK_Comments_MemberType FOREIGN KEY REFERENCES MemberType(memberTypeID), --chk
			comments VARCHAR(MAX), -- chk
			updDate DATETIME DEFAULT (GETDATE()), --chk
			valid_To DATE,
			deleted BIT
		)

		-- Check if identity column is at proper seed, reseeds if not proper.
		IF (SELECT IDENT_CURRENT ('Comments')) = 0
			BEGIN
				PRINT 'Identity value not reseeded: set at correct identity value.'
			END
		ELSE
			BEGIN
				DBCC CHECKIDENT ('Comments', RESEED, 0)

				PRINT 'Reseeding identity value.'

				DBCC CHECKIDENT ('Comments')
			END

		-- Notifies DBA that table has been created.
		PRINT 'Comments table initiated.'

		-- Selects table for DBA view to ensure proper table creation.
		SELECT * FROM Comments
	END


IF EXISTS (SELECT * FROM sys.tables WHERE name = 'FamilyMemberType')
	BEGIN
		-- Notifies DBA that table has already been created.
		PRINT 'FamilyMemberType table not added: already exists'
	END
ELSE
	BEGIN
		-- Creates table.
		CREATE TABLE FamilyMemberType (
			familyMemberTypeID INT IDENTITY (1,1) PRIMARY KEY (familyMemberTypeID),
			familyMemberType VARCHAR(25) NOT NULL,
		)
		
		-- Stores procedure into string which sets identity column, executes.
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

		-- Check if identity column is at proper seed, reseeds if not proper.
		IF (SELECT IDENT_CURRENT ('FamilyMemberType')) = 8
			BEGIN
				PRINT 'Identity value not reseeded: set at correct identity value.'
			END
		ELSE
			BEGIN
				DBCC CHECKIDENT ('FamilyMemberType', RESEED, 8)

				PRINT 'Reseeding identity value.'

				DBCC CHECKIDENT ('FamilyMemberType')
			END

		-- Notifies DBA that table has been created.
		PRINT 'FamilyMemberType table initiated.'

		-- Selects table for DBA view to ensure proper table creation.
		SELECT * FROM FamilyMemberType
	END


IF EXISTS (SELECT * FROM sys.tables WHERE name = 'Sex')
	BEGIN
		-- Notifies DBA that table has already been created.
		PRINT 'Sex table not added: already exists'
	END
ELSE
	BEGIN
		-- Creates table.
		CREATE TABLE Sex (
			sexID INT IDENTITY (1,1) PRIMARY KEY,
			sex VARCHAR(25),
			)

		-- Stores procedure into string which sets identity column, executes.
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

		-- Check if identity column is at proper seed, reseeds if not proper.
		IF (SELECT IDENT_CURRENT ('Sex')) = 3
			BEGIN
				PRINT 'Identity value not reseeded: set at correct identity value.'
			END
		ELSE
			BEGIN
				DBCC CHECKIDENT ('Sex', RESEED, 3)

				PRINT 'Reseeding identity value.'

				DBCC CHECKIDENT ('Sex')
			END

		-- Notifies DBA that table has been created.
		PRINT 'Sex table initiated.'

		-- Selects table for DBA view to ensure proper table creation.
		SELECT * FROM Sex
	END


IF EXISTS (SELECT * FROM sys.tables WHERE name = 'FamilyMember')
	BEGIN
		-- Notifies DBA that table has already been created.
		PRINT 'FamilyMember table not added: already exists'
	END
ELSE
	BEGIN
		-- Creates table.
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

		-- Check if identity column is at proper seed, reseeds if not proper.
		IF (SELECT IDENT_CURRENT ('FamilyMember')) = 0
			BEGIN
				PRINT 'Identity value not reseeded: set at correct identity value.'
			END
		ELSE
			BEGIN
				DBCC CHECKIDENT ('FamilyMember', RESEED, 0)

				PRINT 'Reseeding identity value.'

				DBCC CHECKIDENT ('FamilyMember')
			END

		-- Notifies DBA that table has been created.
		PRINT 'FamilyMember table initiated.'

		-- Selects table for DBA view to ensure proper table creation.
		SELECT * FROM FamilyMember
	END


IF EXISTS (SELECT * FROM sys.tables WHERE name = 'Insurance')
	BEGIN
		-- Notifies DBA that table has already been created.
		PRINT 'Insurance table not added: already exists'
	END
ELSE
	BEGIN
		-- Creates table.
		CREATE TABLE Insurance (
			insuranceID INT IDENTITY(1,1) PRIMARY KEY(insuranceID),
			clientID INT CONSTRAINT FK_Insurance_Client FOREIGN KEY REFERENCES Clients(clientID),
			insuranceName VARCHAR(75),
			insurancePolicyID VARCHAR(75),
			medPreAuthNumber VARCHAR(100),
			updDate DATETIME DEFAULT (GETDATE()),
			deleted BIT
		)

		-- Check if identity column is at proper seed, reseeds if not proper.
		IF (SELECT IDENT_CURRENT ('Insurance')) = 0
			BEGIN
				PRINT 'Identity value not reseeded: set at correct identity value.'
			END
		ELSE
			BEGIN
				DBCC CHECKIDENT ('Insurance', RESEED, 0)

				PRINT 'Reseeding identity value.'

				DBCC CHECKIDENT ('Insurance')
			END

		-- Notifies DBA that table has been created.
		PRINT 'Insurance table initiated.'

		-- Selects table for DBA view to ensure proper table creation.
		SELECT * FROM Insurance
	END


IF EXISTS (SELECT * FROM sys.tables WHERE name = 'PrimaryLanguage')
	BEGIN
		-- Notifies DBA that table has already been created.
		PRINT 'PrimaryLanguage table not added: already exists'
	END
ELSE
	BEGIN
		-- Creates table.
		CREATE TABLE PrimaryLanguage (
			primaryLanguageID INT IDENTITY (1,1) PRIMARY KEY (primaryLanguageID),
			primaryLanguage VARCHAR(20) NOT NULL,
		)
		
		-- Stores procedure into string which sets identity column, executes.
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
		
		-- Check if identity column is at proper seed, reseeds if not proper.
		IF (SELECT IDENT_CURRENT ('PrimaryLanguage')) = 32
			BEGIN
				PRINT 'Identity value not reseeded: set at correct identity value.'
			END
		ELSE
			BEGIN
				DBCC CHECKIDENT ('PrimaryLanguage', RESEED, 32)

				PRINT 'Reseeding identity value.'

				DBCC CHECKIDENT ('PrimaryLanguage')
			END

		-- Notifies DBA that table has been created.
		PRINT 'PrimaryLanguage table initiated.'

		-- Selects table for DBA view to ensure proper table creation.
		SELECT * FROM PrimaryLanguage
	END


IF EXISTS (SELECT * FROM sys.tables WHERE name = 'ReferralSourceType')
	BEGIN
		-- Notifies DBA that table has already been created.
		PRINT 'ReferralSourceType table not added: already exists'
	END
ELSE
	BEGIN
		-- Creates table.
		CREATE TABLE ReferralSourceType (
			referralSourceTypeID INT IDENTITY (1,1) PRIMARY KEY (referralSourceTypeID),
			referralSourceType VARCHAR(250),
			referralNotificationType VARCHAR(20),
		)
		
		-- Stores procedure into string which sets identity column, executes.
		-- ?? Need type values.

		-- Check if identity column is at proper seed, reseeds if not proper.
		IF (SELECT IDENT_CURRENT ('ReferralSourceType')) = 0
			BEGIN
				PRINT 'Identity value not reseeded: set at correct identity value.'
			END
		ELSE
			BEGIN
				DBCC CHECKIDENT ('ReferralSourceType', RESEED, 0)

				PRINT 'Reseeding identity value.'

				DBCC CHECKIDENT ('ReferralSourceType')
			END

		-- Notifies DBA that table has been created.
		PRINT 'ReferralSourceType table initiated.'

		-- Selects table for DBA view to ensure proper table creation.
		SELECT * FROM ReferralSourceType
	END


IF EXISTS (SELECT * FROM sys.tables WHERE name = 'ReferralSource')
	BEGIN
		-- Notifies DBA that table has already been created.
		PRINT 'ReferralSource table not added: already exists'
	END
ELSE
	BEGIN
		-- Creates table.
		CREATE TABLE ReferralSource (
			referralSourceID INT IDENTITY(1,1) PRIMARY KEY(referralSourceID),
			additionalContactInfoID INT CONSTRAINT FK_referralSource_contactInfo FOREIGN KEY REFERENCES AdditionalContactInfo(additionalContactInfoID),
			referralSourceTypeID INT CONSTRAINT FK_referralSource_referralSourceType FOREIGN KEY REFERENCES ReferralSourceType(referralSourceTypeID),
			addressesID INT CONSTRAINT FK_referralSource_addresses FOREIGN KEY REFERENCES Addresses(addressesID),
			referralSource VARCHAR(50),
			updDate DATETIME DEFAULT (GETDATE()),
			deleted BIT
		)

		-- Check if identity column is at proper seed, reseeds if not proper.
		IF (SELECT IDENT_CURRENT ('ReferralSource')) = 0
			BEGIN
				PRINT 'Identity value not reseeded: set at correct identity value.'
			END
		ELSE
			BEGIN
				DBCC CHECKIDENT ('ReferralSource', RESEED, 0)

				PRINT 'Reseeding identity value.'

				DBCC CHECKIDENT ('ReferralSource')
			END

		-- Notifies DBA that table has been created.
		PRINT 'ReferralSource table initiated.'

		-- Selects table for DBA view to ensure proper table creation.
		SELECT * FROM ReferralSource
	END


IF EXISTS (SELECT * FROM sys.tables WHERE name = 'SchoolInformation')
	BEGIN
		-- Notifies DBA that table has already been created.
		PRINT 'SchoolInformation table not added: already exists'
	END
ELSE
	BEGIN
		-- Creates table.
		CREATE TABLE SchoolInformation (
			schoolInfoID INT IDENTITY (1,1) PRIMARY KEY,
			isd VARCHAR(25),
			updDate DATETIME DEFAULT (GETDATE())
		)

		-- Check if identity column is at proper seed, reseeds if not proper.
		IF (SELECT IDENT_CURRENT ('SchoolInformation')) = 0
			BEGIN
				PRINT 'Identity value not reseeded: set at correct identity value.'
			END
		ELSE
			BEGIN
				DBCC CHECKIDENT ('SchoolInformation', RESEED, 0)

				PRINT 'Reseeding identity value.'

				DBCC CHECKIDENT ('SchoolInformation')
			END

		-- Notifies DBA that table has been created.
		PRINT 'SchoolInformation table initiated.'

		-- Selects table for DBA view to ensure proper table creation.
		SELECT * FROM SchoolInformation
	END


IF EXISTS (SELECT * FROM sys.tables WHERE name = 'StaffType')
	BEGIN
		-- Notifies DBA that table has already been created.
		PRINT 'StaffType table not added: already exists'
	END
ELSE
	BEGIN
		-- Creates table.
		CREATE TABLE StaffType (
			staffTypeID INT IDENTITY (1,1) PRIMARY KEY (staffTypeID),
			staffType VARCHAR(25) NOT NULL,
			updDate DATETIME DEFAULT (GETDATE()) 
		)

		-- Stores procedure into string which sets identity column, executes.
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

		-- Check if identity column is at proper seed, reseeds if not proper.
		IF (SELECT IDENT_CURRENT ('StaffType')) = 4
			BEGIN
				PRINT 'Identity value not reseeded: set at correct identity value.'
			END
		ELSE
			BEGIN
				DBCC CHECKIDENT ('StaffType', RESEED, 4)

				PRINT 'Reseeding identity value.'

				DBCC CHECKIDENT ('StaffType')
			END

		-- Notifies DBA that table has been created.
		PRINT 'StaffType table initiated.'

		-- Selects table for DBA view to ensure proper table creation.
		SELECT * FROM StaffType
	END


IF EXISTS (SELECT * FROM sys.tables WHERE name = 'Staff')
	BEGIN
		-- Notifies DBA that table has already been created.
		PRINT 'Staff table not added: already exists'
	END
ELSE
	BEGIN
		-- Creates table.
		CREATE TABLE Staff (
			staffID INT IDENTITY (1,1) PRIMARY KEY (staffID),
			staffTypeID INT FOREIGN KEY REFERENCES StaffType(staffTypeID),
			addressesID INT FOREIGN KEY REFERENCES Addresses(addressesID),
			additionalContactInfoID INT FOREIGN KEY REFERENCES AdditionalContactInfo(additionalContactInfoID),
			sexID INT FOREIGN KEY REFERENCES Sex(sexID),
			firstName VARCHAR(25),
			lastName VARCHAR(25),
			staffAltID varchar(25),
			deleted bit,
			handicapped bit,
			ssn int,
			dob DATE,
			updDate DATETIME DEFAULT (GETDATE())
		)

		-- Check if identity column is at proper seed, reseeds if not proper.
		IF (SELECT IDENT_CURRENT ('Staff')) = 0
			BEGIN
				PRINT 'Identity value not reseeded: set at correct identity value.'
			END
		ELSE
			BEGIN
				DBCC CHECKIDENT ('Staff', RESEED, 0)

				PRINT 'Reseeding identity value.'

				DBCC CHECKIDENT ('Staff')
			END

		-- Notifies DBA that table has been created.
		PRINT 'Staff table initiated.'

		-- Selects table for DBA view to ensure proper table creation.
		SELECT * FROM Staff
	END


IF EXISTS (SELECT * FROM sys.tables WHERE name = 'Office')
	BEGIN
		-- Notifies DBA that table has already been created.
		PRINT 'Office table not added: already exists'
	END
ELSE
	BEGIN
		-- Creates table.
		CREATE TABLE Office (
			officeID INT IDENTITY (1,1) PRIMARY KEY,
			officeName VARCHAR(25),
			)
		
		-- Stores procedure into string which sets identity column, executes.
		-- ?? Need table values.

		-- Check if identity column is at proper seed, reseeds if not proper.
		IF (SELECT IDENT_CURRENT ('Office')) = 0
			BEGIN
				PRINT 'Identity value not reseeded: set at correct identity value.'
			END
		ELSE
			BEGIN
				DBCC CHECKIDENT ('Office', RESEED, 0)

				PRINT 'Reseeding identity value.'

				DBCC CHECKIDENT ('Office')
			END

		-- Notifies DBA that table has been created.
		PRINT 'Office table initiated.'

		-- Selects table for DBA view to ensure proper table creation.
		SELECT * FROM Office
	END

	
IF EXISTS (SELECT * FROM sys.tables WHERE name = 'Clients')
	BEGIN
		-- Notifies DBA that table has already been created.`
		PRINT 'Clients table not added: already exists'
	END
ELSE
	BEGIN
		-- Creates table.
		CREATE TABLE Clients ( 
			clientID INT IDENTITY (1,1) PRIMARY KEY (clientID),
			raceID INT FOREIGN KEY REFERENCES Race(raceID),
			ethnicityID INT FOREIGN KEY REFERENCES Ethnicity(ethnicityID),
			clientStatusID INT FOREIGN KEY REFERENCES ClientStatus(clientStatusID),
			primaryLanguageID INT FOREIGN KEY REFERENCES PrimaryLanguage(primaryLanguageID),
			schoolInfoID INT FOREIGN KEY REFERENCES SchoolInformation(schoolInfoID),
			communicationPreferencesID INT FOREIGN KEY REFERENCES CommunicationPreferences(communicationPreferencesID),
			sexID INT FOREIGN KEY REFERENCES Sex(sexID),
			officeID INT FOREIGN KEY REFERENCES Office(officeID),
			altID VARCHAR(25),
			firstName VARCHAR(25),
			middleInitial VARCHAR(1),
			lastName VARCHAR(25),
			dob DATE,
			ssn INT,
			referralSource VARCHAR(50),
			intakeDate DATETIME,
			ifspDate DATE,
			compSvcDate DATE,
			serviceAreaException BIT,
			tkidsCaseNumber INT,
			consentToRelease BIT,
			eci VARCHAR(25),
			accountingSystemID VARCHAR(25),
			updDate DATETIME DEFAULT (GETDATE()),
			deleted BIT,
		)

		-- Check if identity column is at proper seed, reseeds if not proper.
		IF (SELECT IDENT_CURRENT ('Clients')) = 0
			BEGIN
				PRINT 'Identity value not reseeded: set at correct identity value.'
			END
		ELSE
			BEGIN
				DBCC CHECKIDENT ('Clients', RESEED, 0)

				PRINT 'Reseeding identity value.'

				DBCC CHECKIDENT ('Clients')
			END

		-- Notifies DBA that table has been created.
		PRINT 'Clients table initiated.'

		-- Selects table for DBA view to ensure proper table creation.
		SELECT * FROM Clients
	END


IF EXISTS (SELECT * FROM sys.tables WHERE name = 'InsuranceAuthorization')
	BEGIN
		-- Notifies DBA that table has already been created.
		PRINT 'InsuranceAuthorization table not added: already exists'
	END
ELSE
	BEGIN
		-- Creates table.
		CREATE TABLE InsuranceAuthorization (
			insuranceAuthID INT IDENTITY (1,1) PRIMARY KEY (insuranceAuthID),
			insuranceID INT CONSTRAINT FK_InsAuth_Insurance FOREIGN KEY REFERENCES Insurance(insuranceID),
			authorized_From DATE,
			authorized_To DATE,
			insuranceAuthorizationType VARCHAR(25),
			updDate DATETIME DEFAULT (GETDATE()),
			deleted BIT
		)

		-- Check if identity column is at proper seed, reseeds if not proper.
		IF (SELECT IDENT_CURRENT ('InsuranceAuthorization')) = 0
			BEGIN
				PRINT 'Identity value not reseeded: set at correct identity value.'
			END
		ELSE
			BEGIN
				DBCC CHECKIDENT ('InsuranceAuthorization', RESEED, 0)

				PRINT 'Reseeding identity value.'

				DBCC CHECKIDENT ('InsuranceAuthorization')
			END

		-- Notifies DBA that table has been created.
		PRINT 'InsuranceAuthorization table initiated.'

		-- Selects table for DBA view to ensure proper table creation.
		SELECT * FROM InsuranceAuthorization
	END


IF EXISTS (SELECT * FROM sys.tables WHERE name = 'DiagnosisCode')
	BEGIN
		-- Notifies DBA that table has already been created.
		PRINT 'DiagnosisCode table not added: already exists'
	END
ELSE
	BEGIN
		-- Creates table.
		CREATE TABLE DiagnosisCode (
			diagnosisCodeID INT IDENTITY (1,1) PRIMARY KEY,
			diagnosisCode VARCHAR(10),
			diagnosisDescription VARCHAR(100)
		)
		-- Stores procedure into string which sets identity column, executes.

		-- Check if identity column is at proper seed, reseeds if not proper.
		IF (SELECT IDENT_CURRENT ('DiagnosisCode')) = 0
			BEGIN
				PRINT 'Identity value not reseeded: set at correct identity value.'
			END
		ELSE
			BEGIN
				DBCC CHECKIDENT ('DiagnosisCode', RESEED, 0)

				PRINT 'Reseeding identity value.'

				DBCC CHECKIDENT ('DiagnosisCode')
			END

		-- Notifies DBA that table has been created.
		PRINT 'DiagnosisCode table initiated.'

		-- Selects table for DBA view to ensure proper table creation.
		SELECT * FROM DiagnosisCode
	END


IF EXISTS (SELECT * FROM sys.tables WHERE name = 'Diagnosis')
	BEGIN
		-- Notifies DBA that table has already been created.
		PRINT 'Diagnosis table not added: already exists'
	END
ELSE
	BEGIN
		-- Creates table.
		CREATE TABLE Diagnosis (
			diagnosisID INT IDENTITY(1,1) PRIMARY KEY(DiagnosisID),
			clientID INT CONSTRAINT FK_diagnosis_client FOREIGN KEY REFERENCES Clients(clientID),
			diagnosisCodeID INT CONSTRAINT FK_diagnosis_diagnosisCode FOREIGN KEY REFERENCES DiagnosisCode(diagnosisCodeID),
			diagnosisTypeID INT CONSTRAINT FK_diagnosis_diagnosisType FOREIGN KEY REFERENCES DiagnosisType(diagnosisTypeID),
			isPrimary BIT,
			diagnosis_From DATE,
			diagnosis_To DATE,
			updDate DATETIME DEFAULT (GETDATE()),
			deleted BIT
		)

		-- Check if identity column is at proper seed, reseeds if not proper.
		IF (SELECT IDENT_CURRENT ('Diagnosis')) = 0
			BEGIN
				PRINT 'Identity value not reseeded: set at correct identity value.'
			END
		ELSE
			BEGIN
				DBCC CHECKIDENT ('Diagnosis', RESEED, 0)

				PRINT 'Reseeding identity value.'

				DBCC CHECKIDENT ('Diagnosis')
			END

		-- Notifies DBA that table has been created.
		PRINT 'Diagnosis table initiated.'

		-- Selects table for DBA view to ensure proper table creation.
		SELECT * FROM Diagnosis
	END


IF EXISTS (SELECT * FROM sys.tables WHERE name = 'LnkAddressesFamily')
	BEGIN
		-- Notifies DBA that table has already been created.
		PRINT 'LnkAddressesFamily table not added: already exists'
	END
ELSE
	BEGIN
		-- Creates table.
		CREATE TABLE LnkAddressesFamily (
			addressesID INT FOREIGN KEY REFERENCES Addresses(addressesID),
			familyID INT FOREIGN KEY REFERENCES FamilyMember(familyMemberID)
				PRIMARY KEY (addressesID, familyID)
			)

		-- Notifies DBA that table has been created.
		PRINT 'LnkAddressesFamily table initiated.'

		-- Selects table for DBA view to ensure proper table creation.
		SELECT * FROM LnkAddressesFamily
	END


IF EXISTS (SELECT * FROM sys.tables WHERE name = 'LnkClientFamily')
	BEGIN
		-- Notifies DBA that table has already been created.
		PRINT 'LnkClientFamily table not added: already exists'
	END
ELSE
	BEGIN
		-- Creates table.
		CREATE TABLE LnkClientFamily (
			clientID INT FOREIGN KEY REFERENCES Clients(clientID),
			familyID INT FOREIGN KEY REFERENCES FamilyMember(familyMemberID),
				PRIMARY KEY (clientID, familyID),
			)

		-- Notifies DBA that table has been created.
		PRINT 'LnkClientFamily table initiated.'

		-- Selects table for DBA view to ensure proper table creation.
		SELECT * FROM LnkClientFamily
	END


IF EXISTS (SELECT * FROM sys.tables WHERE name = 'LnkClientInsurance')
	BEGIN
		-- Notifies DBA that table has already been created.
		PRINT 'LnkClientInsurance table not added: already exists'
	END
ELSE
	BEGIN
		-- Creates table.
		CREATE TABLE LnkClientInsurance ( 
			insuranceID INT FOREIGN KEY REFERENCES Insurance(insuranceID),
			clientID INT FOREIGN KEY REFERENCES Clients(clientID),
				PRIMARY KEY (insuranceID, clientID)
			)

		-- Notifies DBA that table has been created.
		PRINT 'LnkClientInsurance table initiated.'

		-- Selects table for DBA view to ensure proper table creation.
		SELECT * FROM LnkClientInsurance
	END


IF EXISTS (SELECT * FROM sys.tables WHERE name = 'LnkClientReferralSource')
	BEGIN
		-- Notifies DBA that table has already been created.
		PRINT 'LnkClientReferralSource table not added: already exists'
	END
ELSE
	BEGIN
		-- Creates table.
		CREATE TABLE LnkClientReferralSource (
			clientsID INT FOREIGN KEY REFERENCES Clients(clientID),
			referralSourceID INT FOREIGN KEY REFERENCES ReferralSource(referralSourceID)
				PRIMARY KEY (clientsID, referralSourceID),
			commentsID INT FOREIGN KEY REFERENCES Comments(commentsID),
			referralPastDueReason VARCHAR(255),
			referralDate DATE,
			updDate DATETIME DEFAULT (GETDATE()),
			deleted BIT
		)

		-- Notifies DBA that table has been created.
		PRINT 'LnkClientReferralSource table initiated.'

		-- Selects table for DBA view to ensure proper table creation.
		SELECT * FROM LnkClientReferralSource
	END


IF EXISTS (SELECT * FROM sys.tables WHERE name = 'LnkClientStaff')
	BEGIN
		-- Notifies DBA that table has already been created.
		PRINT 'LnkClientStaff table not added: already exists'
	END
ELSE
	BEGIN
		-- Creates table.
		CREATE TABLE LnkClientStaff (
			clientID INT FOREIGN KEY REFERENCES Clients(clientID), 
			staffID INT FOREIGN KEY REFERENCES Staff(staffID)
				PRIMARY KEY (clientID, staffID),
			)

		-- Notifies DBA that table has been created.
		PRINT 'LnkClientStaff table initiated.'

		-- Selects table for DBA view to ensure proper table creation.
		SELECT * FROM LnkClientStaff
	END


IF EXISTS (SELECT * FROM sys.tables WHERE name = 'LnkClientPhysician')
	BEGIN
		-- Notifies DBA that table has already been created.
		PRINT 'LnkClientPhysician table not added: already exists'
	END
ELSE
	BEGIN
		-- Creates table.
		CREATE TABLE LnkClientPhysician (
			clientID INT FOREIGN KEY REFERENCES Clients(clientID),
			physicianID INT FOREIGN KEY REFERENCES Physician(physicianID)
				PRIMARY KEY (clientID, physicianID),
			medicalReceived BIT,
			medicalReceivedDate DATE,
			immunizationReceived BIT,
			immunizationReceivedDate DATE,
			updDate DATETIME DEFAULT (GETDATE()),
			deleted BIT
		)

		-- Notifies DBA that table has been created.
		PRINT 'LnkClientPhysician table initiated.'

		-- Selects table for DBA view to ensure proper table creation.
		SELECT * FROM LnkClientPhysician
	END


IF EXISTS (SELECT * FROM sys.tables WHERE name = 'TimeHeader')
	BEGIN
		-- Notifies DBA that table has already been created.
		PRINT 'TimeHeader table not added: already exists'
	END
ELSE
	BEGIN
		-- Creates table.
		CREATE TABLE TimeHeader (
			timeHeaderID int IDENTITY (1,1) PRIMARY KEY,
			staffID int FOREIGN KEY REFERENCES Staff(staffID),
			weekEnding varchar(10),
			deleted bit
		)

		-- Check if identity column is at proper seed, reseeds if not proper.
		IF (SELECT IDENT_CURRENT ('TimeHeader')) = 0
			BEGIN
				PRINT 'Identity value not reseeded: set at correct identity value.'
			END
		ELSE
			BEGIN
				DBCC CHECKIDENT ('TimeHeader', RESEED, 0)

				PRINT 'Reseeding identity value.'

				DBCC CHECKIDENT ('TimeHeader')
			END

		-- Notifies DBA that table has been created.
		PRINT 'TimeHeader table initiated.'

		-- Selects table for DBA view to ensure proper table creation.
		SELECT * FROM TimeHeader
	END


IF EXISTS (SELECT * FROM sys.tables WHERE name = 'TimeDetail')
	BEGIN
		-- Notifies DBA that table has already been created.
		PRINT 'TimeDetail table not added: already exists'
	END
ELSE
	BEGIN
		-- Creates table.
		CREATE TABLE TimeDetail (
			timeDetailID int IDENTITY (1,1) PRIMARY KEY,
			timeHeaderID int FOREIGN KEY REFERENCES TimeHeader(timeHeaderID),
			clientID int FOREIGN KEY REFERENCES Clients(clientID),
			actualTime decimal,
			eciCode varchar(5),
			insuranceDesignation char(1),
			cptCode varchar(5),
			insuranceTime decimal,
			placeOfService char(1),
			tcm varchar(10),
			canceled varchar(10),
			updDate datetime,
			deleted bit
			)

		-- Check if identity column is at proper seed, reseeds if not proper.
		IF (SELECT IDENT_CURRENT ('TimeDetail')) = 0
			BEGIN
				PRINT 'Identity value not reseeded: set at correct identity value.'
			END
		ELSE
			BEGIN
				DBCC CHECKIDENT ('TimeDetail', RESEED, 0)

				PRINT 'Reseeding identity value.'

				DBCC CHECKIDENT ('TimeDetail')
			END

		-- Notifies DBA that table has been created.
		PRINT 'TimeDetail table initiated.'

		-- Selects table for DBA view to ensure proper table creation.
		SELECT * FROM TimeDetail
	END


IF EXISTS (SELECT * FROM sys.tables WHERE name = 'ErrorLog')
	BEGIN
		-- Notifies DBA that table has already been created.
		PRINT 'ErrorLog table not added: already exists'
	END
ELSE
	BEGIN
		-- Creates table.
		CREATE TABLE ErrorLog (
			errorLog int IDENTITY (1,1) PRIMARY KEY,
			errorTime datetime,
			errorMessage varchar (50),
			errorProcedure varchar (25)
			)

		-- Check if identity column is at proper seed, reseeds if not proper.
		IF (SELECT IDENT_CURRENT ('ErrorLog')) = 0
			BEGIN
				PRINT 'Identity value not reseeded: set at correct identity value.'
			END
		ELSE
			BEGIN
				DBCC CHECKIDENT ('ErrorLog', RESEED, 0)

				PRINT 'Reseeding identity value.'

				DBCC CHECKIDENT ('ErrorLog')
			END

		-- Notifies DBA that table has been created.
		PRINT 'ErrorLog table initiated.'

		-- Selects table for DBA view to ensure proper table creation.
		SELECT * FROM ErrorLog
	END

IF EXISTS (SELECT * FROM sys.tables WHERE name = 'LnkAddressMember')
	BEGIN
		-- Notifies DBA that table has already been created.
		PRINT 'LnkAddressMember table not added: already exists'
	END
ELSE
	BEGIN
		-- Creates table.
		CREATE TABLE LnkAddressMember (
			memberTypeID INT FOREIGN KEY REFERENCES MemberType(memberTypeID),
			addressesID INT FOREIGN KEY REFERENCES Addresses(addressesID),
			memberID INT
			PRIMARY KEY (memberTypeID, addressesID)
		)

		-- Check if identity column is at proper seed, reseeds if not proper.
		IF (SELECT IDENT_CURRENT ('LnkAddressMember')) = 0
			BEGIN
				PRINT 'Identity value not reseeded: set at correct identity value.'
			END
		ELSE
			BEGIN
				DBCC CHECKIDENT ('LnkAddressMember', RESEED, 0)

				PRINT 'Reseeding identity value.'

				DBCC CHECKIDENT ('LnkAddressMember')
			END

		-- Notifies DBA that table has been created.
		PRINT 'LnkAddressMember table initiated.'

		-- Selects table for DBA view to ensure proper table creation.
		SELECT * FROM LnkAddressMember
	END