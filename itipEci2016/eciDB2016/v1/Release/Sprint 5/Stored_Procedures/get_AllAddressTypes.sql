/***********************************************************************************************************
Description: Stored Procedure that retrieves the address type from the AddressType Table
	 
Author: 
	Tyrell Powers-Crane 
Date: 
	7.21.16
Change History:
	
************************************************************************************************************/
CREATE PROCEDURE [dbo].[get_AllAddressTypes]

AS
	BEGIN
		BEGIN TRY

			SELECT ISNULL(addressesType, ' ') AS addressesType,
					ISNULL(addressesTypeID, 0) AS addressesTypeID
			FROM AddressesType

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


