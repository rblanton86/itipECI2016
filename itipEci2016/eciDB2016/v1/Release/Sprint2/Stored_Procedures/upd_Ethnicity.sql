/***********************************************************************************************************
Description: Stored Procedure that updates the ethnicity of the Ethnicity Table
	 
Author: 
	Tyrell Powers-Crane 
Date: 
	6.23.16
Change History:
	
************************************************************************************************************/
CREATE PROCEDURE [dbo].[upd_Ethnicity]
	@ethnicityID int,
	@ethnicity VARCHAR (25)

AS
	BEGIN
		BEGIN TRY

			UPDATE Ethnicity 

			SET ethnicity = @ethnicity
			
			WHERE ethnicityID = @ethnicityID

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


