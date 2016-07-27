/***********************************************************************************************************
Description: Stored Procedure to pull information from Clients table
	 
Author: 
	Tyrell Powers-Crane 
Date: 
	6.21.16
Change History:
	06-30-2016 -- jmg -- Generated altID.
	07-05-2016 -- removed generated altID. Updated stored proc to new column names for compliance.
************************************************************************************************************/
ALTER PROCEDURE [dbo].[get_AllClients]

AS
	BEGIN
		BEGIN TRY

			SELECT clnt.firstName,
					clnt.lastName,
					clnt.clientID,
					clnt.altID

			FROM Clients clnt

			WHERE deleted != 1

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