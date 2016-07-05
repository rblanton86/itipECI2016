/***********************************************************************************************************
Description: Stored Procedure that deletes information from the Addresses Table
	 
Author: 
	Tyrell Powers-Crane 
Date: 
	6.23.16
Change History:
	
************************************************************************************************************/
CREATE PROCEDURE [dbo].[del_Addresses]
	@addressesID int


AS
	BEGIN
		BEGIN TRY

			DELETE FROM Addresses 
			WHERE addressesID = @addressesID

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



