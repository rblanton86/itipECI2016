/***********************************************************************************************************
Description: 
	Creates sex table; will hold vaules M(male), F(female) and O(other).
Author: 
	Jennifer M. Graves
Date: 
	06-22-2016
Change History:
	
************************************************************************************************************/

-- Checks to see if Sex table already exitsts, creates if it does not.
IF EXISTS (SELECT * FROM sys.tables WHERE name = 'Sex')
	BEGIN
		PRINT 'This table already exists.'
	END
ELSE
	BEGIN
		CREATE TABLE Sex (
			sexID INT IDENTITY (1,1) PRIMARY KEY,
			sex VARCHAR(25),
		)
	END