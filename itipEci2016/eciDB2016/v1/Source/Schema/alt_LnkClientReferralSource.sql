/***********************************************************************************************************
Description: 
		Alters LnkClientsReferralSource and table to add column for specific referral date and referral 
		past due reason.
Author: 
	Jennifer M. Graves
Date: 
	06-23-2016
Change History:
	07-05-2016 -- jmg: Added deleted bit column.
************************************************************************************************************/

-- Declares table variable for linking table.
DECLARE @linkcr INT = 0

-- Assigns the object ID for existing table to newly created variable.
SELECT @linkcr = (
	SELECT OBJECT_ID
	FROM Sys.Tables
	WHERE name = 'LnkClientReferralSource'
)

SELECT @linkcr

-- Checks if table exists and adds if it doesn't.

IF ISNULL(@linkcr,0) = 0
	BEGIN
		CREATE TABLE lnkClientReferralSource (
			clientsID INT FOREIGN KEY REFERENCES Clients(clientsID),
			referralSourceID INT FOREIGN KEY REFERENCES ReferralSource(referralSourceID),
				PRIMARY KEY (clientsID, referralSourceID),
			commentsID INT FOREIGN KEY REFERENCES Comments(commentsID),
			referralPastDueReason VARCHAR(255),
			referralDate DATE,
			updDate DATETIME DEFAULT (GETDATE()),
			deleted BIT
		)

		PRINT 'Added lnkClientReferralSource table to database.'
	END
ELSE
	BEGIN

		-- Checks if referralPastDueReason column exists, alters table to add if it doesn't.
		IF EXISTS (SELECT * FROM sys.columns WHERE @linkcr = OBJECT_ID AND name = 'referralPastDueReason')
			BEGIN
				PRINT 'Skipped: referralPastDueReason column already exists on linkClientReferralSource table.'
			END
		ELSE
			BEGIN
				ALTER TABLE lnkClientReferralSource
					ADD referralPastDueReason VARCHAR(255)

				PRINT 'Added referralPastDueReason to linkClientReferralSource table.'
			END

		-- Checks if referralDate column exists, alters table to add if it doesn't.
		IF EXISTS (SELECT * FROM sys.columns WHERE @linkcr = OBJECT_ID AND name = 'referralDate')
			BEGIN
				PRINT 'Skipped: referralDate column already exists on linkClientReferralSource table.'
			END
		ELSE
			BEGIN
				ALTER TABLE lnkClientReferralSource
					ADD referralDate DATE

				PRINT 'Added referralDate to linkClientReferralSource table.'
			END

		IF EXISTS (SELECT * FROM sys.columns WHERE @linkcr = OBJECT_ID AND name = 'deleted')
			BEGIN
				PRINT 'Unneeded, deleted column exists.'
			END
		ELSE
			BEGIN
				ALTER TABLE lnkClientReferralSource
					ADD deleted BIT
				PRINT 'Added deleted column on lnkClientReferralSource table.'
			END

		
		IF EXISTS (SELECT * FROM sys.columns WHERE @linkcr = OBJECT_ID AND name ='updDate')
			BEGIN
				ALTER TABLE lnkClientReferralSource ADD CONSTRAINT
				DF_MyTable_Inserted DEFAULT GETDATE() FOR updDate
				PRINT 'Altered updDate column: Added Constraint'
			END
		ELSE
			BEGIN
				ALTER TABLE lnkClientReferralSource
					ADD updDate DATETIME DEFAULT (GETDATE())
				PRINT 'Added updDate column to table.'
			END
	END