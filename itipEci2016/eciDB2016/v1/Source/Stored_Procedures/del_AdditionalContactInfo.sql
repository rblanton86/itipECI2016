/***********************************************************************************************************
Description: Stored Procedure to delete information from additionalContactInfo
	 
Author: 
	Tyrell Powers-Crane 
Date: 
	6.23.16
Change History:
	
************************************************************************************************************/
CREATE PROCEDURE [dbo].[del_AdditionalContactInfo]
	@additionalContactInfoID int
	
AS
	BEGIN
		BEGIN TRY

			DELETE FROM AdditionalContactInfo
			WHERE additionalContactInfoID = @additionalContactInfoID

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

