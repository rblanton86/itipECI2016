/***********************************************************************************************************
Description: Stored Procedure that inserts the race into the Race Table
	 
Author: 
	Tyrell Powers-Crane 
Date: 
	6.22.16
Change History:
	
************************************************************************************************************/

CREATE PROCEDURE [dbo].[ins_Race]
	@race varchar (25)

	AS

BEGIN
		BEGIN TRY
		
			INSERT Race
			VALUES (@race)

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