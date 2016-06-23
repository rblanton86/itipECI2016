/***********************************************************************************************************
Description: 	
	Copies info from icd_10 to icd10 column and drops icd_10
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

IF EXISTS (SELECT * FROM sys.columns WHERE @diagnosis = OBJECT_ID AND name = 'icd_10_Code')
	BEGIN
		UPDATE Diagnosis
		SET icd10Code = icd_10_Code

	ALTER TABLE Diagnosis
		DROP COLUMN icd_10_Code
	END