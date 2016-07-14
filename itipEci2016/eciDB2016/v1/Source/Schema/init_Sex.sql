/***********************************************************************************************************
Description: 
	Creates sex table; will hold vaules M(male), F(female) and O(other).
Author: 
	Jennifer M. Graves
Date: 
	06-22-2016
Change History:
	07-13-2016: JMG - Added If/Exists statement and initial table values where needed.
************************************************************************************************************/

-- Checks to see if Sex table already exitsts, creates if it does not.
IF EXISTS (SELECT * FROM sys.tables WHERE name = 'Sex')
	BEGIN
		PRINT 'Sex table not added: already exists.'
	END
ELSE
	BEGIN
		CREATE TABLE Sex (
			sexID INT IDENTITY (1,1) PRIMARY KEY,
			sex VARCHAR(25),
		)

		DELETE FROM Sex
		DECLARE @r VARCHAR(MAX)
		SELECT @r =
			'SET IDENTITY_INSERT Sex ON;
			INSERT INTO Sex(sexID, sex)
				VALUES (1, ''Male''),
					(2, ''Female''),
					(3, ''Other'');
			SET IDENTITY_INSERT Sex OFF;'
		EXEC(@r)
		PRINT 'Sex table values added.'
		SELECT * FROM Sex
	END