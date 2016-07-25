/***********************************************************************************************************
Description: Stored Procedure that deletes information from the Addresses Table
	 
Author: 
	Tyrell Powers-Crane 
Date: 
	6.23.16
Change History:
	07/24/2016: JMG - Updated and added back to stored_proc folder.
************************************************************************************************************/
CREATE PROCEDURE [dbo].[del_Addresses]
	@addressesID INT,
	@success BIT OUTPUT


AS
	BEGIN
		BEGIN TRY

			UPDATE Addresses
			SET deleted = 1
			WHERE addressesID = @addressesID

			SET @success = 1

		END TRY
		BEGIN CATCH

			DECLARE @timeStamp DATETIME,
				@errorMessage VARCHAR(255),
				@errorProcedure VARCHAR(100)	

			SELECT @timeStamp = GETDATE(),
					@errorMessage = ERROR_MESSAGE(),
					@errorProcedure = ERROR_PROCEDURE()
			
			EXECUTE dbo.log_ErrorTimeStamp @timeStamp, @errorMessage, @errorProcedure

			SET @success = 0

		END CATCH
	END



