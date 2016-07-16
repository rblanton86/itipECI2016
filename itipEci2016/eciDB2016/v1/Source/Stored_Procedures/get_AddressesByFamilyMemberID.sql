﻿/****************************************************************************
Description: Creates stored procedure get_AddressesByFamilyMemberID.
        	
Author: Jennifer M. Graves
        	
Date: 07-14-2016
        	
Change History:
        	
****************************************************************************/
CREATE PROCEDURE [dbo].[get_AddressesByFamilyMemberID]
	@familyMemberID INT

AS
BEGIN
	BEGIN TRY
		SELECT addr.addressesID,
					ISNULL(addr.addressesTypeID, 1) AS addressesTypeID,
					ISNULL(addr.addressesTypeID, 1) AS addressesTypeID,
					ISNULL (addr.address1, ' ') AS address1,
					ISNULL(addr.address2, ' ') AS address2,
					ISNULL(addr.city, ' ') AS city,
					ISNULL(addr.st, ' ') AS st,
					ISNULL(addr.zip, 0) AS zip,
					ISNULL(addr.mapsco, ' ') AS mapsco,
					ISNULL(fm.familyMemberID, 1) AS familyMemberID,
					ISNULL(fm.familyMemberTypeID, 1) AS familyMemberTypeID,
					ISNULL(fm.firstName, ' ') AS firstName,
					ISNULL(fm.lastName, ' ') AS lastName,
					ISNULL(fm.isGuardian, 1) AS isGuardian,
					ISNULL(fm.additionalContactInfoID, 1) AS additionalContactInfoID,
					ISNULL(fm.sexID, 1) AS sexID,
					fm.deleted,
					ISNULL(fm.raceID, 1) AS raceID,
					ISNULL(fm.occupation, ' ') AS occupation,
					ISNULL(fm.employer, ' ') AS employer,
					ISNULL(fm.dob, ' ') AS dob

		FROM Addresses addr
			LEFT JOIN LnkAddressesFamily lnk
				ON addr.addressesID = lnk.addressesID
			LEFT JOIN FamilyMember fm
				ON fm.familyMemberID = lnk.familyID

		WHERE fm.familyMemberID = @familyMemberID
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