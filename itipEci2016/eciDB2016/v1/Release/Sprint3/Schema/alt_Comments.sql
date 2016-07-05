/****************************************************************************
Description: Alter Comments table.

Author: Jennifer M Graves

Date: 07-05-2016

Change History:
		07-05-2016 -- jmg: Added deleted bit column to table.
****************************************************************************/

-- Declares the table variable for Comments
DECLARE @comm INT = 0

-- Assigns the system table ID to @comm variable for later use.
SELECT @comm = (
	SELECT OBJECT_ID
	FROM sys.tables
	WHERE name = 'Comments'
)

SELECT @comm

-- Checks if table exists.
IF ISNULL(@comm, 0) = 0
	BEGIN
		--Creates Comments table if it doesn't exist.
		CREATE TABLE Comments (
			CommentsID INT IDENTITY(1,1) PRIMARY KEY(CommentsID),
			Comments VARCHAR(255),
			deleted BIT
		)

		PRINT 'Added Comments table to database.'
	END
ELSE
	BEGIN
		-- Checks if deleted column exists.
		IF EXISTS (SELECT * FROM sys.columns WHERE @comm = OBJECT_ID AND name = 'deleted')
			BEGIN
				-- Advises DBA no column added, as already exists.
				PRINT 'Unneeded: deleted column exists.'
			END
		ELSE
			BEGIN
				-- Creates column, advises DBA.
				ALTER TABLE Comments
					ADD deleted BIT
				PRINT 'Added deleted column on Comments table.'
			END
	END