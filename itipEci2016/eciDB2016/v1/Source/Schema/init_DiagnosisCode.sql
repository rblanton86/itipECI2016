/****************************************************************************
Description: Initiates the DiagnosisCode table.

Author: Jennifer M Graves

Date: 07-12-2016

Change History:
****************************************************************************/

IF EXISTS (SELECT * FROM sys.tables WHERE name = 'DiagnosisCode')
	BEGIN
		PRINT 'This table already exists.'
	END
ELSE
	BEGIN
		CREATE TABLE DiagnosisCode (
			diagnosisCodeID INT IDENTITY (1,1) PRIMARY KEY,
			diagnosisCode VARCHAR(10),
			diagnosisDescription VARCHAR(100)
		)
	END