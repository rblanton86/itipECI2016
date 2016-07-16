/***********************************************************************************************************
Description: 
	Alters InsuranceAuthorization table to change data type on authorized_From and authorized_To to DATE.
Author: 
	Jennifer M. Graves
Date: 
	07-05-2016
Change History:
	07-05-2016: JMG - Altered table to add deleted bit.
	07-14-2016: JMG - Removed comments foreign key, added InsuranceAuthorization table.
************************************************************************************************************/
-- Declares table variable for InsuranceAuthorization.
DECLARE @insa INT = 0
DECLARE @databaseName NVARCHAR(50) -- Variable to hold your database's name
DECLARE @dtscript NVARCHAR(255) -- Variable to hold the script, which we will build later, and which drops all constraints for the table you are dropping

SET @databaseName = 'eciDB2016'

-- Assigns the system table ID to @insa variable for later use.
SELECT @insa = (
	SELECT OBJECT_ID
	FROM sys.tables
	WHERE name = 'InsuranceAuthorization'
)

-- Declares and obtains the column id number for later query to assign foreign key name
DECLARE @col INT = 0
SELECT @col = (
	SELECT column_id
	FROM Sys.Columns AS c
	JOIN Sys.Tables AS t
	ON c.object_id = t.object_id
	WHERE t.object_id = object_id('InsuranceAuthorization') AND c.name = 'commentsID'
	)

-- Assigns a foreign key name for use in later script which will drop the foreign key constraint
DECLARE @fkn NVARCHAR(50)
SELECT @fkn = (
	SELECT f.name
	FROM sys.foreign_keys AS f
	INNER JOIN
		sys.foreign_key_columns AS k
			ON f.object_id = k.constraint_object_id
	INNER JOIN
		sys.tables AS t
			ON t.object_id = k.referenced_object_id
	WHERE k.parent_object_id = object_id('InsuranceAuthorization') AND k.parent_column_id = @col
	)

SELECT @insa

IF ISNULL(@insa,0) = 0
	BEGIN
		CREATE TABLE InsuranceAuthorization (
			insuranceAuthID INT IDENTITY (1,1) PRIMARY KEY (insuranceAuthID),
			insuranceID INT CONSTRAINT FK_InsAuth_Insurance FOREIGN KEY REFERENCES Insurance(insuranceID),
			authorized_From DATE,
			authorized_To DATE,
			insuranceAuthorizationType VARCHAR(25),
			updDate DATETIME DEFAULT (GETDATE()),
			deleted BIT
		)
	END
ELSE
	BEGIN
		IF (SELECT DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'InsuranceAuthorization' AND COLUMN_NAME = 'authorized_From' AND data_type = 'DATE') IS NOT NULL
			BEGIN
				PRINT 'Unneeded: authorized_From Column exists on InsuranceAuthorization table and is correct Data Type.'
			END
		ELSE
			BEGIN
				ALTER TABLE InsuranceAuthorization
					DROP COLUMN authorized_From
				ALTER TABLE InsuranceAuthorization
					ADD authorized_From DATE
				PRINT 'authorized_From table altered to DATE type.'
			END
		
		IF (SELECT DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'InsuranceAuthorization' AND COLUMN_NAME = 'authorized_To' AND data_type = 'DATE') IS NOT NULL
			BEGIN
				PRINT 'Unneeded: authorized_To Column exists on InsuranceAuthorization table and is correct Data Type.'
			END
		ELSE
			BEGIN
				ALTER TABLE InsuranceAuthorization
					DROP COLUMN authorized_To
				ALTER TABLE InsuranceAuthorization
					ADD authorized_To DATE
				PRINT 'authorized_To table altered to DATE type.'
			END

		IF EXISTS (SELECT * FROM sys.columns WHERE @insa = OBJECT_ID AND name = 'deleted')
			BEGIN
				PRINT 'Unneeded, deleted column exists.'
			END
		ELSE
			BEGIN
				ALTER TABLE InsuranceAuthorization
					ADD deleted BIT
				PRINT 'Added deleted column on InsuranceAuthorization table.'
			END

		IF EXISTS (SELECT * FROM sys.columns WHERE @insa = OBJECT_ID AND name ='updDate')
			BEGIN
				--ALTER TABLE InsuranceAuthorization ADD CONSTRAINT
				--DF_MyTable_Inserted DEFAULT GETDATE() FOR updDate
				PRINT 'Altered updDate column: Added Constraint'
			END
		ELSE
			BEGIN
				ALTER TABLE InsuranceAuthorization
					ADD updDate DATETIME DEFAULT (GETDATE())
				PRINT 'Added updDate column to table.'
			END

		IF EXISTS (SELECT * FROM sys.columns WHERE @insa = OBJECT_ID AND name ='commentsID')
			BEGIN
				
				WHILE EXISTS(SELECT * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE constraint_name = @fkn)
					BEGIN
						SELECT @dtscript = (
							'ALTER TABLE InsuranceAuthorization' + 
							' DROP CONSTRAINT ' + 
							@fkn
							)
						FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS 
						WHERE constraint_catalog = @databaseName and table_name = 'InsuranceAuthorization'
						exec sp_executesql @dtscript
					END

				ALTER TABLE InsuranceAuthorization
					DROP COLUMN commentsID

				PRINT 'Dropped commentsID column, no longer needed.'

			END
		ELSE
			BEGIN
				PRINT 'Did not drop commentsID column: no longer exists.'
			END

		IF EXISTS (SELECT * FROM sys.columns WHERE @insa = OBJECT_ID AND name = 'insuranceID')
			BEGIN
				PRINT 'Unneeded, insuranceID column exists.'
			END
		ELSE
			BEGIN
				ALTER TABLE InsuranceAuthorization
					ADD insuranceID INT CONSTRAINT FK_InsAuth_Insurance FOREIGN KEY REFERENCES Insurance(insuranceID)
				PRINT 'Added insuranceID column on InsuranceAuthorization table.'
			END
	END