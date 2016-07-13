/***********************************************************************************************************
Description: Stored Procedure to pull client information from Clients table by name
	 
Author: 
	Tyrell Powers-Crane 
Date: 
	6.22.16
Change History:
	07-11-2016: -- jmg -- Update to stored procedure to include additionally added information.
************************************************************************************************************/
CREATE PROCEDURE [dbo].[get_ClientByName]
	@firstName varchar(25),
	@lastName varchar(25)

AS
	BEGIN
		BEGIN TRY

			SELECT clnt.*,
					rce.race,
					eth.ethnicity,
					sts.clientStatus,
					dx.icd_10_Code

			FROM Clients clnt
				LEFT JOIN Race rce
					ON clnt.raceID = rce.raceID
				LEFT JOIN Ethnicity eth
					ON clnt.ethnicityID = eth.ethnicityID
				LEFT JOIN ClientStatus sts
					ON clnt.clientStatusID = sts.clientStatusID
				LEFT JOIN Diagnosis dx
					ON clnt.diagnosisID = dx.diagnosisID
				LEFT JOIN PrimaryLanguage plang
					ON clnt.primaryLanguageID = plang.primaryLanguageID
				LEFT JOIN SchoolInformation sclinf
					ON clnt.schoolInfoID = sclinf.schoolInfoID
				LEFT JOIN InsuranceAuthorization insauth
					ON clnt.insuranceAuthID = insauth.insuranceAuthID
				LEFT JOIN CommunicationPreferences comprf
					ON clnt.communicationPreferencesID = comprf.communicationPreferencesID
				LEFT JOIN Sex sex
					ON clnt.sexID = sex.sexID
				LEFT JOIN Office office
					ON clnt.officeID = office.officeID
				LEFT JOIN Addresses addr
					ON clnt.addressesID = addr.addressesID
			WHERE (firstName = @firstName) AND (lastName = @lastName)

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
