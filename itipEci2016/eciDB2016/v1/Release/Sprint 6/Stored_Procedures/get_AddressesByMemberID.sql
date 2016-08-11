/****************************************************************************
Description: Creates stored procedure get_AddressesByMemberID.
        	
Author: Tyrell Powers-Crane
        	
Date: 07-15-2016
        	
Change History:
        	08-09-2016: JMG - Added county column. Updated to select based on memberID as well.
****************************************************************************/
CREATE PROCEDURE [dbo].[get_AddressesByMemberID]
	@memberID INT,
	@memberTypeID INT
AS
BEGIN
	BEGIN TRY
		SELECT addr.addressesID,
				ISNULL(addr.addressesTypeID, 1) AS addressesTypeID,
				ISNULL(addr.address1, ' ') AS address1,
				ISNULL(addr.address2, ' ') AS address2,
				ISNULL(addr.city, ' ') AS city,
				ISNULL(addr.st, ' ') AS st,
				ISNULL(addr.zip, 0) AS zip,
				ISNULL(addr.mapsco, ' ') AS mapsco,
				ISNULL(addr.county, ' ') AS county,
				ISNULL(addrt.addressesType, ' ') AS addressesType,
				ISNULL(mbt.addressesID, 0) AS addressesID,
				ISNULL(mbt.memberTypeID, 1) AS memberTypeID,
				ISNULL(mbt.memberID, 0) AS memberID

				FROM Addresses addr
					LEFT JOIN AddressesType addrt ON
						addr.addressesTypeID = addrt.addressesTypeID
					LEFT JOIN LnkAddressMember  mbt ON
						addr.addressesID = mbt.addressesID

			WHERE mbt.memberID = @memberID AND mbt.memberTypeID = @memberTypeID AND addr.deleted <> 1
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