/***********************************************************************************************************
Description: Stored Procedure that inserts information into the Comments Table
	 
Author: 
	Tyrell Powers-Crane 
Date: 
	6.23.16
Change History:
	
************************************************************************************************************/
CREATE PROCEDURE [dbo].[ins_Comments]
	@comments varchar (250)


AS
	BEGIN
		BEGIN TRY

			INSERT Comments (comments)

			VALUES (@comments)

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



