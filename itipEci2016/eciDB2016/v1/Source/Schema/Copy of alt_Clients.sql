/***********************************************************************************************************
Description: 
	Alters client table to add additional columns pulled from Unknown Client tables.
Author: 
	Jennifer M. Graves
Date: 
	06-22-2016
Change History:
	06-30-2016 -- jmg: Corrected if statement
************************************************************************************************************/

-- Declares table variable for Clients.
DECLARE @clients INT = 0

-- Assigns the system table ID to @clients variable for later use.
SELECT @clients = (
	SELECT OBJECT_ID
	FROM sys.tables
	WHERE name = 'Clients'
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
			diagnosisID INT FOREIGN KEY REFERENCES Diagnosis(diagnosisID),
			primaryLanguageID INT FOREIGN KEY REFERENCES PrimaryLanguage(primaryLanguageID),
			schoolInfoID INT FOREIGN KEY REFERENCES SchoolInformation(schoolInfoID),
			commentsID INT FOREIGN KEY REFERENCES Comments(commentsID),
			insuranceAuthID INT FOREIGN KEY REFERENCES InsuranceAuthorization(insuranceAuthID),
			communicationPreferencesID INT FOREIGN KEY REFERENCES CommunicationPreferences(communicationPreferencesID),
			sexID INT FOREIGN KEY REFERENCES Sex(sexID),
			firstName VARCHAR(25),
			lastName VARCHAR(25),
			dob DATE,
			ssn INT,
			referralSource VARCHAR(50),
			intakeDate DATETIME,
			ifspDate DATE,
			compSvcDate DATE,
		)
	END
ELSE
	BEGIN
		
		IF EXISTS (SELECT * FROM sys.columns WHERE @clients = OBJECT_ID AND name = 'dob')
			BEGIN
				IF (SELECT DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Clients' AND COLUMN_NAME = 'dob' AND data_type = 'DATE') IS NOT NULL
					BEGIN
						PRINT 'Unneeded: dob Column exists on Clients table and is correct Data Type.'
					END
				ELSE
					BEGIN
						ALTER TABLE Clients
							DROP COLUMN dob
						ALTER TABLE Clients
							ADD dob DATE
						PRINT 'dob column on Clients table altered to DATE type.'
					END
			END
		ELSE
			BEGIN
				ALTER TABLE Clients
					ADD dob DATE
				PRINT 'Added dob column on Clients table.'
			END

		IF EXISTS (SELECT * FROM sys.columns WHERE @clients = OBJECT_ID AND name = 'intakeDate')
			BEGIN
				PRINT 'Unneeded: intakeDate column on Clients table already exists.'
			END
		ELSE
			BEGIN
				ALTER TABLE Clients
					ADD intakeDate DATETIME
				PRINT 'Added intakeDate column on Clients table.'
			END

		IF EXISTS (SELECT * FROM sys.columns WHERE @clients = OBJECT_ID AND name = 'ifspDate')
			BEGIN
				PRINT 'Unneeded: ifspDate column on Clients table already exists.'
			END
		ELSE
			BEGIN
				ALTER TABLE Clients
					ADD ifspDate DATE
				PRINT 'Added ifspDate column on Clients table.'
			END

		IF EXISTS (SELECT * FROM sys.columns WHERE @clients = OBJECT_ID AND name = 'compSvcDate')
			BEGIN
				PRINT 'Unneeded: compSvcDate column on Clients table already exists.'
			END
		ELSE
			BEGIN
				ALTER TABLE Clients
					ADD compSvcDate DATE
				PRINT 'Added compSvcDate column on Clients table.'
			END

		IF EXISTS (SELECT * FROM sys.columns WHERE @clients = OBJECT_ID AND name = 'sexID')
			BEGIN
				PRINT 'Unneeded: sexID already exists.'
			END
		ELSE
			BEGIN
				ALTER TABLE Clients
					ADD sexID INT FOREIGN KEY REFERENCES Sex(sexID)
				PRINT 'Added sexID column on Clients table.'
			END
	END