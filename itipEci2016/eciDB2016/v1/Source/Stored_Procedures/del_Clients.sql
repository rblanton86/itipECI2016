/***********************************************************************************************************
Description: Stored Procedure to delete information from Clients table
	 
Author: 
	Tyrell Powers-Crane 
Date: 
	6.23.16
Change History:
	07-14-2016: Updated to switch bit instead of deleting client.
************************************************************************************************************/
CREATE PROCEDURE [dbo].[del_ClientByID]
	@clientID int

AS
	BEGIN
		BEGIN TRY

			UPDATE Clients
			SET
				deleted = 1
			
			WHERE clientID = @clientID

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
