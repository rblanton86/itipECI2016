/***********************************************************************************************************
Description: 
	Creates new columns for Client/Physician linking table
		MedicalChk ---> COLUMN NAME 'medicalReceived' to LnkClientPhysician table --bit
		MedicalChkDate ---> COLUMN NAME 'medicalReceivedDate' to LnkClientPhysician table --DateTime
		ImmunChk ---> COLUMN NAME 'immunizationReceived' to LnkClientPhysician table --bit
		NULL ---> COLUMN NAME 'immunizationReceivedDate' to LnkClientPhysician table --DateTime
Author: 
	Jennifer M. Graves
Date: 
	6.23.2016
Change History:
	07-05-2016 -- jmg: Added deleted column to linking table.
************************************************************************************************************/


-- Declares table variable for LnkClientPhysician table
DECLARE @lnkclmd INT = 0

-- Assigns table ID to LnkClientPhysician variable.
SELECT @lnkclmd = (
	SELECT OBJECT_ID
	FROM Sys.Tables
	WHERE name = 'LnkClientPhysician'
)

SELECT @lnkclmd

-- Checks if table exists, create table if it doesn't.
IF ISNULL(@lnkclmd, 0) > 0
	BEGIN
		
		IF EXISTS (SELECT * FROM sys.columns WHERE OBJECT_ID = @lnkclmd AND name = 'medicalReceived')
			BEGIN
				PRINT 'Skipped: medicalReceived Column exists.'
			END
		ELSE
			BEGIN
				ALTER TABLE LnkClientPhysician
					ADD medicalReceived BIT

				PRINT 'Added medicalReceived column to the LnkClientPhysician table.'
			END

		IF EXISTS (SELECT * FROM sys.columns WHERE OBJECT_ID = @lnkclmd AND name = 'medicalReceivedDate')
			BEGIN
				PRINT 'Skipped: medicalReceivedDate Column exists.'
			END
		ELSE
			BEGIN
				ALTER TABLE LnkClientPhysician
					ADD medicalReceivedDate DATE

				PRINT 'Added medicalReceivedDate column to the LnkClientPhysician table.'
			END

		IF EXISTS (SELECT * FROM sys.columns WHERE OBJECT_ID = @lnkclmd AND name = 'immunizationReceived')
			BEGIN
				PRINT 'Skipped: immunizationReceived Column exists.'
			END
		ELSE
			BEGIN
				ALTER TABLE LnkClientPhysician
					ADD immunizationReceived BIT

				PRINT 'Added immunizationReceived column to the LnkClientPhysician table.'
			END

		IF EXISTS (SELECT * FROM sys.columns WHERE OBJECT_ID = @lnkclmd AND name = 'immunizationReceivedDate')
			BEGIN
				PRINT 'Skipped: immunizationReceivedDate Column exists.'
			END
		ELSE
			BEGIN
				ALTER TABLE LnkClientPhysician
					ADD immunizationReceivedDate DATE
				
				PRINT 'Added immunizationReceivedDate column to the LnkClientPhysician table.'
			END

		IF EXISTS (SELECT * FROM sys.columns WHERE @lnkclmd = OBJECT_ID AND name = 'deleted')
			BEGIN
				PRINT 'Skipped: deleted column exists.'
			END
		ELSE
			BEGIN
				ALTER TABLE LnkClientPhysician
					ADD deleted BIT
				PRINT 'Added deleted column on LnkClientPhysician table.'
			END
		
		IF EXISTS (SELECT * FROM sys.columns WHERE @lnkclmd = OBJECT_ID AND name ='updDate')
			BEGIN
				ALTER TABLE LnkClientPhysician ADD CONSTRAINT
				DF_MyTable_Inserted DEFAULT GETDATE() FOR updDate
				PRINT 'Altered updDate column: Added Constraint'
			END
		ELSE
			BEGIN
				ALTER TABLE LnkClientPhysician
					ADD updDate DATETIME DEFAULT (GETDATE())
				PRINT 'Added updDate column to table.'
			END
	END

-- If table exists, addes columns for LnkClientPhysicianType, LnkClientPhysicianCode and LnkClientPhysician.
ELSE
	BEGIN
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

		PRINT 'Created LnkClientPhysician table.'
	END