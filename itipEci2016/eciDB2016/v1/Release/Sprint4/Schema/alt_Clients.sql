/***********************************************************************************************************
Description: 
	Alters client table to add altID and deleted column for clients.
Author: 
	Jennifer M. Graves
Date: 
	07-05-2016
Change History:
	07-05-2016 -- jmg -- added middleInitial column.
	07-11-2016 -- jmg -- added additional columns on client table.
************************************************************************************************************/

-- Declares table variable for Clients.
DECLARE @clients INT = 0

-- Assigns the system table ID to @clients variable for later use.
SELECT @clients = (
	SELECT OBJECT_ID
	FROM sys.tables
	WHERE name = 'Clients'
)

DECLARE @fkn NVARCHAR(50)

-- Assigns a foreign key name for use in later script which will drop the foreign key constraint
SELECT @fkn = (
    SELECT name
    FROM sys.foreign_keys
    WHERE referenced_object_id = object_id('Diagnosis') AND parent_object_id = object_id('Clients')
)

DECLARE @databaseName NVARCHAR(50) -- Variable to hold your database's name
DECLARE @dtscript NVARCHAR(255) -- Variable to hold the script, which we will build later, and which drops all constraints for the table you are dropping

SELECT @clients

-- Checks if table exists, creates table if it doesn't.

IF ISNULL(@clients,0) = 0
	BEGIN
		CREATE TABLE Clients ( 
			clientID INT IDENTITY (1,1) PRIMARY KEY (clientID),
			raceID INT FOREIGN KEY REFERENCES Race(raceID),
			ethnicityID INT FOREIGN KEY REFERENCES Ethnicity(ethnicityID),
			clientStatusID INT FOREIGN KEY REFERENCES ClientStatus(clientStatusID),
			primaryLanguageID INT FOREIGN KEY REFERENCES PrimaryLanguage(primaryLanguageID),
			schoolInfoID INT FOREIGN KEY REFERENCES SchoolInformation(schoolInfoID),
			commentsID INT FOREIGN KEY REFERENCES Comments(commentsID),
			insuranceAuthID INT FOREIGN KEY REFERENCES InsuranceAuthorization(insuranceAuthID),
			communicationPreferencesID INT FOREIGN KEY REFERENCES CommunicationPreferences(communicationPreferencesID),
			sexID INT FOREIGN KEY REFERENCES Sex(sexID),
			officeID INT FOREIGN KEY REFERENCES Office(officeID), -- TODO: Add to proc.
			addressesID INT FOREIGN KEY REFERENCES Addresses(addressesID), -- TODO: Add to proc
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
			serviceAreaException BIT, --	TODO: Add to proc
			tkidsCaseNumber INT, -- TODO: Add to proc, TODO: determine if this is an into or varchar.
			consentToRelease BIT, -- TODO: Add to proc
			eci VARCHAR(25), -- TODO: Add to proc, TODO: What is this? Is this the right data type?
			accountingSystemID VARCHAR(25), -- TODO: Add to proc, TODO: What is this? Is this the right data type?
			deleted BIT
		)
	END
ELSE
	BEGIN
		
		IF EXISTS (SELECT * FROM sys.columns WHERE @clients = OBJECT_ID AND name = 'altID')
			BEGIN
				PRINT 'Did not add altID column: already exists.'
			END
		ELSE
			BEGIN
				ALTER TABLE Clients
					ADD altID VARCHAR(25)
				PRINT 'Added altID column on Clients table.'
			END

		IF EXISTS (SELECT * FROM sys.columns WHERE @clients = OBJECT_ID AND name = 'deleted')
			BEGIN
				PRINT 'Did not add deleted column: already exists.'
			END
		ELSE
			BEGIN
				ALTER TABLE Clients
					ADD deleted BIT
				PRINT 'Added deleted column on Clients table.'
			END

		IF EXISTS (SELECT * FROM sys.columns WHERE @clients = OBJECT_ID AND name = 'middleInitial')
			BEGIN
				PRINT 'Did not add middleInitial column: already exists.'
			END
		ELSE
			BEGIN
				ALTER TABLE Clients
					ADD middleInitial VARCHAR(1)
				PRINT 'Added middleInitial column on Clients table.'
			END

		IF EXISTS (SELECT * FROM sys.columns WHERE @clients = OBJECT_ID AND name = 'sexID')
			BEGIN
				PRINT 'Did not add sexID column: already exists.'
			END
		ELSE
			BEGIN
				ALTER TABLE Clients
					ADD sexID INT FOREIGN KEY REFERENCES Sex(sexID)
				PRINT 'Added sexID column on Clients table.'
			END

		IF EXISTS (SELECT * FROM sys.columns WHERE @clients = OBJECT_ID AND name ='addressesID')
			BEGIN
				PRINT 'Did not add addressesID column: already exists.'
			END
		ELSE
			BEGIN
				ALTER TABLE Clients
					ADD addressesID INT FOREIGN KEY REFERENCES Addresses(addressesID)
				PRINT 'Added addressesID column to Clients table.'
			END

		IF EXISTS (SELECT * FROM sys.columns WHERE @clients = OBJECT_ID AND name ='serviceAreaException')
			BEGIN
				PRINT 'Did not add serviceAreaException column: already exists.'
			END
		ELSE
			BEGIN
				ALTER TABLE Clients
					ADD serviceAreaException BIT
				PRINT 'Added serviceAreaException column to Clients table.'
			END

		IF EXISTS (SELECT * FROM sys.columns WHERE @clients = OBJECT_ID AND name ='tkidsCaseNumber')
			BEGIN
				PRINT 'Did not add tkidsCaseNumber column: already exists.'
			END
		ELSE
			BEGIN
				ALTER TABLE Clients
					ADD tkidsCaseNumber INT
				PRINT 'Added tkidsCaseNumber column to Clients table.'
			END

		IF EXISTS (SELECT * FROM sys.columns WHERE @clients = OBJECT_ID AND name ='consentToRelease')
			BEGIN
				PRINT 'Did not add consentToRelease column: already exists.'
			END
		ELSE
			BEGIN
				ALTER TABLE Clients
					ADD consentToRelease BIT
				PRINT 'Added consentToRelease column to Clients table.'
			END

		IF EXISTS (SELECT * FROM sys.columns WHERE @clients = OBJECT_ID AND name ='eci')
			BEGIN
				PRINT 'Did not add eci column: already exists.'
			END
		ELSE
			BEGIN
				ALTER TABLE Clients
					ADD eci BIT
				PRINT 'Added eci column to Clients table.'
			END

		IF EXISTS (SELECT * FROM sys.columns WHERE @clients = OBJECT_ID AND name ='accountingSystemID')
			BEGIN
				PRINT 'Did not add accountingSystemID column: already exists.'
			END
		ELSE
			BEGIN
				ALTER TABLE Clients
					ADD accountingSystemID VARCHAR(25)
				PRINT 'Added accountingSystemID column to Clients table.'
			END

		IF EXISTS (SELECT * FROM sys.columns WHERE @clients = OBJECT_ID AND name ='officeID')
			BEGIN
				PRINT 'Did not add officeID column: already exists.'
			END
		ELSE
			BEGIN
				ALTER TABLE Clients
					ADD officeID INT FOREIGN KEY REFERENCES Office(officeID)
				PRINT 'Added officeID column to Clients table.'
			END

		IF EXISTS (SELECT * FROM sys.columns WHERE @clients = OBJECT_ID AND name ='diagnosisID')
			BEGIN
				WHILE EXISTS(select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where constraint_catalog = @databaseName and table_name = 'Clients')
					BEGIN
						SELECT @dtscript = (
						  'ALTER TABLE FamiyMember' + 
						  ' DROP CONSTRAINT ' + 
						  @fkn
						  )
						FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS 
						WHERE constraint_catalog = @databaseName and table_name = 'Clients'
						exec sp_executesql @dtscript
					END

				ALTER TABLE Clients
					DROP COLUMN diagnosisID
				PRINT 'Removed diagnosisID foreign key column.'
			END
		ELSE
			BEGIN
				PRINT 'Unneeded: diagnosisID column does not exist.'
			END
	END