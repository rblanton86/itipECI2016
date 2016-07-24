/***********************************************************************************************************
Description: Stored Procedure to pull type information from DiagnosisType
	 
Author: 
	Tyrell Powers-Crane 
Date: 
	7.14.16
Change History:
	07/21/206: JMG - Updated procedure to pull types and typeIDs.
************************************************************************************************************/
CREATE PROCEDURE [dbo].[get_DiagnosisTypes]

AS
	BEGIN
		BEGIN TRY

			SELECT ISNULL(diagnosisType, ' ') AS diagnosisType,
				ISNULL(diagnosisTypeID, 0) AS diagnosisTypeID
			
			FROM DiagnosisType

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

