/***********************************************************************************************************
Description: Stored Procedure to pull information from the Time Detail Table
	 
Author: 
	Tyrell Powers-Crane 
Date: 
	7.05.2016
Change History:
	
************************************************************************************************************/
CREATE PROCEDURE [dbo].[get_TimeDetail]
	@timeHeaderID int
	
AS
	BEGIN
		BEGIN TRY

			SELECT timeDetailID,
					timeHeaderID,
					clientID,
					ISNULL(actualTime, 0) AS actualTime,
					ISNULL(eciCode, ' ') AS eciCode,
					ISNULL(insuranceDesignation, ' ') AS insuranceDesignation,
					ISNULL(cptCode, ' ') AS cptCode,
					ISNULL(insuranceTime, 0) AS insuranceTime,
					ISNULL(placeOfService, ' ') AS placeOfService,
					ISNULL(tcm, ' ') AS tcm,
					ISNULL(canceled, ' ') AS canceled,
					updDate,
					deleted

			FROM TimeDetail
			WHERE timeHeaderID = @timeHeaderID AND deleted <> 1

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


