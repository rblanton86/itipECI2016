/***********************************************************************************************************
Description: Stored Procedure that inserts the ethnicity into the Ethnicity Table
	 
Author: 
	Tyrell Powers-Crane 
Date: 
	6.22.16
Change History:
	
************************************************************************************************************/
CREATE PROCEDURE [dbo].[ins_Ethnicity]
	@ethnicity VARCHAR (25)

AS
	BEGIN
		BEGIN TRY

			INSERT Ethnicity (ethnicity)
			VALUES (@ethnicity)

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


