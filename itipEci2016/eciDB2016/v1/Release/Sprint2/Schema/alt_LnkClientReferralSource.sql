/***********************************************************************************************************
Description: 
		Alters LnkClientsReferralSource and table to add column for specific referral date and referral 
		past due reason.
Author: 
	Jennifer M. Graves
Date: 
	06-23-2016
Change History:
		
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
		)
	END
ELSE
	BEGIN

		-- Checks if referralPastDueReason column exists, alters table to add if it doesn't.
		IF EXISTS (SELECT * FROM sys.columns WHERE @linkcr = OBJECT_ID AND name = 'referralPastDueReason')
			BEGIN
				PRINT 'referralPastDueReason column already exists on linkClientReferralSource table.'
				RETURN
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
				PRINT 'referralDate column already exists on linkClientReferralSource table.'
				RETURN
			END
		ELSE
			BEGIN
				ALTER TABLE lnkClientReferralSource
					ADD referralDate DATE

				PRINT 'Added referralDate to linkClientReferralSource table.'
			END
	END