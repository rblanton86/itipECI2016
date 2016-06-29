/***********************************************************************************************************
Description: 
		Alters additionalContactInfo column on FamilyMember table to additionalContactInfoID
Author: 
		Jennifer M. Graves
Date: 
		06-23-2016
Change History:
		
************************************************************************************************************/
	
-- Declares table variable for aci table
DECLARE @fm INT = 0

-- Assigns table ID to aci variable.
SELECT @fm = (
	SELECT OBJECT_ID
	FROM Sys.Tables
	WHERE name = 'FamilyMember'
)

SELECT @fm

-- Checks if additional contact info table exists, creates if it doesn't..
IF @fm = 0
	BEGIN
		CREATE TABLE FamilyMember (
			familyMemberID INT IDENTITY (1,1) PRIMARY KEY,
			familyMemberTypeID INT FOREIGN KEY REFERENCES FamilyMemberType(familyMemberTypeID),
			additionalContactInfoID INT FOREIGN KEY REFERENCES AdditionalContactInfo(additionalContactInfoID),
			sexID INT FOREIGN KEY REFERENCES Sex(sexID),
			firstName VARCHAR(25),
			lastName VARCHAR(25),
			isGuardian BIT
		)
	END
ELSE
	BEGIN
		-- Checks if additionalContactInfo column exists, alters table to add if it doesn't.
		IF EXISTS (SELECT * FROM sys.columns WHERE @fm = OBJECT_ID AND name = 'additionalContactInfoID')
			BEGIN
				RETURN
			END
		ELSE
			BEGIN
				ALTER TABLE FamilyMember
					ADD additionalContactInfoID INT FOREIGN KEY REFERENCES AdditionalContactInfo(additionalContactInfoID)
			END
				
		-- Checks if additionalContactInfo column exists, removes it if it does after copying table data over.
		IF EXISTS (SELECT * FROM sys.columns WHERE @fm = OBJECT_ID AND name = 'additionalContactInfo')
			BEGIN
				DECLARE @some NVARCHAR(100) = 'UPDATE FamilyMember SET additionalContactInfoID = additionalContactInfo'
				EXEC sp_executesql @some
		
				ALTER TABLE FamilyMember
					DROP CONSTRAINT FK__FamilyMem__addit__412EB0B6

				ALTER TABLE FamilyMember
					DROP COLUMN additionalContactInfo
			END
		ELSE
			BEGIN
				ALTER TABLE FamilyMember
					ADD additionalContactInfoID INT FOREIGN KEY REFERENCES AdditionalContactInfo(additionalContactInfoID)
			END

		IF EXISTS (SELECT * FROM sys.columns WHERE @fm = OBJECT_ID AND name = 'sexID')
			BEGIN
				RETURN
			END
		ELSE
			BEGIN
				ALTER TABLE FamilyMember
					DROP COLUMN sexID
			END
	END