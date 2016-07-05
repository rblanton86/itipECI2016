/***********************************************************************************************************
Description: Stored Procedure that retrieves information from the Addresses Table
	 
Author: 
	Tyrell Powers-Crane 
Date: 
	6.22.16
Change History:
	
************************************************************************************************************/
CREATE PROCEDURE [dbo].[get_Addresses]
	@addressesID int


AS
	BEGIN
		BEGIN TRY

			SELECT addr.*, 
					addrt.addressesType

				FROM Addresses addr
					LEFT JOIN AddressesType addrt ON
						addr.addressesTypeID = addrt.addressesTypeID

			WHERE addressesID = @addressesID

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



