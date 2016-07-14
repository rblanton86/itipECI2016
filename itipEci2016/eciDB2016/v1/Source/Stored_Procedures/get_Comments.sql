﻿/***********************************************************************************************************
Description: Stored Procedure that retrieves information from the Comments Table
	 
Author: 
	Tyrell Powers-Crane 
Date: 
	6.23.16
Change History:
	
************************************************************************************************************/
ALTER PROCEDURE [dbo].[get_Comments]
	@commentsID int


AS
	BEGIN
		BEGIN TRY

			SELECT ISNULL(comments, ' ')
			FROM Comments
			WHERE commentsID = @commentsID AND deleted <> 1

		END TRY
		BEGIN CATCH

			DECLARE @timeStamp DATETIME,
				@errorMessage VARCHAR(255),
				@errorProcedure VARCHAR(100)	

			SELECT @timeStamp = GETDATE(),
					@errorMessage = ERROR_MESSAGE(),
					@errorProcedure = ERROR_PROCEDURE()
			
			EXECUTE dbo.log_ErrorTimeStamp @timeStamp, @errorMessage, @errorProcedure

		END CATCH
	END



