/****************************************************************************
Description: Stored procedure to update the Diagnosis tables for a patient 
	when a diagnosis is added.
Author: Jen M. Graves
Date: 07/21/206
Changelog:
	07/21/206: JMG - Initial Creation
****************************************************************************/
CREATE PROCEDURE [dbo].[ins_Diagnosis]
	@clientID INT,
	@diagnosis_From DATE,
	@diagnosis_To DATE,
	@diagnosisCodeID INT,
	@diagnosisTypeID INT,
	@isPrimary BIT,
	@diagnosisID INT OUTPUT

AS

	BEGIN
		BEGIN TRY
			IF EXISTS (SELECT * FROM Diagnois WHERE clientID <> @clientID AND
					diagnosis_From <> @diagnosis_From AND
					diagnosis_To <> @diagnosis_To AND
					diagnosisCodeID <> @diagnosisCodeID AND
					diagnosisTypeID <> @diagnosisTypeID AND
					isPrimary <> @isPrimary AND
					deleted <> 1)
				
				BEGIN
					INSERT INTO Diagnosis (clientID,
						diagnosis_From,
						diagnosis_To,
						diagnosisCodeID,
						diagnosisTypeID,
						isPrimary,
						deleted)

					VALUES (@clientID,
						@diagnosis_From,
						@diagnosis_To,
						@diagnosisCodeID,
						@diagnosisTypeID,
						@isPrimary,
						0)

					SET @diagnosisID = (SELECT diagnosisID
						FROM Diagnosis
						WHERE (clientID = @clientID AND
							diagnosis_From = @diagnosis_From AND
							diagnosis_To = @diagnosis_To AND
							diagnosisCodeID = @diagnosisCodeID AND
							diagnosisTypeID = @diagnosisTypeID AND
							isPrimary = @isPrimary AND
							deleted <> 1
							))

					RETURN @diagnosisID
				END
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