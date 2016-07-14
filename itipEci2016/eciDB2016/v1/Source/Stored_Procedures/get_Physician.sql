/***********************************************************************************************************
Description: Stored Procedure to pull physician information from physician table by name
	 
Author: 
	Tyrell Powers-Crane 
Date: 
	6.23.16
Change History:
	
************************************************************************************************************/
ALTER PROCEDURE [dbo].[get_Physician]
	@firstName varchar(25),
	@lastName varchar(25)

AS
	BEGIN
		BEGIN TRY

			SELECT 
					phy.physicianID,
					phy.addressesID,
					phy.additionalContactInfoID,
					ISNULL(title, ' '),
					ISNULL(firstName, ' '),
					ISNULL(lastName, ' '),
					phy.deleted,
					ISNULL(addr.address1, ' '),
					ISNULL(addr.address2, ' '),
					ISNULL(addr.st, ' '), 
					ISNULL(addr.city, ' '),
					ISNULL(addr.zip, 0),
					ISNULL(aci.additionalContactInfo, ' ')

			FROM Physician phy
			LEFT JOIN Addresses addr ON
				phy.addressesID = addr.addressesID
			LEFT JOIN AdditionalContactInfo aci ON
				phy.additionalContactInfoID = aci.additionalContactInfoID

			WHERE  phy.deleted <> 1
				

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
