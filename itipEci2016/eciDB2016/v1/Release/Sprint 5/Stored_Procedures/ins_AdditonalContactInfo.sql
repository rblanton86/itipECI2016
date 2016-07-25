/***********************************************************************************************************
Description: Stored Procedure to insert information into Additional Contact Info Table
	 
Author: 
	Tyrell Powers-Crane 
Date: 
	6.22.16
Change History:
	
************************************************************************************************************/
ALTER PROCEDURE [dbo].[ins_AdditionalContactInfo]
	@memberTypeID int,
	@additionalContactInfoTypeID int,
	@additionalContactInfo varchar (25),
	@deleted bit,
	@memberID int
	
AS
	BEGIN
		BEGIN TRY
			
			IF EXISTS(SELECT * FROM AdditionalContactInfo WHERE 
						memberTypeID = @memberTypeID
						AND	 additionalContactInfoTypeID = @additionalContactInfo
						AND additionalContactInfo = @additionalContactInfo
						)
			BEGIN
				RETURN 
			END
		ELSE
			BEGIN
					INSERT AdditionalContactInfo (memberTypeID, 
													additionalContactInfoTypeID, 
													additionalContactInfo,
													memberID,
													deleted)

					VALUES (@memberTypeID, 
							@additionalContactInfoTypeID, 
							@additionalContactInfo,
							@memberID,
							@deleted)
			
			END

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


