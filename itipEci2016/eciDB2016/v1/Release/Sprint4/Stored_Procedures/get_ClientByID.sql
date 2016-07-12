/***********************************************************************************************************
Description: Stored Procedure to pull information from Clients table
	 
Author: 
	Tyrell Powers-Crane 
Date: 
	6.21.16
Change History:
	07-05-2016: -- jmg -- Updated stored proc to new column names for compliance.
	07-06-2016: -- jmg -- Corrected spelling error which caused exception on webApp run.
	07-11-2016: -- jmg -- Update to stored procedure to include additionally added information.
************************************************************************************************************/
ALTER PROCEDURE [dbo].[get_ClientByID]
	@clientID int

AS
	BEGIN
		BEGIN TRY

			SELECT clnt.*,
				rce.race,
				eth.ethnicity,
				sts.clientStatus,
				plang.primaryLanguage,
				sclinf.isd,
				sex.sex,
				office.office,
				addr.address1,
				addr.address2,
				addr.city,
				addr.st,
				addr.zip,
				addr.mapsco,
				dx.diagnosisType,
				dx.diagnosisCode,
				dx.diagnosis,
				dx.diagnosisFrom,
				dx.diagnosisTo,
				insauth.insuranceAuthorizationType,
				insauth.authorized_From,
				insauth.authorized_To,
				comprf.communicationPreferences

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
			WHERE clientID = @clientID

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
