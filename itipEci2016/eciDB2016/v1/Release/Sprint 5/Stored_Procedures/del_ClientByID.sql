/***********************************************************************************************************
Description: Stored Procedure to delete information from Clients table
	 
Author: 
	Tyrell Powers-Crane 
Date: 
	6.23.16
Change History:
	07/24/2016: JMG - Deleted flags as deleted rather than removing from the database and outputs success.
************************************************************************************************************/
ALTER PROCEDURE [dbo].[del_ClientByID]
	@clientID int,
	@success BIT OUTPUT

AS
	BEGIN
		BEGIN TRY

			UPDATE Clients
			SET deleted = 1
			WHERE clientID = @clientID

			SET @success = 1

			RETURN @success

		END TRY
		BEGIN CATCH

			DECLARE @timeStamp DATETIME,
				@errorMessage VARCHAR(255),
				@errorProcedure VARCHAR(100)	

			SELECT @timeStamp = GETDATE(),
					@errorMessage = ERROR_MESSAGE(),
					@errorProcedure = ERROR_PROCEDURE()
			
			EXECUTE dbo.log_ErrorTimeStamp @timeStamp, @errorMessage, @errorProcedure

			SET @success = 0

		END CATCH
	END
