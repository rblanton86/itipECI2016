/***********************************************************************************************************
Description: Stored Procedure to pull type information from additionalContactInfoType
	 
Author: 
	Tyrell Powers-Crane 
Date: 
	7.21.16
Change History:
	
************************************************************************************************************/
CREATE PROCEDURE [dbo].[get_AllAdditionalContactInfoType]

AS
	BEGIN
		BEGIN TRY

			SELECT ISNULL(additionalContactInfoType, ' ') AS additionalContactInfoType,
					ISNULL(additionalContactInfoTypeID, 0) AS additionalContactInfoTypeID
			FROM AdditionalContactInfoType

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

