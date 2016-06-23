/***********************************************************************************************************
Description: 
	Alters client table to add additional columns pulled from Unknown Client tables.
Author: 
	Jennifer M. Graves
Date: 
	06-22-2016
Change History:
	
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

IF @clients = 0
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
				ALTER TABLE Clients
					DROP COLUMN dob
				ALTER TABLE Clients
					ADD dob DATE
				PRINT 'dob column on Clients table altered to DATE type.'
			END
		ELSE
			BEGIN
				ALTER TABLE Clients
					ADD dob DATE
				PRINT 'Added dob column on Clients table.'
			END

		IF EXISTS (SELECT * FROM sys.columns WHERE @clients = OBJECT_ID AND name = 'intakeDate')
			BEGIN
				RETURN
				PRINT 'intakeDate column on Clients table already exists.'
			END
		ELSE
			BEGIN
				ALTER TABLE Clients
					ADD intakeDate DATETIME
				PRINT 'intakeDate column on Clients table added.'
			END
		IF EXISTS (SELECT * FROM sys.columns WHERE @clients = OBJECT_ID AND name = 'ifspDate')
			BEGIN
				RETURN
				PRINT 'ifspDate column on Clients table already exists.'
			END
		ELSE
			BEGIN
				ALTER TABLE Clients
					ADD ifspDate DATE
				PRINT 'ifspDate column on Clients table added.'
			END
		IF EXISTS (SELECT * FROM sys.columns WHERE @clients = OBJECT_ID AND name = 'compSvcDate')
			BEGIN
				RETURN
				PRINT 'compSvcDate column on Clients table already exists.'
			END
		ELSE
			BEGIN
				ALTER TABLE Clients
					ADD compSvcDate DATE
				PRINT 'compSvcDate column on Clients table added.'
			END
	END