/****************************************************************************
Description: Initiates the DiagnosisType table.

Author: Jennifer M Graves

Date: 07-12-2016

Change History:
****************************************************************************/

IF EXISTS (SELECT * FROM sys.tables WHERE name = 'DiagnosisType')
	BEGIN
		PRINT 'DiagnosisType table already exists.'
	END
ELSE
	BEGIN
		-- Creates table
		CREATE TABLE DiagnosisType (
			diagnosisTypeID INT IDENTITY (1,1) PRIMARY KEY,
			diagnosisType VARCHAR(10)
		)

		-- Inserts table values
		INSERT INTO DiagnosisType (diagnosisType)
			VALUES ('icd9'), ('icd10')
	END