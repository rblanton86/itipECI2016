/****************************************************************************
Description: Initializes the Office table.

Author: Jennifer M. Graves

Date: 07-11-2016

Change History:

****************************************************************************/

-- Checks to see if Office table already exitsts, creates if it does not.
IF EXISTS (SELECT * FROM sys.tables WHERE name = 'Office')
	BEGIN
		PRINT 'Office table already exists.'
	END
ELSE
	BEGIN
		CREATE TABLE Office (
			officeID INT IDENTITY (1,1) PRIMARY KEY,
			officeName VARCHAR(25),
		)
	END