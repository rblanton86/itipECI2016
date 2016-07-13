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
	07-12-2016 -- jmg -- removed diagnosisID column, as it is no longer needed (diagnosis Table has FK to Clients)
************************************************************************************************************/

-- Declares table variable for Clients.
DECLARE @clients INT = 0
DECLARE @fkn NVARCHAR(50)
DECLARE @databaseName NVARCHAR(50) -- Variable to hold your database's name
DECLARE @dtscript NVARCHAR(255) -- Variable to hold the script, which we will build later, and which drops all constraints for the table you are dropping
    
SET @databaseName = 'eciDB2016'

-- Assigns table ID to @clients variable.
SELECT @clients = (
	SELECT OBJECT_ID
	FROM Sys.Tables
	WHERE name = 'Clients'
)

-- Declares and obtains the column id number for later query to assign foreign key name
DECLARE @col INT = 0
SELECT @col = (
	SELECT column_id
	FROM Sys.Columns AS c
	JOIN Sys.Tables AS t
	ON c.object_id = t.object_id
	WHERE t.object_id = object_id('Clients') AND c.name = 'diagnosisID'
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
	WHERE k.parent_object_id = object_id('Clients') AND k.parent_column_id = @col
	)

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
			officeID INT FOREIGN KEY REFERENCES Office(officeID),
			addressesID INT FOREIGN KEY REFERENCES Addresses(addressesID),
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
			deleted BIT,
			updDate DATETIME
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

		

		IF EXISTS (SELECT * FROM sys.columns WHERE @clients = OBJECT_ID AND name ='updDate')
			BEGIN
				ALTER TABLE Clients ADD CONSTRAINT
				DF_MyTable_Inserted DEFAULT GETDATE() FOR updDate
				PRINT 'Altered updDate column: Added Constraint'
			END
		ELSE
			BEGIN
				ALTER TABLE Clients
					ADD updDate DATETIME DEFAULT (GETDATE()) 
				PRINT 'Added updDate column to Clients table.'
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
				
				WHILE EXISTS(SELECT * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE constraint_name = @fkn)
					BEGIN
						SELECT @dtscript = (
							'ALTER TABLE Clients' + 
							' DROP CONSTRAINT ' + 
							@fkn
							)
						FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS 
						WHERE constraint_catalog = @databaseName and table_name = 'Clients'
						exec sp_executesql @dtscript
					END

				ALTER TABLE Clients
					DROP COLUMN diagnosisID

				PRINT 'Dropped diagnosisID column, no longer needed.'

			END
		ELSE
			BEGIN
				PRINT 'Did not drop diagnosisID column: no longer exists.'
			END

	END