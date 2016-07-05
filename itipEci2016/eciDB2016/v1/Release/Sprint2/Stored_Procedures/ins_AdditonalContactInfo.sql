/***********************************************************************************************************
Description: Stored Procedure to insert information into Additional Contact Info Table
	 
Author: 
	Tyrell Powers-Crane 
Date: 
	6.22.16
Change History:
	
************************************************************************************************************/
CREATE PROCEDURE [dbo].[ins_AdditionalContactInfo]
	@memberTypeID int,
	@additionalContactInfoTypeID int,
	@additionalContactInfo varchar (25)
	
AS
	BEGIN
		BEGIN TRY

			INSERT AdditionalContactInfo (memberTypeID, 
											additionalContactInfoTypeID, 
											additionalContactInfo)

			VALUES (@memberTypeID, 
					@additionalContactInfoTypeID, 
					@additionalContactInfo)

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


