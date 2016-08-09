/***********************************************************************************************************
Description: Stored Procedure to pull information from Clients table
	 
Author: 
	Tyrell Powers-Crane 
Date: 
	6.21.16
Change History:
	07-05-2016: JMG - Updated stored proc to new column names for compliance.
	07-06-2016: JMG - Corrected spelling error which caused exception on webApp run.
	07-11-2016: JMG - Update to stored procedure to include additionally added information.
	07-13-2016: JMG - Updated to wrap selects in ISNULL.
	08-09-2016: JGM - Updated client address to use new linking table.
************************************************************************************************************/
ALTER PROCEDURE [dbo].[get_ClientByID]
	@clientID int

AS
	BEGIN
		BEGIN TRY

			SELECT clnt.clientID,
				ISNULL(clnt.firstName, '') AS firstName,
				ISNULL(clnt.lastName, '') AS lastName,
				ISNULL(clnt.ssn, 0) AS ssn,
				ISNULL(clnt.referralSource, '') AS referralSource,
				ISNULL(clnt.intakeDate, '19010101') AS intakeDate,
				ISNULL(clnt.ifspDate, '19000101') AS ifspDate,
				ISNULL(clnt.compSvcDate, '19000101') AS compSvcDate,
				ISNULL(clnt.dob, '19000101') AS dob,
				ISNULL(clnt.altID, '') AS altID,
				ISNULL(clnt.middleInitial, '') AS middleInitial,
				ISNULL(clnt.serviceAreaException, 0) AS serviceAreaException,
				ISNULL(clnt.deleted, 0) AS deleted,
				ISNULL(clnt.tkidsCaseNumber, 0) AS tkidsCaseNumber,
				ISNULL(clnt.consentToRelease, 1) AS consentToRelease,
				ISNULL(clnt.eci, 1) AS eci,
				ISNULL(clnt.accountingSystemID, '') AS accountingSystemID,
				ISNULL(clnt.updDate, '19000101') AS updDate,
				ISNULL(clnt.raceID, 1) AS raceID,
				ISNULL(clnt.ethnicityID, 1) AS ethnicityID,
				ISNULL(clnt.clientStatusID, 1) AS clientStatusID,
				ISNULL(clnt.primaryLanguageID, 1) AS primaryLanguageID,
				ISNULL(clnt.schoolInfoID, 1) AS schoolInfoID,
				ISNULL(clnt.communicationPreferencesID, 1) AS communicationPreferencesID,
				ISNULL(clnt.sexID, 1) AS sexID,
				ISNULL(addr.addressesID, 1) AS addressesID,
				ISNULL(clnt.officeID, 1) AS officeID,
				ISNULL(rce.race, '') AS race,
				ISNULL(eth.ethnicity, '') AS ethnicity,
				ISNULL(sts.clientStatus, '') AS clientStatus,
				ISNULL(plang.primaryLanguage, '') AS primaryLanguage,
				ISNULL(sclinf.isd, '') AS isd,
				ISNULL(sex.sex, '') AS sex,
				ISNULL(office.officeName, '') AS officeName,
				ISNULL(addr.address1, '') AS address1,
				ISNULL(addr.address2, '') AS address2,
				ISNULL(addr.city, '') AS city,
				ISNULL(addr.st, '') AS st,
				ISNULL(addr.county, '') AS county,
				ISNULL(addr.zip, 0) AS zip,
				ISNULL(addr.mapsco, '') AS mapsco,
				ISNULL(comprf.communicationPreferences, '') AS communicationPreferences

			FROM Clients clnt
				LEFT JOIN Race rce
					ON clnt.raceID = rce.raceID
				LEFT JOIN Ethnicity eth
					ON clnt.ethnicityID = eth.ethnicityID
				LEFT JOIN ClientStatus sts
					ON clnt.clientStatusID = sts.clientStatusID
				LEFT JOIN PrimaryLanguage plang
					ON clnt.primaryLanguageID = plang.primaryLanguageID
				LEFT JOIN SchoolInformation sclinf
					ON clnt.schoolInfoID = sclinf.schoolInfoID
				LEFT JOIN Insurance ins
					ON ins.clientID = clnt.clientID
				LEFT JOIN InsuranceAuthorization insauth
					ON ins.insuranceID = insauth.insuranceID
				LEFT JOIN CommunicationPreferences comprf
					ON clnt.communicationPreferencesID = comprf.communicationPreferencesID
				LEFT JOIN Sex sex
					ON clnt.sexID = sex.sexID
				LEFT JOIN Office office
					ON clnt.officeID = office.officeID
				LEFT JOIN LnkAddressMember lam
					ON lam.memberID = clnt.clientID
					AND lam.memberTypeID = clnt.memberTypeID
				LEFT JOIN Addresses addr
					ON lam.addressesID = addr.addressesID

			WHERE clnt.clientID = @clientID

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
