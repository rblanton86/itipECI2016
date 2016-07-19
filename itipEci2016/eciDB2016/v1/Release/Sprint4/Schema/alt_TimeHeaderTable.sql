/***********************************************************************************************************
Description: Creates the Time Header Table
	 
Author: 
	Tyrell Powers-Crane 
Date: 
	7.05.2016
Change History:
	7.19.2016 - JMG: Corrected script to run if/exists.
************************************************************************************************************/


DECLARE @TimeHeader int = 0
	
	SELECT @TimeHeader = (
		SELECT object_id
		FROM sys.tables
		WHERE name = 'TimeHeader' )

	SELECT @TimeHeader	

IF ISNULL(@TimeHeader, 0) = 0
	BEGIN

		CREATE TABLE TimeHeader (
			timeHeaderID int IDENTITY (1,1) PRIMARY KEY,
			staffID int FOREIGN KEY REFERENCES Staff(staffID),
			weekEnding varchar(10),
			deleted bit
			)

	END
ELSE
	BEGIN
		IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'TimeHeader' AND COLUMN_NAME = 'weekEnding' AND DATA_TYPE = 'Date')
			BEGIN
				ALTER TABLE TimeHeader
					DROP COLUMN weekEnding

				ALTER TABLE TimeHeader
					ADD weekEnding VARCHAR(10)
			END
		ELSE 
			BEGIN
				PRINT 'Uneeded: Column is correct data type.'
			END
	END