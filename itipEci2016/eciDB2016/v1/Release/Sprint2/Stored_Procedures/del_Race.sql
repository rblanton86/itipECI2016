/***********************************************************************************************************
Description: Stored Procedure that deletes the race from the Race Table
	 
Author: 
	Tyrell Powers-Crane 
Date: 
	6.23.16
Change History:
	
************************************************************************************************************/

CREATE PROCEDURE [dbo].[del_Race]
	@raceID int

	AS

BEGIN
		BEGIN TRY
		
			DELETE FROM Race
			WHERE raceID = @raceID	

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