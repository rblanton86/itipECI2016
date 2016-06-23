/***********************************************************************************************************
Description: Stored Procedure to pull client information from Clients table by name
	 
Author: 
	Tyrell Powers-Crane 
Date: 
	6.22.16
Change History:
	
************************************************************************************************************/
CREATE PROCEDURE [dbo].[get_ClientByName]
	@firstName varchar(25),
	@lastName varchar(25)

AS
	BEGIN
		BEGIN TRY

			SELECT firstName, lastName, dob, ssn, referralSource
			FROM Clients
			WHERE (@firstName = firstName) AND (@lastName = lastName)

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
