/****************************************************************************
Description: Alter AdditionalContactInfo table.

Author: Jennifer M Graves

Date: 07-05-2016

Change History:
		07-05-2016: JMG - Added deleted bit column to table.
		07-21-2016: JMG - Added memberID column.
****************************************************************************/

-- Declares the table variable for additionalContactInfo
DECLARE @aci INT = 0

-- Assigns the system table ID to @aci variable for later use.
SELECT @aci = (
	SELECT OBJECT_ID
	FROM sys.tables
	WHERE name = 'AdditionalContactInfo'
)

SELECT @aci

-- Checks if table exists.
IF ISNULL(@aci, 0) = 0
	BEGIN
		--Creates additionalContactInfo table if it doesn't exist.
		CREATE TABLE AdditionalContactInfo (
			additionalContactInfoID INT IDENTITY(1,1) PRIMARY KEY(additionalContactInfoID),
			memberTypeID INT NOT NULL CONSTRAINT FK_clients_members FOREIGN KEY REFERENCES MemberType(memberTypeID),
			memberID INT,
			additionalContactInfoTypeID INT NOT NULL CONSTRAINT FK_clients_aciid FOREIGN KEY REFERENCES AdditionalContactInfoType(additionalContactInfoTypeID),
			additionalContactInfo VARCHAR(255),
			updDate DATETIME DEFAULT (GETDATE()),
			deleted BIT
		)

		PRINT 'Added AdditionalContactInfo table to database.'
	END
ELSE
	BEGIN
		-- Checks if deleted column exists.
		IF EXISTS (SELECT * FROM sys.columns WHERE @aci = OBJECT_ID AND name = 'deleted')
			BEGIN
				-- Advises DBA no column added, as already exists.
				PRINT 'Unneeded: deleted column exists.'
			END
		ELSE
			BEGIN
				-- Creates column, advises DBA.
				ALTER TABLE AdditionalContactInfo
					ADD deleted BIT
				PRINT 'Added deleted column on AdditionalContactInfo table.'
			END

		IF EXISTS (SELECT * FROM sys.columns WHERE @aci = OBJECT_ID AND name = 'updDate')
			BEGIN

		-- Checks if memberID column exists.
		IF EXISTS (SELECT * FROM sys.columns WHERE @aci = OBJECT_ID AND name = 'memberID')
			BEGIN
				-- Advises DBA no column added, as already exists.
				PRINT 'Unneeded: memberID column exists.'
			END
		ELSE
			BEGIN
				-- Creates column, advises DBA.
				ALTER TABLE AdditionalContactInfo
					ADD memberID INT
				PRINT 'Added memberID column on AdditionalContactInfo table.'
			END

		IF EXISTS (SELECT * FROM INFORMATION_SCHEMA WHERE CONSTRAINT_NAME = 'DF_MyTable_Inserted')
					BEGIN
						PRINT 'updDate Column not added or updated, exists and is correct.'
					END
				ELSE
					BEGIN
						ALTER TABLE AdditionalContactInfo ADD CONSTRAINT
							DF_MyTable_Inserted DEFAULT GETDATE() FOR updDate
						PRINT 'Altered updDate column: Added Constraint'
					END
			END
		ELSE
			BEGIN
				ALTER TABLE AdditionalContactInfo
					ADD updDate DATETIME DEFAULT (GETDATE()) 
				PRINT 'Added updDate column to aci table.'
			END
	END