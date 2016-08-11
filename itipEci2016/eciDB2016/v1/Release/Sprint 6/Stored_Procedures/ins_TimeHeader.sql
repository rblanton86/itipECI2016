/***********************************************************************************************************
Description: Stored Procedure to put information into the Time Header Table
	 
Author: 
	Tyrell Powers-Crane 
Date: 
	7.05.2016
Change History:
	
************************************************************************************************************/
CREATE PROCEDURE [dbo].[ins_TimeHeader]
	@staffID int,
	@weekEnding varchar(10)
	
AS
	BEGIN
		BEGIN TRY

			INSERT TimeHeader (staffID, weekEnding)

			VALUES (@staffID, @weekEnding)


			

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

