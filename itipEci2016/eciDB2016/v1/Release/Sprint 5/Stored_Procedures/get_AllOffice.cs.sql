/***********************************************************************************************************
Description: Stored Procedure to pull type information from Office
	 
Author: 
	Jennifer M Graves
Date: 
	7/25/2015
Change History:
	
************************************************************************************************************/
CREATE PROCEDURE [dbo].[get_AllOffice]

AS
	BEGIN
		BEGIN TRY

			SELECT ISNULL(officeName, ' ') AS officeName,
				ISNULL(officeID, 1) AS officeID

			FROM Office


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

