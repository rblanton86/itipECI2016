/****************************************************************************
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
		SELECT addr.*,
			fm.*

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