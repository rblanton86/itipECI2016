/****************************************************************************
Description: Initializes the Linking memberAddress table.

Author: Tyrell Powers-Crane

Date: 07-15-2016

Change History:

****************************************************************************/

-- Checks to see if Office table already exitsts, creates if it does not.
IF EXISTS (SELECT * FROM sys.tables WHERE name = 'LnkAddressMember')
	BEGIN
		PRINT 'LnkAddressMember table already exists.'
	END
ELSE
	BEGIN
		CREATE TABLE LnkAddressMember (
			memberTypeID INT FOREIGN KEY REFERENCES MemberType(memberTypeID),
			addressesID INT FOREIGN KEY REFERENCES Addresses(addressesID)
			PRIMARY KEY (memberTypeID, addressesID)
		)
	END