/****************************************************************************
Description: Alters the linking address member table.

Author: Jennifer Graves

Date: 08-09-2016

Change History:

****************************************************************************/

-- Declares table variable for addresses table
DECLARE @lnkaddressmember INT = 0

-- Assigns table ID to addresses variable.
SELECT @lnkaddressmember = (
	SELECT OBJECT_ID
	FROM Sys.Tables
	WHERE name = 'LnkAddressMember'
)

SELECT @lnkaddressmember

-- Checks if table exists, create table if it doesn't.
IF ISNULL(@lnkaddressmember, 0) = 0
	BEGIN
		CREATE TABLE LnkAddressMember (
			memberTypeID INT FOREIGN KEY REFERENCES MemberType(memberTypeID),
			addressesID INT FOREIGN KEY REFERENCES Addresses(addressesID),
			memberID INT
			PRIMARY KEY (memberTypeID, addressesID)
		)

		PRINT 'Created LnkAddressMember on database.'
	END
ELSE
	BEGIN
		IF EXISTS(SELECT * FROM sys.columns WHERE @lnkaddressmember = OBJECT_ID AND name = 'memberID')
			BEGIN
				PRINT 'Did not add memberID column, already exists.'
			END
			BEGIN
				ALTER TABLE LnkAddressMember
					ADD memberID INT
				PRINT 'Added memberID column to LnkAddressMember table.'
			END
	END