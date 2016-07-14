/****************************************************************************
Description: Alter staffType table.

Author: Tyrell Powers-Crane

Date: 
	7.12.2016
Change History:
		
****************************************************************************/

-- Declares the table variable for additionalContactInfo
DECLARE @aci INT = 0

-- Assigns the system table ID to @aci variable for later use.
SELECT @aci = (
	SELECT OBJECT_ID
	FROM sys.tables
	WHERE name = 'StaffType'
)

SELECT @aci

-- Checks if table exists.
IF ISNULL(@aci, 0) = 0
	BEGIN
		--Creates additionalContactInfo table if it doesn't exist.
		CREATE TABLE StaffType (
			staffTypeID INT IDENTITY (1,1) PRIMARY KEY (staffTypeID),
			staffType VARCHAR(25) NULL,
			updDate DATETIME DEFAULT (GETDATE()) 
			)
		

		PRINT 'Added staffType table to database.'
	END
ELSE
	BEGIN
		-- Checks if deleted column exists.
		IF EXISTS (SELECT * FROM sys.columns WHERE @aci = OBJECT_ID AND name = 'staffType')
			BEGIN
					ALTER TABLE StaffType
					ALTER COLUMN staffType VARCHAR(25) null
					PRINT 'Altered staffType'
			END
		ELSE
			BEGIN
				
				ALTER TABLE StaffType
					ADD staffType VARCHAR(25) null
				PRINT 'Added staffType column'
			END

		IF EXISTS (SELECT * FROM sys.columns WHERE @aci = OBJECT_ID AND name ='updDate')
			BEGIN
				ALTER TABLE StaffType ADD CONSTRAINT
				DF_MyTable_Inserted DEFAULT GETDATE() FOR updDate
				PRINT 'Altered updDate column: Added Constraint'
			END
		ELSE
			BEGIN
				ALTER TABLE StaffType
					ADD updDate DATETIME DEFAULT (GETDATE()) 
				PRINT 'Added updDate column to table.'
			END
	END