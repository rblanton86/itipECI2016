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

			SELECT 
					phy.physicianID,
					phy.addressesID,
					phy.additionalContactInfoID,
					ISNULL(title, ' ') AS title,
					ISNULL(firstName, ' ') AS firstName,
					ISNULL(lastName, ' ') AS lastName,
					ISNULL(phy.deleted, 0) AS deleted,
					ISNULL(addr.address1, ' ') AS address1,
					ISNULL(addr.address2, ' ') AS address2,
					ISNULL(addr.st, ' ') AS st,
					ISNULL(addr.city, ' ') AS city,
					ISNULL(addr.zip, 0) AS zip,
					ISNULL(aci.additionalContactInfo, ' ') AS additionalContactInfo

			FROM Physician phy
			LEFT JOIN Addresses addr ON
				phy.addressesID = addr.addressesID
			LEFT JOIN AdditionalContactInfo aci ON
				phy.additionalContactInfoID = aci.additionalContactInfoID

			WHERE  (firstName = @firstName) AND (lastName = @lastName) AND phy.deleted <> 1 
				

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
