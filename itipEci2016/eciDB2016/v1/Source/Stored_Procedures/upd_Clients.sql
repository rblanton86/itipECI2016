/***********************************************************************************************************
Description: Stored Procedure that updates client information into the Clients Table
	 
Author: 
	Tyrell Powers-Crane 
Date: 
	6.21.16
Change History:
	07-05-2016: -- jmg -- Added middle inital column.
	07-11-2016: -- jmg -- Added sexID, officeID, addressesID, altID, intakeDate, ifspDate, compSvcDate,
			serviceAreaException, tkidsCaseNumber, consentToRelease, eci, and accountingSystemID columns.
************************************************************************************************************/
ALTER PROCEDURE [dbo].[upd_Clients]
	@clientsID INT,
	@raceID INT,
	@ethnicityID INT,
	@clientStatusID INT,
	@primaryLanguageID INT,
	@schoolInfoID INT,
	@communicationPreferencesID INT,
	@sexID INT,
	@officeID INT,
	@altID VARCHAR(25),
	@firstName VARCHAR(25),
	@middleInitial VARCHAR(1),
	@lastName VARCHAR(25),
	@dob DATE,
	@ssn INT,
	@referralSource VARCHAR(50),
	@intakeDate DATETIME,
	@ifspDate DATE,
	@compSvcDate DATE,
	@serviceAreaException BIT,
	@tkidsCaseNumber INT,
	@consentToRelease BIT,
	@eci VARCHAR(25),
	@accountingSystemID VARCHAR(25)

AS
	BEGIN
		BEGIN TRY

			UPDATE Clients 
			
			SET
					raceID = @raceID,
					ethnicityID = @ethnicityID,
					clientStatusID = @clientStatusID,
					primaryLanguageID = @primaryLanguageID,
					schoolInfoID = @schoolInfoID,
					communicationPreferencesID = @communicationPreferencesID,
					sexID = @sexID,
					officeID = @officeID,
					altID = @altID,
					firstName = @firstName,
					middleInitial = @middleInitial,
					lastName = @lastName,
					dob = @dob,
					ssn = @ssn,
					referralSource = @referralSource,
					intakeDate = @intakeDate,
					ifspDate = @ifspDate,
					compSvcDate = @compSvcDate,
					serviceAreaException = @serviceAreaException,
					tkidsCaseNumber = @tkidsCaseNumber,
					consentToRelease = @consentToRelease,
					eci = @eci,
					accountingSystemID = @accountingSystemID

			WHERE
					clientID = @clientsID

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


