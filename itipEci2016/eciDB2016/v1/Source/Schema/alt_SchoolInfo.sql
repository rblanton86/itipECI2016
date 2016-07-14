/***********************************************************************************************************
Description: 
		Alters ISD column from integer to string
Author: 
		Jennifer M. Graves
Date: 
		06-22-2016
Change History:
		
************************************************************************************************************/
	
-- Declares table variable for addresses table
DECLARE @schoolInfo INT = 0

-- Assigns table ID to addresses variable.
SELECT @schoolInfo = (
	SELECT OBJECT_ID
	FROM Sys.Tables
	WHERE name = 'SchoolInformation'
)

SELECT @schoolInfo

-- Checks if school info table exists, creates table if it doesn't.
IF ISNULL(@schoolInfo, 0) = 0
	BEGIN
		CREATE TABLE SchoolInformation (
			schoolInfoID INT IDENTITY (1,1) PRIMARY KEY,
			isd VARCHAR(25),
			updDate DATETIME DEFAULT (GETDATE())
		)
	END
ELSE
	BEGIN
		-- Checks if isd column exists, alters table to add if it doesn't.
		IF EXISTS (SELECT * FROM sys.columns WHERE @schoolInfo = OBJECT_ID AND name = 'isd')
			BEGIN
				ALTER TABLE SchoolInformation
					ALTER COLUMN isd VARCHAR(25)
			END
		ELSE
			BEGIN
				ALTER TABLE SchoolInformation
					ADD isd VARCHAR(25)
			END

		IF EXISTS (SELECT * FROM sys.columns WHERE @schoolInfo = OBJECT_ID AND name ='updDate')
			BEGIN
				ALTER TABLE SchoolInformation ADD CONSTRAINT
				DF_MyTable_Inserted DEFAULT GETDATE() FOR updDate
				PRINT 'Altered updDate column: Added Constraint'
			END
		ELSE
			BEGIN
				ALTER TABLE SchoolInformation
					ADD updDate DATETIME DEFAULT (GETDATE())
				PRINT 'Added updDate column to table.'
			END
	END