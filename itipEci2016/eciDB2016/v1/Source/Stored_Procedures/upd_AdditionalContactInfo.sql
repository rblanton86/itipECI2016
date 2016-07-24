/***********************************************************************************************************
Description: Stored Procedure to update information into Additional Contact Info Table
	 
Author: 
	Tyrell Powers-Crane 
Date: 
	6.23.16
Change History:
	
************************************************************************************************************/
ALTER PROCEDURE [dbo].[upd_AdditionalContactInfo]
	@additionalContactInfoID int,
	@additionalContactInfo varchar (25),
	@additionalContactInfoTypeID int,
	@deleted bit

	
AS
	BEGIN
		BEGIN TRY

			UPDATE AdditionalContactInfo
			
			SET	additionalContactInfo = @additionalContactInfo,
				additionalContactInfoTypeID = @additionalContactInfoTypeID,
				deleted = @deleted

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


