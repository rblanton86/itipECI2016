/****************************************************************************
Description: Creates Comments Type table.
        	
Author: Jennifer Graves
        	
Date: 07-14-2016
        	
Change History:
        	
****************************************************************************/

IF EXISTS (SELECT * FROM sys.tables WHERE name = 'CommentsType')
	BEGIN
		-- Notifies DBA that table has already been created.
		PRINT 'CommentsType table not added: already exists'
	END
ELSE
	BEGIN
		-- Creates table.
		CREATE TABLE CommentsType (
			commentsTypeID INT IDENTITY (1,1) PRIMARY KEY,
			commentsType VARCHAR(50) NOT NULL
		)

		-- Notifies DBA of successful table creation.
		PRINT 'CommentsType table initiated with default values.'

		-- Check if identity column is at proper seed, reseeds if not proper.
		IF (SELECT IDENT_CURRENT ('CommentsType')) = 0
			BEGIN
				PRINT 'Identity value not reseeded: set at correct identity value.'
			END
		ELSE
			BEGIN
				DBCC CHECKIDENT ('CommentsType', RESEED, 0)

				PRINT 'Reseeding identity value.'

				DBCC CHECKIDENT ('CommentsType')
			END

		-- Selects table for DBA view to ensure proper table creation.
		SELECT * FROM CommentsType		
	END