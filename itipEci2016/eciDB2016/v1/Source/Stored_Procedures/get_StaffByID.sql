/***********************************************************************************************************
Description: Stored Procedure that gets last & first name from the Staff table
	 
Author: 
	Tyrell Powers-Crane 
Date: 
	6.21.16
Change History:
	
************************************************************************************************************/
alter PROCEDURE [dbo].[get_StaffByID]
	@staffID int
	
AS
	BEGIN
		BEGIN TRY

		SELECT staff.*, 
				stafft.staffType, 
				addr.addressesID,
				ISNULL(addr.addressesTypeID, 1),
				ISNULL (addr.address1, ' '),
				ISNULL(addr.address2, ' '),
				ISNULL(addr.city, ' '),
				ISNULL(addr.st, ' '),
				ISNULL(addr.zip, 0),
				ISNULL(addr.mapsco, ' '),
 
				ISNULL(aci.additionalContactInfo, ' ')

			FROM Staff staff 
				LEFT JOIN StaffType stafft ON
					staff.staffTypeID = stafft.staffTypeID
				LEFT JOIN Addresses addr ON
					staff.addressesID = addr.addressesID
				LEFT JOIN AdditionalContactInfo aci ON
					staff.additionalContactInfoID = aci.additionalContactInfoID

			WHERE staffID = @staffID AND Staff.deleted <> 1

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
