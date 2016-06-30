/***********************************************************************************************************
Description: Stored Procedure to pull information from Clients table
	 
Author: 
	Tyrell Powers-Crane 
Date: 
	6.21.16
Change History:
	06-30-2016 -- jmg -- Generated altID.
************************************************************************************************************/
CREATE PROCEDURE [dbo].[get_AllClients]

AS
	BEGIN
		BEGIN TRY

			SELECT clnt.*,
				rce.race,
				eth.ethnicity,
				sts.clientStatus,
				plang.primaryLanguage,
				sclinf.isd,
				insauth.insuranceAuthorizationType,
				--insauth.authorizedFrom,
				--insauth.authorizedTo,
				comprf.communicationPreferences,
				SUBSTRING(clnt.lastName, 1, 4) +
				SUBSTRING (clnt.firstName, 1, 4) +
				CONVERT (VARCHAR(15), clnt.clientID) AS altID

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
