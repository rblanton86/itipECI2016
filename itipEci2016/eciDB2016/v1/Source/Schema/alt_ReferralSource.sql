/****************************************************************************
Description: Alters ReferralSource table.

Author: Jennifer M Graves

Date: 07-05-2016

Change History:
		07-05-2016 -- jmg: Added deleted bit column to table.
****************************************************************************/

-- Declares the table variable for ReferralSource
DECLARE @rs INT = 0

-- Assigns the system table ID to @rs variable for later use.
SELECT @rs = (
	SELECT OBJECT_ID
	FROM sys.tables
	WHERE name = 'ReferralSource'
)

SELECT @rs

-- Checks if table exists.
IF ISNULL(@rs, 0) = 0
	BEGIN
		--Creates ReferralSource table if it doesn't exist.
		CREATE TABLE ReferralSource (
			referralSourceID INT IDENTITY(1,1) PRIMARY KEY(referralSourceID),
			additionalContactInfoID INT CONSTRAINT FK_referralSource_contactInfo FOREIGN KEY REFERENCES AdditionalContactInfo(additionalContactInfoID),
			referralSourceTypeID INT CONSTRAINT FK_referralSource_referralSourceType FOREIGN KEY REFERENCES ReferralSourceType(referralSourceTypeID),
			addressesID INT CONSTRAINT FK_referralSource_addresses FOREIGN KEY REFERENCES Addresses(addressesID),
			referralSource VARCHAR(50),
			updDate DATETIME DEFAULT (GETDATE()),
			deleted BIT
		)

		PRINT 'Added ReferralSource table to database.'
	END
ELSE
	BEGIN
		-- Checks if deleted column exists.
		IF EXISTS (SELECT * FROM sys.columns WHERE @rs = OBJECT_ID AND name = 'deleted')
			BEGIN
				-- Advises DBA no column added, as already exists.
				PRINT 'Unneeded: deleted column exists.'
			END
		ELSE
			BEGIN
				-- Creates column, advises DBA.
				ALTER TABLE ReferralSource
					ADD deleted BIT
				PRINT 'Added deleted column on ReferralSource table.'
			END

		IF EXISTS (SELECT * FROM sys.columns WHERE @rs = OBJECT_ID AND name ='memberTypeID')
			BEGIN
				PRINT 'memberTypeID already exists'
			END
		ELSE
			BEGIN
				ALTER TABLE ReferralSource
					ADD memberTypeID INT FOREIGN KEY REFERENCES MemberType(memberTypeID)
				PRINT 'Added memberTypeID column to table.'
			END


		IF EXISTS (SELECT * FROM sys.columns WHERE @rs = OBJECT_ID AND name ='updDate')
			BEGIN
				ALTER TABLE ReferralSource ADD CONSTRAINT
				DF_MyTable_Inserted DEFAULT GETDATE() FOR updDate
				PRINT 'Altered updDate column: Added Constraint'
			END
		ELSE
			BEGIN
				ALTER TABLE ReferralSource
					ADD updDate DATETIME DEFAULT (GETDATE())
				PRINT 'Added updDate column to table.'
			END

		IF EXISTS (SELECT * FROM sys.columns WHERE @rs = OBJECT_ID AND name ='referralSource')
			BEGIN
				PRINT 'Unneeded: referralSource column exists.'
			END
		ELSE
			BEGIN
				ALTER TABLE ReferralSource
					ADD referralSource VARCHAR(50)
				PRINT 'Added referralSource column to table.'
			END
	END