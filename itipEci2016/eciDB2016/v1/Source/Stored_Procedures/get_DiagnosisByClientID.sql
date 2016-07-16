/***********************************************************************************************************
Description: Stored Procedure to pull information from Diagnosis table based on the clientID.
Author: Jennifer M Graves
Date: 07-12-2016
Change History:
************************************************************************************************************/
CREATE PROCEDURE [dbo].[get_DiagnosisByClientID]
	@clientID int

AS
	BEGIN TRY

		SELECT dx.*,
			dxt.*,
			dxc.*

		FROM Diagnosis dx
			LEFT JOIN DiagnosisType dxt
				ON dxt.diagnosisTypeID = dx.diagnosisTypeID
			LEFT JOIN DiagnosisCode dxc
				ON dxc.diagnosisCodeID = dx.diagnosisCodeID

		WHERE clientID = @clientID AND deleted <> 1

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