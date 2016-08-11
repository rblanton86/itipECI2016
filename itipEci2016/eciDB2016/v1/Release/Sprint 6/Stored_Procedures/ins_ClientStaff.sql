/***********************************************************************************************************
Description: Inserts staff link to client.
	 
Author: 
	Jennifer M Graves
Date: 
	7/28/2016
Change History:
	08/09/2015: JMG - Edited to allow for address linking table.
************************************************************************************************************/
ALTER PROCEDURE [dbo].[ins_ClientStaff]
	@clientID INT,
	@staffID INT

AS

BEGIN

	BEGIN TRY

		INSERT INTO LnkClientStaff (clientID, staffID)

		VALUES (@clientID, @staffID)

		SELECT ISNULL(stf.firstName, '') AS firstName,
			ISNULL(stf.lastName, '') AS lastName,
			ISNULL(stf.handicapped, 0) AS handicapped,
			ISNULL(stf.staffAltID, '') AS staffAltID,
			ISNULL(stf.ssn, 0) AS ssn,
			ISNULL(stf.dob, '') AS dob,
			ISNULL(stf.staffStatus, 0) AS staffStatus,
			ISNULL(sex.sex, 'Other') AS sex

		FROM Staff stf
			LEFT JOIN Sex sex
				ON stf.sexID = sex.sexID
		
		WHERE stf.staffID = @staffID

		SELECT aci.additionalContactInfoID,
			ISNULL(aci.additionalContactInfo, '') AS additionalContactInfo,
			acit.additionalContactInfoTypeID,
			ISNULL(acit.additionalContactInfoType, '') AS additionalContactInfoType

		FROM AdditionalContactInfo aci
			LEFT JOIN AdditionalContactInfoType acit
				ON aci.additionalContactInfoTypeID = acit.additionalContactInfoTypeID

		WHERE aci.memberID = @staffID

		SELECT ISNULL(adr.address1, '') AS address1,
			ISNULL(adr.address2, '') AS address2,
			ISNULL(adr.city, '') AS city,
			ISNULL(adr.st, '') AS st,
			ISNULL(adr.zip, 0) AS zipCode,
			ISNULL(adr.mapsco, '') AS mapsco

		FROM Addresses adr
			LEFT JOIN LnkAddressMember lam
				ON adr.addressesID = lam.addressesId
			LEFT JOIN Staff stf
				ON lam.memberID = stf.staffID
				AND lam.memberTypeID = stf.memberTypeID

		WHERE stf.staffID = @staffID

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