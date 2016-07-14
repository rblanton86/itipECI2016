/****************************************************************************
Description: Creates stored procedure @procedure.
        	
Author: Jennifer M. Graves
        	
Date: 07-14-2016
        	
Change History:
        	
****************************************************************************/
CREATE PROCEDURE [dbo].[@procedure]
	@clientID INT

AS
BEGIN
	BEGIN TRY
		
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