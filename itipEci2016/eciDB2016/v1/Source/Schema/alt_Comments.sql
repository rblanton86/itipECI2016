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
			commentsID INT IDENTITY(1,1) PRIMARY KEY(CommentsID),
			commentsTypeID INT CONSTRAINT FK_Comments_CommentsType FOREIGN KEY REFERENCES CommentsType(commentsTypeID), --chk
			memberID INT, -- chk
			memberTypeID INT CONSTRAINT FK_Comments_MemberType FOREIGN KEY REFERENCES MemberType(memberTypeID), --chk
			comments VARCHAR(MAX), -- chk
			updDate DATETIME DEFAULT (GETDATE()), --chk
			valid_To DATE,
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

		IF EXISTS (SELECT * FROM sys.columns WHERE @comm = OBJECT_ID AND name ='updDate')
			BEGIN
				ALTER TABLE Comments ADD CONSTRAINT
				DF_MyTable_Inserted DEFAULT GETDATE() FOR updDate
				PRINT 'Altered updDate column: Added Constraint'
			END
		ELSE
			BEGIN
				ALTER TABLE Comments
					ADD updDate DATETIME DEFAULT (GETDATE())
				PRINT 'Added updDate column to table.'
			END

		IF EXISTS (SELECT * FROM sys.columns WHERE @comm = OBJECT_ID AND name ='comments')
			BEGIN
				ALTER TABLE Comments
					ALTER COLUMN comments VARCHAR(MAX)
				PRINT 'Altered comment column: changed to VARCHAR(MAX).'
			END
		ELSE
			BEGIN
				ALTER TABLE Comments
					ADD comments VARCHAR(MAX)
				PRINT 'Added comment column to table.'
			END

		-- Checks if commentsTypeID column exists.
		IF EXISTS (SELECT * FROM sys.columns WHERE @comm = OBJECT_ID AND name = 'commentsTypeID')
			BEGIN
				-- Advises DBA no column added, as already exists.
				PRINT 'Unneeded: commentsTypeID column exists.'
			END
		ELSE
			BEGIN
				-- Creates column, advises DBA.
				ALTER TABLE Comments
					ADD commentsTypeID INT CONSTRAINT FK_Comments_CommentsType FOREIGN KEY REFERENCES CommentsType(commentsTypeID)
				PRINT 'Added commentsTypeID column on Comments table.'
			END

		-- Checks if memberID column exists.
		IF EXISTS (SELECT * FROM sys.columns WHERE @comm = OBJECT_ID AND name = 'memberID')
			BEGIN
				-- Advises DBA no column added, as already exists.
				PRINT 'Unneeded: memberID column exists.'
			END
		ELSE
			BEGIN
				-- Creates column, advises DBA.
				ALTER TABLE Comments
					ADD memberID INT
				PRINT 'Added memberID column on Comments table.'
			END

		-- Checks if memberTypeID column exists.
		IF EXISTS (SELECT * FROM sys.columns WHERE @comm = OBJECT_ID AND name = 'memberTypeID')
			BEGIN
				-- Advises DBA no column added, as already exists.
				PRINT 'Unneeded: memberTypeID column exists.'
			END
		ELSE
			BEGIN
				-- Creates column, advises DBA.
				ALTER TABLE Comments
					ADD memberTypeID INT CONSTRAINT FK_Comments_MemberType FOREIGN KEY REFERENCES MemberType(memberTypeID)
				PRINT 'Added memberTypeID column on Comments table.'
			END

		-- Checks if valid_To column exists.
		IF EXISTS (SELECT * FROM sys.columns WHERE @comm = OBJECT_ID AND name = 'valid_To')
			BEGIN
				-- Advises DBA no column added, as already exists.
				PRINT 'Unneeded: valid_To column exists.'
			END
		ELSE
			BEGIN
				-- Creates column, advises DBA.
				ALTER TABLE Comments
					ADD valid_To DATE
				PRINT 'Added valid_To column on Comments table.'
			END
	END