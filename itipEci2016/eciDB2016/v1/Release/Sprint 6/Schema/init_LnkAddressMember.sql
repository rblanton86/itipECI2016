/****************************************************************************
Description: Initializes the Linking memberAddress table.

Author: Tyrell Powers-Crane

Date: 07-15-2016

Change History:
	08-09-2016: JMG - Altered to add memberID column to linking table.
****************************************************************************/

-- Checks to see if LnkAddressMember table already exitsts, creates if it does not.
IF EXISTS (SELECT * FROM sys.tables WHERE name = 'LnkAddressMember')
	BEGIN
		PRINT 'LnkAddressMember table already exists.'
	END
ELSE
	BEGIN
		CREATE TABLE LnkAddressMember (
			memberTypeID INT FOREIGN KEY REFERENCES MemberType(memberTypeID),
			addressesID INT FOREIGN KEY REFERENCES Addresses(addressesID),
			memberID INT
			PRIMARY KEY (memberTypeID, addressesID)
		)
	END