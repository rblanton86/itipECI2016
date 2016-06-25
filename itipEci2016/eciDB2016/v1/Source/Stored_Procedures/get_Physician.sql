/***********************************************************************************************************
Description: Stored Procedure to pull physician information from physician table by name
	 
Author: 
	Tyrell Powers-Crane 
Date: 
	6.23.16
Change History:
	
************************************************************************************************************/
CREATE PROCEDURE [dbo].[get_Physician]
	@firstName varchar(25),
	@lastName varchar(25)

AS
	BEGIN
		BEGIN TRY

			SELECT phy.*,
					addr.address1, addr.address2, addr.st, addr.city, addr.zip,
					aci.additionalContactInfo

			FROM Physician phy
			LEFT JOIN Addresses addr ON
				phy.addressesID = addr.addressesID
			LEFT JOIN AdditionalContactInfo aci ON
				phy.additionalContactInfoID = aci.additionalContactInfoID
				

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
