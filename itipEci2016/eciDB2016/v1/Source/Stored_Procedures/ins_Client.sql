/***********************************************************************************************************
Description: Stored Procedure that inserts client information into the Clients Table
	 
Author: 
	Tyrell Powers-Crane 
Date: 
	6.21.16
Change History:
	07-11-2016: -- jmg -- Added sexID, officeID, addressesID, altID, intakeDate, ifspDate, compSvcDate,
			serviceAreaException, tkidsCaseNumber, consentToRelease, eci, and accountingSystemID columns.
************************************************************************************************************/
CREATE PROCEDURE [dbo].[ins_Client]
	@clientsID INT,
	@raceID INT,
	@ethnicityID INT,
	@clientStatusID INT,
	@diagnosisID INT,
	@primaryLanguageID INT,
	@schoolInfoID INT,
	@commentsID INT,
	@insuranceAuthID INT,
	@communicationPreferencesID INT,
	@sexID INT,
	@officeID INT,
	@addressesID INT,
	@altID VARCHAR(25),
	@firstName VARCHAR(20),
	@middleInitial VARCHAR(1),
	@lastName VARCHAR(20),
	@dob DATE,
	@ssn INT,
	@referralSource VARCHAR(25),
	@intakeDate DATETIME,
	@ifspDate DATE,
	@compSvcDate DATE,
	@serviceAreaExeption BIT,
	@tkidsCaseNumber INT,
	@consentToRelease BIT,
	@eci VARCHAR(25),
	@accountingSystemID VARCHAR(25)
	
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
							sexID,
							officeID,
							firstName,
							middleInitial,
							lastName,
							dob,
							ssn,
							referralSource,
							intakeDate,
							ifspDate,
							compSvcDate,
							serviceAreaException,
							tkidsCaseNumber,
							consentToRelease,
							eci,
							acountingSystemID)

			VALUES (@raceID,
					@ethnicityID,
					@clientStatusID,
					@diagnosisID,
					@primaryLanguageID,
					@schoolInfoID,
					@commentsID,
					@insuranceAuthID,
					@communicationPreferencesID,
					@sexID,
					@officeID,
					@addressesID,
					@altID,
					@firstName,
					@middleInitial,
					@lastName,
					@dob,
					@ssn,
					@referralSource,
					@intakeDate,
					@ifspDate,
					@compSvcDate,
					@serviceAreaExeption,
					@tkidsCaseNumber,
					@consentToRelease,
					@eci,
					@accountingSystemID 
					)

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


