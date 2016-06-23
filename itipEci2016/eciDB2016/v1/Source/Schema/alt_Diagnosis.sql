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
IF ISNULL((SELECT column_id FROM Sys.Columns WHERE @diagnosis = OBJECT_ID AND name = 'icd_10_Code'), 0) > 0
	BEGIN
		DECLARE @some NVARCHAR(100) = 'UPDATE Diagnosis SET icd10Code = icd_10_Code'
		EXEC sp_executesql @some
		
		--ALTER TABLE Diagnosis
		--	DROP COLUMN icd_10_Code
		PRINT 'Hello'
	END
ELSE
	BEGIN
		PRINT 'Run initDiagnosis script.'
	END