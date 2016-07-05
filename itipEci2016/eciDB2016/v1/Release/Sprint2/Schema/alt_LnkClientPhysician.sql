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
				PRINT 'medicalReceived Column exists.'
			END
		ELSE
			BEGIN
				ALTER TABLE LnkClientPhysician
					ADD medicalReceived BIT
			END

		IF EXISTS (SELECT * FROM sys.columns WHERE OBJECT_ID = @lnkclmd AND name = 'medicalReceivedDate')
			BEGIN
				PRINT 'medicalReceivedDate Column exists.'
			END
		ELSE
			BEGIN
				ALTER TABLE LnkClientPhysician
					ADD medicalReceivedDate DATE
			END

		IF EXISTS (SELECT * FROM sys.columns WHERE OBJECT_ID = @lnkclmd AND name = 'immunizationReceived')
			BEGIN
				PRINT 'immunizationReceived Column exists.'
			END
		ELSE
			BEGIN
				ALTER TABLE LnkClientPhysician
					ADD immunizationReceived BIT
			END

		IF EXISTS (SELECT * FROM sys.columns WHERE OBJECT_ID = @lnkclmd AND name = 'immunizationReceivedDate')
			BEGIN
				PRINT 'immunizationReceivedDate Column exists.'
			END
		ELSE
			BEGIN
				ALTER TABLE LnkClientPhysician
					ADD immunizationReceivedDate DATE
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
				immunizationReceivedDate DATE
			)
	END