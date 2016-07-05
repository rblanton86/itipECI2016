/***********************************************************************************************************
Description: 	
	Adds icd10Code and icd9Code column
Author: 
	Jennifer M. Graves
Date: 
	06-22-2016
Change History:
	06-23-2016 -- jmg -- Drops icd9Code and icd10Code and adds the following columns:
			diagnosisType VARCHAR(15),
			diagnosisCode VARCHAR(15),
			diagnosis VARCHAR(100),
	06-30-2016 -- jmg -- Added diagnosisFrom and diagnosisTo columns, which were missing.
			Corrected if statement
************************************************************************************************************/

-- Declares table variable for diagnosis table
DECLARE @diagnosis INT = 0

-- Assigns table ID to diagnosis variable.
SELECT @diagnosis = (
	SELECT OBJECT_ID
	FROM Sys.Tables
	WHERE name = 'Diagnosis'
)

SELECT @diagnosis

-- Checks if table exists, create table if it doesn't.
IF ISNULL(@diagnosis,0) = 0
	BEGIN
		CREATE TABLE Diagnosis (
			diagnosisID INT IDENTITY(1,1) PRIMARY KEY,
			diagnosis VARCHAR(100),
			diagnosisCode VARCHAR(15),
			diagnosisType VARCHAR(15),
			diagnoisFrom DATE,
			diagnosisTo DATE
		)
	END
-- Because table exists, addes columns for diagnosisType, diagnosisCode and diagnosis.
ELSE
	BEGIN
		IF EXISTS (SELECT * FROM sys.columns WHERE OBJECT_ID = @diagnosis AND name = 'diagnosisType')
			BEGIN
				PRINT 'diagnosisType Column exists.'
			END
		ELSE
			BEGIN
				ALTER TABLE Diagnosis
					ADD diagnosisType VARCHAR(15)
			END

		IF EXISTS (SELECT * FROM sys.columns WHERE OBJECT_ID = @diagnosis AND name = 'diagnosisCode')
			BEGIN
				PRINT 'diagnosisCode Column exists.'
			END
		ELSE
			BEGIN
				ALTER TABLE Diagnosis
					ADD diagnosisCode VARCHAR(15)
			END

		IF EXISTS (SELECT * FROM sys.columns WHERE OBJECT_ID = @diagnosis AND name = 'diagnosis')
			BEGIN
				PRINT 'diagnosis Column exists.'
			END
		ELSE
			BEGIN
				ALTER TABLE Diagnosis
					ADD diagnosis VARCHAR(100)
			END

		IF EXISTS (SELECT * FROM sys.columns WHERE OBJECT_ID = @diagnosis AND name = 'diagnosisFrom')
			BEGIN
				PRINT 'diagnosisFrom Column exists.'
			END
		ELSE
			BEGIN
				ALTER TABLE Diagnosis
					ADD diagnosisFrom DATE
			END

		IF EXISTS (SELECT * FROM sys.columns WHERE OBJECT_ID = @diagnosis AND name = 'diagnosisTo')
			BEGIN
				PRINT 'diagnosisTo Column exists.'
			END
		ELSE
			BEGIN
				ALTER TABLE Diagnosis
					ADD diagnosisTo DATE
			END

		IF EXISTS (SELECT * FROM sys.columns WHERE OBJECT_ID = @diagnosis AND name = 'icd10Code')
			BEGIN
				ALTER TABLE Diagnosis
					DROP COLUMN icd10Code
			END
		ELSE
			BEGIN
				PRINT 'icd10Code Column does not exist.'
			END

		IF EXISTS (SELECT * FROM sys.columns WHERE OBJECT_ID = @diagnosis AND name = 'icd10Code')
			BEGIN
				ALTER TABLE Diagnosis
					DROP COLUMN icd10Code
			END
		ELSE
			BEGIN
				PRINT 'icd10Code Column does not exist.'
			END

		IF EXISTS (SELECT * FROM sys.columns WHERE OBJECT_ID = @diagnosis AND name = 'icd_10_Code')
			BEGIN
				DECLARE @some NVARCHAR(100) = 'UPDATE Diagnosis SET diagnosisCode = icd_10_Code'
				EXEC sp_executesql @some
		
				ALTER TABLE Diagnosis
					DROP COLUMN icd_10_Code
			END
		ELSE
			BEGIN
				PRINT 'icd_10_Code Column does not exist.'
			END

		IF EXISTS (SELECT * FROM sys.columns WHERE OBJECT_ID = @diagnosis AND name = 'diagnosisTypeID')
			BEGIN		
				ALTER TABLE Diagnosis
					DROP COLUMN diagnosisTypeID
			END
		ELSE
			BEGIN
				PRINT 'diagnosisTypeID Column does not exist, unable to remove.'
			END
	END