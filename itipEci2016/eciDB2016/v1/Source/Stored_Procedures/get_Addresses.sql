/***********************************************************************************************************
Description: Stored Procedure that retrieves information from the Addresses Table
	 
Author: 
	Tyrell Powers-Crane 
Date: 
	6.22.16
Change History:
	
************************************************************************************************************/
ALTER PROCEDURE [dbo].[get_Addresses]
	@addressesID int


AS
	BEGIN
		BEGIN TRY

			SELECT addr.addressesID,
					ISNULL(addr.addressesTypeID, 1) AS addressesTypeID,
					ISNULL (addr.address1, ' ') AS address1,
					ISNULL(addr.address2, ' ') AS address2,
					ISNULL(addr.city, ' ') AS city,
					ISNULL(addr.st, ' ') AS st,
					ISNULL(addr.zip, 0) AS zip,
					ISNULL(addr.mapsco, ' ') AS mapsco,
					ISNULL(addrt.addressesType, ' ') AS addressesType

				FROM Addresses addr
					LEFT JOIN AddressesType addrt ON
						addr.addressesTypeID = addrt.addressesTypeID

			WHERE addressesID = @addressesID AND deleted <> 1

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



