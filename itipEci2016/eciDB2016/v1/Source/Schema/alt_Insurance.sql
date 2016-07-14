﻿/****************************************************************************
Description: Alter Insurance table.

Author: Jennifer M Graves

Date: 07-05-2016

Change History:
		07-05-2016 -- jmg: Added deleted bit column to table.
****************************************************************************/

-- Declares the table variable for Insurance
DECLARE @ins INT = 0

-- Assigns the system table ID to @ins variable for later use.
SELECT @ins = (
	SELECT OBJECT_ID
	FROM sys.tables
	WHERE name = 'Insurance'
)

SELECT @ins

-- Checks if table exists.
IF ISNULL(@ins, 0) = 0
	BEGIN
		--Creates Insurance table if it doesn't exist.
		CREATE TABLE Insurance (
			insuranceID INT IDENTITY(1,1) PRIMARY KEY(insuranceID),
			insuranceName VARCHAR(75),
			insurancePolicyID VARCHAR(75),
			medPreAuthNumber VARCHAR(100),
			updDate DATETIME DEFAULT (GETDATE()),
			deleted BIT
		)

		PRINT 'Added Insurance table to database.'
	END
ELSE
	BEGIN
		-- Checks if deleted column exists.
		IF EXISTS (SELECT * FROM sys.columns WHERE @ins = OBJECT_ID AND name = 'deleted')
			BEGIN
				-- Advises DBA no column added, as already exists.
				PRINT 'Unneeded: deleted column exists.'
			END
		ELSE
			BEGIN
				-- Creates column, advises DBA.
				ALTER TABLE Insurance
					ADD deleted BIT
				PRINT 'Added deleted column on Insurance table.'
			END

		IF EXISTS (SELECT * FROM sys.columns WHERE @ins = OBJECT_ID AND name ='updDate')
			BEGIN
				ALTER TABLE Insurance ADD CONSTRAINT
				DF_MyTable_Inserted DEFAULT GETDATE() FOR updDate
				PRINT 'Altered updDate column: Added Constraint'
			END
		ELSE
			BEGIN
				ALTER TABLE Insurance
					ADD updDate DATETIME DEFAULT (GETDATE())
				PRINT 'Added updDate column to table.'
			END
	END