/****************************************************************************
Description: Stored procedure to update the Diagnosis tables for a patient 
	when a diagnosis is added.
Author: Jen M. Graves
Date: 07/21/206
Changelog:
	07/21/206: JMG - Initial Creation
****************************************************************************/
CREATE PROCEDURE [dbo].[upd_Diagnosis]
	@diagnosisID INT,
	@diagnosis_From DATE,
	@diagnosis_To DATE,
	@diagnosisCodeID INT,
	@diagnosisTypeID INT,
	@isPrimary BIT

AS

	BEGIN

		BEGIN TRY
			UPDATE Diagnosis

			SET diagnosis_From = @diagnosis_From,
				diagnosis_To = @diagnosis_To,
				diagnosisCodeID = @diagnosisCodeID,
				diagnosisTypeID = @diagnosisTypeID,
				isPrimary = @isPrimary

			WHERE diagnosisID = @diagnosisID
		END TRY
		BEGIN CATCH
			DECLARE @timeStamp DATETIME,
				@errorMessage VARCHAR(MAX),
				@errorProcedure VARCHAR(100)	

			SELECT @timeStamp = GETDATE(),
					@errorMessage = ERROR_MESSAGE(),
					@errorProcedure = ERROR_PROCEDURE()
			
			EXECUTE dbo.log_ErrorTimeStamp @timeStamp, @errorMessage, @errorProcedure
		END CATCH

	END