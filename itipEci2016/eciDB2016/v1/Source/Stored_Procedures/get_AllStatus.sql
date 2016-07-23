/***********************************************************************************************************
Description: Stored Procedure to pull type information from Status

Author: 
	Tyrell Powers-Crane 
Date: 
	7.121.16
Change History:
	
************************************************************************************************************/
CREATE PROCEDURE [dbo].[get_AllStatus]

AS
	BEGIN
		BEGIN TRY

			SELECT ISNULL(clientStatus, ' ') AS clientStatus,
					ISNULL(clientStatusID, 1) AS clientStatusID

			FROM ClientStatus

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

