/****************************************************************************
Description: Alter Diagnosis table.

Author: Jennifer M Graves

Date: 07-05-2016

Change History:
		07-05-2016 -- jmg: Added deleted bit column to table.
****************************************************************************/

-- Declares the table variable for Diagnosis
DECLARE @dx INT = 0

-- Assigns the system table ID to @dx variable for later use.
SELECT @dx = (
	SELECT OBJECT_ID
	FROM sys.tables
	WHERE name = 'Diagnosis'
)

SELECT @dx

-- Checks if table exists.
IF ISNULL(@dx, 0) = 0
	BEGIN
		--Creates Diagnosis table if it doesn't exist.
		CREATE TABLE Diagnosis (
			DiagnosisID INT IDENTITY(1,1) PRIMARY KEY(DiagnosisID),
			diagnosisType VARCHAR(15),
			diagnosisCode VARCHAR(15),
			diagnosis VARCHAR(100),
			diagnosis_From DATE,
			diagnosis_To DATE,
			deleted BIT
		)

		PRINT 'Added Diagnosis table to database.'
	END
ELSE
	BEGIN
		-- Checks if deleted column exists.
		IF EXISTS (SELECT * FROM sys.columns WHERE @dx = OBJECT_ID AND name = 'deleted')
			BEGIN
				-- Advises DBA no column added, as already exists.
				PRINT 'Unneeded: deleted column exists.'
			END
		ELSE
			BEGIN
				-- Creates column, advises DBA.
				ALTER TABLE Diagnosis
					ADD deleted BIT
				PRINT 'Added deleted column on Diagnosis table.'
			END
	END