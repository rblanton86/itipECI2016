/****************************************************************************
Description: Drips the diagnosisType table.
	
Author: Jennifer M Graves
	
Date: 06-30-2016
	
Change History:
	
****************************************************************************/


-- Declares variables for DiagnosisType table object_id number
DECLARE @diagt INT = 0

-- Declares variable to hold name and ID of the parent table holding foreign key of Diagnosis Type
DECLARE @pt NVARCHAR(50)
DECLARE @pid INT = 0

-- Declares a variable to hold the foreign key name
DECLARE @fkn NVARCHAR(50)

-- Declares variable to hold script for dropping foreign key constraint
DECLARE @dtscript NVARCHAR(255)

-- Holds database name.
DECLARE @database NVARCHAR(50)
SET @database = 'eciDB2016'

SELECT @diagt = (
	SELECT object_id
	FROM Sys.Tables
	WHERE name = 'DiagnosisType'
)

SELECT @fkn = (
	SELECT name
	FROM sys.foreign_keys
	WHERE referenced_object_id = object_id('DiagnosisType')
)

SELECT @pid = (
	SELECT parent_object_id
	FROM sys.foreign_keys
	WHERE referenced_object_id = object_id('DiagnosisType')
)

SELECT @pt = (
	SELECT name
	FROM sys.tables
	WHERE object_id = @pid
)

SELECT @diagt

IF ISNULL(@diagt, 0) = 0
	BEGIN
		PRINT 'Unneeded: The diagnosis table has already been removed.'
	END
ELSE
	BEGIN
		-- Drops foreign key constraint when identified.
		WHILE EXISTS(select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where constraint_catalog = @database and table_name = @pt)
			BEGIN
				SELECT @dtscript = (
					'ALTER TABLE ' + 
					@pt + 
					' DROP CONSTRAINT ' + 
					@fkn
					)
				FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS 
				WHERE constraint_catalog = @database and table_name = @pt
				exec sp_executesql @dtscript
			END

		-- Drops table.
		DROP TABLE DiagnosisType
	END