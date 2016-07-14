/****************************************************************************
Description: Creates stored procedure get_AddressesByFamilyMemberID.
        	
Author: Jennifer M. Graves
        	
Date: 07-14-2016
        	
Change History:
        	
****************************************************************************/
create PROCEDURE [dbo].[get_AddressesByFamilyMemberID]
	@familyMemberID INT

AS
BEGIN
	BEGIN TRY
		SELECT addr.addressesID,
					addr.addressesTypeID,
					ISNULL(addr.addressesTypeID, 1),
					ISNULL (addr.address1, ' '),
					ISNULL(addr.address2, ' '),
					ISNULL(addr.city, ' '),
					ISNULL(addr.st, ' '),
					ISNULL(addr.zip, 0),
					ISNULL(addr.mapsco, ' '),
					fm.familyMemberID,
					fm.familyMemberTypeID,
					ISNULL(fm.firstName, ' '),
					ISNULL(fm.lastName, ' '),
					ISNULL(fm.isGuardian, 1),
					fm.additionalContactInfoID,
					fm.sexID,
					fm.deleted,
					fm.raceID,
					ISNULL(fm.occupation, ' '),
					ISNULL(fm.employer, ' '),
					ISNULL(fm.dob, ' ')

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