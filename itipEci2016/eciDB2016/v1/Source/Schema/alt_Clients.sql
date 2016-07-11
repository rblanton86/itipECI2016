/***********************************************************************************************************
Description: 
	Alters client table to add altID and deleted column for clients.
Author: 
	Jennifer M. Graves
Date: 
	07-05-2016
Change History:
	07-05-2016 -- jmg -- added middleInitial column.
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
			middleInitial VARCHAR(1),
			lastName VARCHAR(25),
			dob DATE,
			ssn INT,
			altID VARCHAR(25),
			referralSource VARCHAR(50),
			intakeDate DATETIME,
			ifspDate DATE,
			compSvcDate DATE,
			deleted BIT
		)
	END
ELSE
	BEGIN
		
		IF EXISTS (SELECT * FROM sys.columns WHERE @clients = OBJECT_ID AND name = 'altID')
			BEGIN
				PRINT 'Unneeded, altID column exists.'
			END
		ELSE
			BEGIN
				ALTER TABLE Clients
					ADD altID VARCHAR(25)
				PRINT 'Added altID column on Clients table.'
			END

		IF EXISTS (SELECT * FROM sys.columns WHERE @clients = OBJECT_ID AND name = 'deleted')
			BEGIN
				PRINT 'Unneeded, deleted column exists.'
			END
		ELSE
			BEGIN
				ALTER TABLE Clients
					ADD deleted BIT
				PRINT 'Added deleted column on Clients table.'
			END

		IF EXISTS (SELECT * FROM sys.columns WHERE @clients = OBJECT_ID AND name = 'middleInitial')
			BEGIN
				PRINT 'Unneeded, middleInitial column exists.'
			END
		ELSE
			BEGIN
				ALTER TABLE Clients
					ADD middleInitial VARCHAR(1)
				PRINT 'Added middleInitial column on Clients table.'
			END

		IF EXISTS (SELECT * FROM sys.columns WHERE @clients = OBJECT_ID AND name = 'sexID')
		BEGIN
			PRINT 'Unneeded, sexID column exists.'
		END
	ELSE
		BEGIN
			ALTER TABLE Clients
				ADD sexID INT FOREIGN KEY REFERENCES Sex(sexID)
			PRINT 'Added sexID column on Clients table.'
		END
	END