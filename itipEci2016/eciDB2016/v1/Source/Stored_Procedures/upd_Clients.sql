﻿/***********************************************************************************************************
Description: Stored Procedure that updates client information into the Clients Table
	 
Author: 
	Tyrell Powers-Crane 
Date: 
	6.21.16
Change History:
	
************************************************************************************************************/
CREATE PROCEDURE [dbo].[upd_Client]
	@clientsID int,
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

			UPDATE Clients 
			
			SET		raceID = @raceID,
					ethnicityID = @ethnicityID,
					clientStatusID = @clientStatusID,
					diagnosisID = @diagnosisID,
					primaryLanguageID = @primaryLanguageID,
					schoolInfoID = @schoolInfoID,
					commentsID = @commentsID,
					insuranceAuthID = @insuranceAuthID,
					communicationPreferencesID = @communicationPreferencesID,
					firstName = @firstName,
					lastName = @lastName,
					dob = @dob,
					ssn = @ssn,
					referralSource = @referralSource

			WHERE
					ClientsID = @ClientsID

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


