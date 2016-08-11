/***********************************************************************************************************
Description: Stored Procedure to put information into the Time Header Details Table
	 
Author: 
	Tyrell Powers-Crane 
Date: 
	7.05.2016
Change History:
	
************************************************************************************************************/
ALTER PROCEDURE [dbo].[ins_TimeDetails]
	@timeHeaderID int,
	@actualTime decimal(18),
	@insuranceTime decimal(18),
	@placeOfService varchar(1),
	@canceled bit
	
AS
	BEGIN
		BEGIN TRY

			INSERT TimeDetail (timeheaderID, actualTime, insuranceTime, placeOfService, canceled, deleted)

			VALUES (@timeHeaderID, @actualTime, @insuranceTime, @placeOfService, @canceled, 0)


			

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

