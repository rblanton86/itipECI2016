/***********************************************************************************************************
Description: 
	Alters the colument icd_10_Code to read icd10Code and adds column for icd9Code
Author: 
	Jennifer M. Graves
Date: 
	06-22-2016
Change History:
	
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
IF @diagnosis = 0
	BEGIN
		CREATE TABLE Diagnosis (
			diagnosisID INT IDENTITY(1,1) PRIMARY KEY,
			diagnosisTypeID INT FOREIGN KEY REFERENCES DiagnosisTypeID(diagnosisTypeID),
			icd10Code VARCHAR(15),
			icd9Code VARCHAR(15),
		)
	END
ELSE
	BEGIN
		-- Checks if icd10 column exists, alters table to add if it doesn't.
		IF EXISTS (SELECT * FROM sys.columns WHERE @diagnosis = OBJECT_ID AND (name = 'icd10Code' OR name = 'icd9Code'))
			BEGIN
				RETURN
			END
		ELSE
			BEGIN
				ALTER TABLE Diagnosis
					ADD icd10Code VARCHAR(15)
					ADD icd9Code VARCHAR(15)
			END
	END