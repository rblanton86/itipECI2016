/***********************************************************************************************************
Description: 
	Alters InsuranceAuthorization table to change data type on authorized_From and authorized_To to DATE.
Author: 
	Jennifer M. Graves
Date: 
	07-05-2016
Change History:
	07-05-2016 -- jmg: Altered table to add deleted bit.
************************************************************************************************************/
-- Declares table variable for InsuranceAuthorization.
DECLARE @insa INT = 0

-- Assigns the system table ID to @clients variable for later use.
SELECT @insa = (
	SELECT OBJECT_ID
	FROM sys.tables
	WHERE name = 'InsuranceAuthorization'
)

SELECT @insa

IF ISNULL(@insa,0) = 0
	BEGIN
		CREATE TABLE InsuranceAuthorization (
			insuranceAuthID INT IDENTITY (1,1) PRIMARY KEY (insuranceAuthID),
			commentsID INT FOREIGN KEY REFERENCES Comments(commentsID),
			authorized_From DATE,
			authorized_To DATE,
			insuranceAuthorizationType VARCHAR(25),
			deleted BIT
		)
	END
ELSE
	BEGIN
		IF (SELECT DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'InsuranceAuthorization' AND COLUMN_NAME = 'authorized_From' AND data_type = 'DATE') IS NOT NULL
			BEGIN
				PRINT 'Unneeded: authorized_From Column exists on Clients table and is correct Data Type.'
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
				PRINT 'Unneeded: authorized_To Column exists on Clients table and is correct Data Type.'
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
				PRINT 'Added deleted column on Clients table.'
			END
	END