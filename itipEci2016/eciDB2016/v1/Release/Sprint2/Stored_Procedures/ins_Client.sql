/***********************************************************************************************************
Description: Stored Procedure that inserts client information into the Clients Table
	 
Author: 
	Tyrell Powers-Crane 
Date: 
	6.21.16
Change History:
	
************************************************************************************************************/
CREATE PROCEDURE [dbo].[ins_Client]
	@raceID int,
	@ethnicityID int,
	@clientStatusID int,
	@diagnosisID int,
	@primaryLanguageID int,
	@schoolInfoID int,
	@commentsID int,
	@insuranceAuthID int,
	@communicationPreferencesID int,
	@firstName varchar(20),
	@lastName varchar(20),
	@dob varchar(15),
	@ssn int,
	@referralSource varchar(25)
	
AS
	BEGIN
		BEGIN TRY

			INSERT Clients (raceID,
							ethnicityID,
							clientStatusID,
							diagnosisID,
							primaryLanguageID,
							schoolInfoID,
							commentsID,
							insuranceAuthID,
							communicationPreferencesID,
							firstName,
							lastName,
							dob,
							ssn,
							referralSource)

			VALUES (@raceID,
					@ethnicityID,
					@clientStatusID,
					@diagnosisID,
					@primaryLanguageID,
					@schoolInfoID,
					@commentsID,
					@insuranceAuthID,
					@commentsID,
					@firstName, 
					@lastName, 
					@dob, 
					@ssn, 
					@referralSource)

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


